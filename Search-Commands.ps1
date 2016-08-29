Function Search-Commands
{
<#
.SYNOPSIS
Opens seperate PowerShell help windows for all cmdlets which contain a string matching your regex query in their definition.
.DESCRIPTION
The Search-Commands cmdlet is used to search for a cmdlet related to the task you're attempting to perform.
For example, if you are attempting to work with an xml file and want to know which cmdlets are available that can work with xml,
The command would be PS:> Search-Commands xml.
#>

[cmdletbinding()]
param
    (
    [Parameter(Mandatory=$true,ValueFromPipeline=$false)]
    [string]
    $Key
    )

    $numRes = Get-Command |where{$_.Definition -match $Key}
        if ($numRes.count -ige 10)
            {
            Write-Host "Your query returned"$numRes.count"results"
            [string]$response = Read-Host "Would you like to display all"$numRes.count"results? (y,n)"
        
                if (($response -inotin 'y') -and ($response -inotin 'n'))
                    {
                    Write-Host -ForegroundColor Red "You're trying to break me... now you leave -_-"
                    }

                elseif ($response -ieq 'y')
                    {
                    foreach($name in $numRes.name){get-help $name -ShowWindow}
                    }

                else
                    {
                    return
                    }
            }
        
        elseif ($numRes.count -ieq 0)
            {
            Write-Host -ForegroundColor Green "No results found. Try another search"
            }

        else
            {
            foreach($name in $numRes.name){get-help $name -ShowWindow}
            }
}