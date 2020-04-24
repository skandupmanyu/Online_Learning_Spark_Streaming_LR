cd $(dirname $0)

for i in $(cat brew_requirements.txt)
do
  brew install "$i"
done

pip install -r python_requirements.txt