﻿<#
    We're gonna code an ArgumentTransformationAttribute live!
#>

# The attribute base class and some other stuff we need is
# in here; this will save us some keystrokes.
using namespace System.Management.Automation

class ProviderItemTransformAttribute : ArgumentTransformationAttribute {

    [object] Transform([EngineIntrinsics] $Intrinsics, [object] $Item) {

        throw [NotImplementedException]::new()

    }

}

function Get-TransformedItemLength {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ProviderItemTransform()]
        [System.IO.FileSystemInfo]
        $Path
    )

    $Path.Length
}

# Demonstration
Get-TransformedItemLength -Path .\README.md

<#
    - All the weird stuff is handled by a class outside the function.
    - We can then re-use this to cut down on duplicated code.
    - 1 (one) attribute removes the need for one or possibly multiple helper functions.
    - Everything is handled DURING parameter binding, therefore...
    - If input can't be handled, we can skip instantiating later pipeline commands.
#>
