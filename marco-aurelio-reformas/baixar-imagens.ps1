<#
    baixar-imagens.ps1
    ------------------
    Baixa as 5 imagens ilustrativas geradas para o site "Marco Aurélio |
    Reformas e Instalações" e salva dentro de assets/images/ com os nomes
    corretos, já usados pelo index.html. Não é necessário editar nenhum
    código manualmente.

    Como usar:
      1. Abra a pasta do projeto no VS Code.
      2. Clique com o botão direito neste arquivo e escolha
         "Executar com PowerShell" (ou abra um terminal PowerShell na
         pasta do projeto e rode:  .\baixar-imagens.ps1 ).
      3. Se o Windows bloquear a execução de scripts, rode antes, no mesmo
         terminal:
            Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
         e então execute o script novamente.
#>

$ErrorActionPreference = "Stop"

# Pasta de destino: assets/images/ dentro da pasta onde este script está.
$scriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$targetDir  = Join-Path $scriptDir "assets\images"

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# Mapa: nome final do arquivo -> URL de origem (CDN da Higgsfield)
$imagens = [ordered]@{
    "hero-reforma.jpg" = "https://d8j0ntlcm91z4.cloudfront.net/user_3IN3bl1s42yZqAclNFM5SD7cWqq/hf_20260827_105605_b38d6318-e6cc-4c51-b8b1-f3f49fba568e.png"
    "drywall.jpg"       = "https://d8j0ntlcm91z4.cloudfront.net/user_3IN3bl1s42yZqAclNFM5SD7cWqq/hf_20260827_105541_5bff0e4c-144a-44d6-981f-24aa8b937dd3.png"
    "alvenaria.jpg"     = "https://d8j0ntlcm91z4.cloudfront.net/user_3IN3bl1s42yZqAclNFM5SD7cWqq/hf_20260827_105547_628665cd-5f48-49a6-9d04-da3c69ac6b5e.png"
    "revestimentos.jpg" = "https://d8j0ntlcm91z4.cloudfront.net/user_3IN3bl1s42yZqAclNFM5SD7cWqq/hf_20260827_105552_ba63e07c-803e-4591-8184-fcdde1e25fab.png"
    "eletrica.jpg"      = "https://d8j0ntlcm91z4.cloudfront.net/user_3IN3bl1s42yZqAclNFM5SD7cWqq/hf_20260827_105558_7466570c-79ca-46f2-ab53-2f31fc1f8118.png"
}

Write-Host "Baixando imagens para: $targetDir" -ForegroundColor Cyan
Write-Host ""

$sucesso = @()
$falha   = @()

foreach ($nome in $imagens.Keys) {
    $url       = $imagens[$nome]
    $destino   = Join-Path $targetDir $nome

    try {
        Write-Host "Baixando $nome ..." -NoNewline
        Invoke-WebRequest -Uri $url -OutFile $destino -UseBasicParsing
        Write-Host " OK" -ForegroundColor Green
    }
    catch {
        Write-Host " FALHOU" -ForegroundColor Red
        Write-Host "   Erro: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Verificando arquivos..." -ForegroundColor Cyan

foreach ($nome in $imagens.Keys) {
    $destino = Join-Path $targetDir $nome
    if ((Test-Path $destino) -and ((Get-Item $destino).Length -gt 0)) {
        $tamanhoKB = [math]::Round((Get-Item $destino).Length / 1KB, 1)
        Write-Host ("  [OK]    {0}  ({1} KB)" -f $nome, $tamanhoKB) -ForegroundColor Green
        $sucesso += $nome
    }
    else {
        Write-Host ("  [FALTA] {0}" -f $nome) -ForegroundColor Red
        $falha += $nome
    }
}

Write-Host ""
if ($falha.Count -eq 0) {
    Write-Host "Todas as 5 imagens foram baixadas com sucesso." -ForegroundColor Green
    Write-Host "O index.html ja aponta para assets/images/ - nenhuma edicao manual e necessaria." -ForegroundColor Green
}
else {
    Write-Host ("Atencao: {0} imagem(ns) nao foram baixadas: {1}" -f $falha.Count, ($falha -join ", ")) -ForegroundColor Yellow
    Write-Host "Verifique sua conexao com a internet e execute o script novamente." -ForegroundColor Yellow
}
