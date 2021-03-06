#!/bin/sh

echo "- Getting latest YaneuraOu..."

if [ -d YaneuraOu/source ]; then
    cd YaneuraOu/source
    make clean > /dev/null
    git pull
else
    git clone --depth 1 https://github.com/yaneurao/YaneuraOu.git
    cd YaneuraOu/source
fi

echo "- Determining CPU architecture..."

ARCH=SSE42

if [ -f /proc/cpuinfo ]; then
    if grep "^flags" /proc/cpuinfo | grep -q avx2 ; then
        ARCH=AVX2
    fi
fi

echo "- Building YANEURAOU $ARCH ... (patience advised)"

make TARGET_CPU=$ARCH YANEURAOU_EDITION=YANEURAOU_ENGINE_NNUE > /dev/null

cd ../..
mv ./YaneuraOu/source/YaneuraOu-by-gcc .

echo "- Done!"
