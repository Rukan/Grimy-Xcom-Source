class XComSkeletalMeshActorMAT extends SkeletalMeshActorMAT
	native(Core)
	placeable;

var(XComCharacters) string CharacterPoolSelection<DynamicList = "CharacterList">;

cpptext
{
	virtual void PostEditChangeProperty(FPropertyChangedEvent& PropertyChangedEvent);
	virtual void GetDynamicListValues(const FString& ListName, TArray<FString>& Values);
}

defaultproperties
{

}