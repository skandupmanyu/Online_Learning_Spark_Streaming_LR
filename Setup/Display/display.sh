cd $(dirname $0)

osascript -e 'tell app "Terminal"
    do script "python /Users/skand/Documents/Hadoop/OnlineLearning/Setup/Display/display_regression.py"
end tell'

osascript -e 'tell app "Terminal"
    do script "python /Users/skand/Documents/Hadoop/OnlineLearning/Setup/Display/display_predictions.py"
end tell'

