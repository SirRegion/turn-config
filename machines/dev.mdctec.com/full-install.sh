echo "Running setup script for 'dev.mdctec.com' machine"

include_files=(
  'install-make.apt.sh'
  'install-powershell.snap.sh'
)

for script_file in ${include_files[*]}
do
  echo "applying script '$script_file'"
  source <(curl -s "http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/bash/$script_file?job=artifacts")
  echo "done with '$script_file'"
done
