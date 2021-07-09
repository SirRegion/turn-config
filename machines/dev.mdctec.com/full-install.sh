include_files=(
  'install-make.apt.sh'
)

for script_file in ${include_files[*]}
do
  echo "loading $script_file"
  source <(curl -s "http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/bash/$script_file?job=artifacts")
done
