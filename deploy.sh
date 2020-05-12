git checkout source
if [ $? -ne 0 ]
then
    echo "Failed to checkout source branch"; exit 1;
fi

hugo;
if [ $? -ne 0 ]
then
    echo "Failed to  build site"; exit 1;
fi

cp -r public ~/workspace/
if [ $? -ne 0 ]
then
    echo "Failed to copy public"; exit 1;
fi

git checkout master
if [ $? -ne 0 ]
then
    echo "Failed to checkout master branch"; exit 1;
fi

rm -rf ~/workspace/KyleCotton.github.io/*
if [ $? -ne 0 ]
then
    echo "Failed to remove old files"; exit 1;
fi

mv ~/workspace/public/* ~/workspace/KyleCotton.github.io/
if [ $? -ne 0 ]
then
    echo "Failed to copy new files"; exit 1;
fi
