// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Windows/MinWindows.h"
#include "Components/Image.h"
#include "Components/Widget.h"
#include <string>
#include <fstream>
#include <iostream>
#include "GameFramework/Actor.h"
#include "C:\Program Files\Epic Games\UE_4.27\Engine\Plugins\Marketplace\RuntimeAudioImporter\Source\RuntimeAudioImporter\Public\Sound\ImportedSoundWave.h"
#include "Kismet/GameplayStatics.h"
#include "Components/Button.h"
#include "StimulusActor.generated.h"

UCLASS()
class SIMONTEST1_API AStimulusActor : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	AStimulusActor();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:	

	int counter;
	int timer;
	int num_frames;
	int max_frames;
	LARGE_INTEGER stimTime;
	LARGE_INTEGER startTime;
	LARGE_INTEGER fpsTime;
	double startTime_s;
	double currenttime_s;
	LARGE_INTEGER currentTime;
	double performanceFrequency;

	int stimNum;
	int size;

	int numFlashes;

	bool highSet;
	bool lowSet;

	double* onset_times;
	double* offset_times;

	std::ofstream file;
	std::ofstream fps_file;

	float PassedTime;

	FLinearColor BLACK = FLinearColor(0.0f, 0.0f, 0.0f, 1.0f);
	FLinearColor WHITE = FLinearColor(1.0f, 1.0f, 1.0f, 1.0f);

	UImage* stimulus;

	UImportedSoundWave* currentAudio;

	bool stimOn;

	double fps;

	UButton* currentButton;

	// Called every frame
	virtual void Tick(float DeltaTime) override;

	UFUNCTION(BlueprintCallable, Category = "Photodiode Stimulus")
		virtual void Setup(int frames, UImage* stim, FString fname);

	UFUNCTION(BlueprintCallable, Category = "Photodiode Stimulus")
		virtual void Teardown();

	UFUNCTION(BlueprintCallable, Category = "Photodiode Stimulus")
		virtual void setHighStim(UButton * button, FString color, FString position, FString soundName, UImportedSoundWave* sound, float expected_delay, bool record);

	UFUNCTION(BlueprintCallable, Category = "Auditory Stimulus")
		virtual void setHighAudio(FString sound);

	UFUNCTION(BlueprintCallable, Category = "Photodiode Stimulus")
		virtual void setLow();

	UFUNCTION(BlueprintCallable, Category = "Handle Button Press")
		virtual void animateButton(UButton* button, UImportedSoundWave* sound);

	//UFUNCTION(BlueprintCallable, Category = "Handle Button Press")
		//virtual void deanimateButton(UButton* button);

	double toSeconds(int64_t val) {
		return val / performanceFrequency;
	}

};
