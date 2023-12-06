param(

    [string]$filePath,
    [string]$sortType,
    [string]$sortOrder

)

function Sort-Content {
    param(
        [string]$sortType,
        [string]$sortOrder,
        [object[]]$content
    )
    
        $numericContent = $content | Where-Object { ($_ -as [double]) -ne $null }
        $alphaContent = $content | Where-Object { ($_ -as [double]) -eq $null }

        $numericContent = $numericContent | ForEach-Object { [double]$_ }


    if ($sortOrder -eq 'ascending') {
        $numericContent = $numericContent | Sort-Object 
        $alphaContent = $alphaContent | Sort-Object
    } else {
        $numericContent = $numericContent | Sort-Object -Descending
        $alphaContent = $alphaContent | Sort-Object -Descending
    }

    switch ($sortType) {
        'numeric' { $numericContent }
        'alpha' { $alphaContent }
        'both' { $numericContent + $alphaContent }
    }
}


$content = Get-Content -Path $filePath | ForEach-Object { $_.Split(',') }


$sortedContent = Sort-Content -sortType $sortType -sortOrder $sortOrder -content $content


$sortedContent