# Local preview with live reload: http://127.0.0.1:4000
# First-time setup on a new machine:
#   winget install RubyInstallerTeam.RubyWithDevKit.3.3; ridk install 3
#   bundle config set --local path vendor/bundle; bundle install
$ruby = "C:\Ruby33-x64\bin"
if ((Test-Path $ruby) -and -not ($env:Path -like "*$ruby*")) { $env:Path = "$ruby;$env:Path" }
Set-Location $PSScriptRoot
bundle exec jekyll serve --livereload --force_polling @args
