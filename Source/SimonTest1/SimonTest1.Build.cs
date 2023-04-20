// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;

public class SimonTest1 : ModuleRules
{
	public SimonTest1(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
	
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "UMG", "RuntimeAudioImporter" });

		PrivateDependencyModuleNames.AddRange(new string[] { "RuntimeAudioImporter" });

		PrivateIncludePathModuleNames.AddRange(new string[] { "RuntimeAudioImporter" });

		// Uncomment if you are using Slate UI
		// PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" });

		// Uncomment if you are using online features
		// PrivateDependencyModuleNames.Add("OnlineSubsystem");

		// To include OnlineSubsystemSteam, add it to the plugins section in your uproject file with the Enabled attribute set to true
	}
}
