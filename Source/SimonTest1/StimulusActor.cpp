// Fill out your copyright notice in the Description page of Project Settings.


#include "StimulusActor.h"

// Sets default values
AStimulusActor::AStimulusActor()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
	SetActorHiddenInGame(true); // make invisible!
	PrimaryActorTick.bCanEverTick = true;
	stimOn = false;
	highSet = false;
	lowSet = false;

}

// Called when the game starts or when spawned
void AStimulusActor::BeginPlay()
{
	Super::BeginPlay();
	
}

std::string convertToString(FString in_str) {
	return std::string(TCHAR_TO_UTF8(*in_str));
}

void AStimulusActor::Setup(int frames, UImage* stim, FString fname) {
	highSet = false;
	lowSet = false;
	counter = 0;
	stimNum = 0;
	stimulus = stim;
	num_frames = frames;
	LARGE_INTEGER freq;
	QueryPerformanceFrequency(&freq);
	performanceFrequency = (double)freq.QuadPart;

	file.open(std::string(TCHAR_TO_UTF8(*FPaths::ProjectDir())) + convertToString(fname) + ".csv", std::ios::app);

	// set up file for storing fps
	//std::string fps_fname = std::string(TCHAR_TO_UTF8(*FPaths::ProjectDir())) + convertToString(fname) + "_fps-log.csv";
	//fps_file.open(fps_fname, std::ios::app);

	if (!file.good()) {
		file.close();
		if (GEngine) {
			GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Issue opening file!!"));
		}
	}

	if (!QueryPerformanceCounter(&startTime)) {
		if (GEngine) {
			GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Unable to query performance counter!"));
		}
	}

	startTime_s = toSeconds(startTime.QuadPart);

	file << stimNum << "," << startTime_s << ",Color,Position,Name,Length,Delay,FPS" << std::endl;

	stimNum++;

	//stimOn = true; // only tick when everything is setup
}

void AStimulusActor::Teardown() {
	stimOn = false; // only tick when everything is setup
	file.close();
}

void AStimulusActor::animateButton(UButton* button, UImportedSoundWave* sound) {

	UGameplayStatics::PlaySound2D(this, sound);
	sound->RewindPlaybackTime(0.0);
	//FLinearColor originalColor = button->BackgroundColor;
	//button->SetBackgroundColor(FLinearColor(originalColor.Component(0), originalColor.Component(1), originalColor.Component(2), 0.2f));
	return;
}


void AStimulusActor::setHighStim(UButton * button, FString color, FString position, FString soundName, UImportedSoundWave * sound, float expected_delay, bool record) {

	currentAudio = sound;
	currentButton = button;
	if (record) { // this is so we can swap between flashing only on first and flashing multiple
		QueryPerformanceCounter(&stimTime);
		file << stimNum << "," << toSeconds(stimTime.QuadPart) - startTime_s << "," << convertToString(color) << "," << convertToString(position) << "," << convertToString(soundName) << "," << sound->GetDuration() << "," << expected_delay << "," << fps << "\n";
	}
	//stimulus->SetVectorParameterValue(FName(TEXT("LightColor")), WHITE);
	//GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("STIMON"));
	if (record) {
		stimulus->SetVisibility(ESlateVisibility::Visible);
		stimOn = true;
	}
	UGameplayStatics::PlaySound2D(this, sound);
	sound->RewindPlaybackTime(0.0);
	FLinearColor originalColor = button->BackgroundColor;
	currentButton->SetBackgroundColor(FLinearColor(originalColor.Component(0), originalColor.Component(1), originalColor.Component(2), 0.2f)); // toggle button

	highSet = true;
	lowSet = false;

}

void AStimulusActor::setHighAudio(FString sound) {
	file << toSeconds(stimTime.QuadPart) - startTime_s << "," << convertToString(sound) << std::endl;
}

void AStimulusActor::setLow() {

	QueryPerformanceCounter(&stimTime);
	//file << toSeconds(stimTime.QuadPart) - startTime_s << std::endl; taking this out because could interfere with audio write

	//stimulus->SetVectorParameterValue(FName(TEXT("LightColor")), BLACK);

	stimulus->SetVisibility(ESlateVisibility::Hidden);

	stimNum++;
	stimOn = false;
	counter = 0;

}

// Called every frame
void AStimulusActor::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

	if (!lowSet) {
		if (currentAudio) {
			if (currentAudio->IsPlaybackFinished()) { // Finish flashing button once sound finishes playing
				FLinearColor originalColor = currentButton->BackgroundColor;
				currentButton->SetBackgroundColor(FLinearColor(originalColor.Component(0), originalColor.Component(1), originalColor.Component(2), 1.0f)); // toggle button
				lowSet = true;
				highSet = false;
			}
		}
	}


	if (stimOn) {


		// otherwise update stimulus stuff
		if (counter < num_frames) {
			++counter;
		}

		else {
			setLow();
		}
	}

	if (DeltaTime <= 0) { // let us know if deltatime is 0 for some weird reason
		GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Yellow, FString(TEXT("DeltaTime <= 0")));
	}

	// record fps
	fps = 1.0 / (double)DeltaTime;
	QueryPerformanceCounter(&fpsTime);

}

