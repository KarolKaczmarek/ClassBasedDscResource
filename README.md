# ClassBasedDscResource
Sample PowerShell class based DSC resource

## Deployment

* Create a module folder under $pshome\Modules or $env:SystemDrive\Program Files\WindowsPowerShell\Modules. You do not need to create DSCResource subfolder.
```PowerShell
md SampleClassBasedResource
```
* Copy the MyDscResource.psm1 and MyDscResource.psd1 to MyDscResource folder.

## Run configuration

```PowerShell
PS C:\git\SampleClassBasedResource\Examples> .\SampleClassBasedResourceConfiguration.ps1
PS C:\git\SampleClassBasedResource\Examples> Start-DscConfiguration -path .\SampleClassBasedResourceConfiguration -wait
-verbose
```
test
