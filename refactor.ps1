$baseDir = "d:\hoc tap\LTM\BTTH\btthb1"
$libDir = "$baseDir\lib"

$dirsToCreate = @(
    "$libDir\core\constants",
    "$libDir\core\error",
    "$libDir\core\network",
    "$libDir\core\routes",
    "$libDir\core\theme",
    "$libDir\core\usecases",
    "$libDir\di",
    "$libDir\features\auth\data\datasources",
    "$libDir\features\auth\data\models",
    "$libDir\features\auth\data\repositories",
    "$libDir\features\auth\domain\entities",
    "$libDir\features\auth\domain\repositories",
    "$libDir\features\auth\domain\usecases",
    "$libDir\features\auth\presentation\pages",
    "$libDir\features\auth\presentation\manager",
    "$libDir\features\auth\presentation\widgets",
    "$libDir\shared\widgets"
)

foreach ($dir in $dirsToCreate) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

if (Test-Path "$libDir\assets") {
    Move-Item -Path "$libDir\assets" -Destination "$baseDir\assets" -Force
}
if (Test-Path "$libDir\app\app_route.dart") {
    Move-Item -Path "$libDir\app\app_route.dart" -Destination "$libDir\core\routes\app_route.dart" -Force
}
if (Test-Path "$libDir\utils\app_colors.dart") {
    Move-Item -Path "$libDir\utils\app_colors.dart" -Destination "$libDir\core\theme\app_colors.dart" -Force
}
if (Test-Path "$libDir\views\Auth") {
    Move-Item -Path "$libDir\views\Auth\*.dart" -Destination "$libDir\features\auth\presentation\pages\" -Force
}
if (Test-Path "$libDir\widgets") {
    Move-Item -Path "$libDir\widgets\*.dart" -Destination "$libDir\shared\widgets\" -Force
}

$dirsToDelete = @(
    "$libDir\app",
    "$libDir\utils",
    "$libDir\views\Auth",
    "$libDir\views",
    "$libDir\widgets",
    "$libDir\models"
)
foreach ($dir in $dirsToDelete) {
    if (Test-Path $dir) {
        Remove-Item -Path $dir -Recurse -Force
    }
}

$pubspecPath = "$baseDir\pubspec.yaml"
if (Test-Path $pubspecPath) {
    $content = [System.IO.File]::ReadAllText($pubspecPath)
    $content = $content.Replace('lib/assets/', 'assets/')
    [System.IO.File]::WriteAllText($pubspecPath, $content)
}

$replacements = @{
    "'../../utils/app_colors.dart'" = "'package:btthb1/core/theme/app_colors.dart'"
    "'../utils/app_colors.dart'" = "'package:btthb1/core/theme/app_colors.dart'"
    "'package:btthb1/utils/app_colors.dart'" = "'package:btthb1/core/theme/app_colors.dart'"
    "'../../widgets/custom_button.dart'" = "'package:btthb1/shared/widgets/custom_button.dart'"
    "'package:btthb1/widgets/custom_button.dart'" = "'package:btthb1/shared/widgets/custom_button.dart'"
    "'../../widgets/custom_text_field.dart'" = "'package:btthb1/shared/widgets/custom_text_field.dart'"
    "'package:btthb1/widgets/custom_text_field.dart'" = "'package:btthb1/shared/widgets/custom_text_field.dart'"
    "'../../app/app_route.dart'" = "'package:btthb1/core/routes/app_route.dart'"
    "'app/app_route.dart'" = "'package:btthb1/core/routes/app_route.dart'"
    "'../views/Auth/splash_view.dart'" = "'package:btthb1/features/auth/presentation/pages/splash_view.dart'"
    "'../views/Auth/onboarding.dart'" = "'package:btthb1/features/auth/presentation/pages/onboarding.dart'"
    "'../views/Auth/login_view.dart'" = "'package:btthb1/features/auth/presentation/pages/login_view.dart'"
    "'../views/Auth/sign_up_view.dart'" = "'package:btthb1/features/auth/presentation/pages/sign_up_view.dart'"
    "'../views/Auth/forgot_pass_view.dart'" = "'package:btthb1/features/auth/presentation/pages/forgot_pass_view.dart'"
    "'../views/Auth/check_email.dart'" = "'package:btthb1/features/auth/presentation/pages/check_email.dart'"
    "'../views/Auth/success_view.dart'" = "'package:btthb1/features/auth/presentation/pages/success_view.dart'"
    "'lib/assets/" = "'assets/"
}

Get-ChildItem -Path $libDir -Recurse -Filter *.dart | ForEach-Object {
    $file = $_.FullName
    $content = [System.IO.File]::ReadAllText($file)
    $modified = $false

    foreach ($key in $replacements.Keys) {
        if ($content.Contains($key)) {
            $content = $content.Replace($key, $replacements[$key])
            $modified = $true
        }
    }

    if ($modified) {
        [System.IO.File]::WriteAllText($file, $content)
    }
}
