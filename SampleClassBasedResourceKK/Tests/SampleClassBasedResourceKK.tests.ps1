$testDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path 
$testFileName = Split-Path -Leaf $MyInvocation.MyCommand.Path
$moduleName = $testFileName.Replace(".tests.", ".")
$moduleName = $moduleName.Replace("ps1", "psm1")

Import-Module "$testDirectory\..\$moduleName" -Force

Describe "SampleClassBasedResource" {
    $expectedContents = "test content"
    $sourcePath = "$env:SystemDrive\temp.txt"
    $destinationPath = "$env:SystemDrive\test\temp.txt"
    New-Item -Path $sourcePath -Type File -Force
    Set-Content -Path $sourcePath -Value $expectedContents

    $resource = New-FileResource
    $resource.Path = $destinationPath
    $resource.SourcePath = $sourcePath
    $resource.Ensure = "Present"

    Context "Set method" {

        if (Test-Path $destinationPath) {
            Remove-Item -Path $destinationPath -Recurse -Force
        }

        $resource.Set()

        It "Creates file" {
            $exists = Test-Path $destinationPath
            $exists | Should be $true
        }

        It "Creates correct contents" {
            $contents = Get-Content $destinationPath
            $contents | Should be $expectedContents
        }

    }

    Context "Get method" {
        $getResult = $resource.Get()

        It "Returns expected properties" {
            $getResult.Ensure | Should be "Present"
            $getResult.Path | Should be $destinationPath
            $getResult.SourcePath | Should be $sourcePath
        }
    }

    Context "Test method" {
        
        AfterEach {
            if (Test-Path $destinationPath)
            {
                Remove-Item -Path $destinationPath -Recurse -Force
            }
            if (Test-Path $sourcePath)
            {
                Remove-Item -Path $sourcePath -Recurse -Force
            }
        }

        $testResult = $resource.Test()

        It "Returns true when file exists" {
            $testResult | Should be $true
        }

        $testResult = $resource.Test()

        It "Returns false when file does not exist" {
            $testResult | Should be $false
        }
    }
}
