cd $(dirname $0)

directory=$(pwd)
osascript -e "tell app \"terminal\" to do script \"cd $directory; python ./display_regression.py\""
osascript -e "tell app \"terminal\" to do script \"cd $directory; python ./display_predictions.py\""