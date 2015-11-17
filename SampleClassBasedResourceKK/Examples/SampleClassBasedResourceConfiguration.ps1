Configuration SampleClassBasedResourceConfiguration
{
    Import-DSCResource -module SampleClassBasedResourceKK

    File SourceFile
    {
        DestinationPath = "$env:SystemDrive\temp.txt"
        Contents = "test contents"
        Ensure = "Present"
    }

    FileResource NewFile
    {
        Path = "$env:SystemDrive\test\temp.txt"
        SourcePath = "$env:SystemDrive\temp.txt"
        Ensure = "Present"
        DependsOn = "[File]SourceFile"
    } 
}

SampleClassBasedResourceConfiguration 
