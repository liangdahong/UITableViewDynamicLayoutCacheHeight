#!/bin/bash

COLOR_ERR="\033[1;31m"    #出错提示
COLOR_SUCC="\033[0;32m"  #成功提示
COLOR_QS="\033[1;37m"  #问题颜色
COLOR_AW="\033[0;37m"  #答案提示
COLOR_END="\033[1;34m"     #颜色结束符

# 寻找项目的 ProjectName
function searchProjectName () {
  # maxdepth 查找文件夹的深度
  find . -maxdepth 1 -name "*.xcodeproj"
}

function oclintForProject () {

    # 预先检测所需的安装包是否存在
    if which xcodebuild 2>/dev/null; then
        echo 'xcodebuild exist'
    else
        echo '❌❌❌ xcodebuild 都没有安装'
    fi

    if which oclint 2>/dev/null; then
        echo 'oclint exist'
    else
        echo '❌❌❌  oclint 未安装'
    fi
    if which xcpretty 2>/dev/null; then
        echo 'xcpretty exist'
    else
        gem install xcpretty
    fi

    # 指定编码
    export LANG="zh_CN.UTF-8"
    export LC_COLLATE="zh_CN.UTF-8"
    export LC_CTYPE="zh_CN.UTF-8"
    export LC_MESSAGES="zh_CN.UTF-8"
    export LC_MONETARY="zh_CN.UTF-8"
    export LC_NUMERIC="zh_CN.UTF-8"
    export LC_TIME="zh_CN.UTF-8"
    export xcpretty=/usr/local/bin/xcpretty # xcpretty 的安装位置可以在终端用 which xcpretty找到

    searchFunctionName=`searchProjectName`
    path=${searchFunctionName}
    # 字符串替换函数。//表示全局替换 /表示匹配到的第一个结果替换。
    path=${path//.\//}  # ./BridgeLabiPhone.xcodeproj -> BridgeLabiPhone.xcodeproj
    path=${path//.xcodeproj/} # BridgeLabiPhone.xcodeproj -> BridgeLabiPhone

    myworkspace=$path".xcworkspace" # workspace名字
    myscheme=$path  # scheme名字

    # 先清除
    xcodebuild -scheme $myscheme -workspace $myworkspace  clean

    # 编译
    xcodebuild -scheme $myscheme -workspace $myworkspace -configuration Debug | xcpretty -r json-compilation-database -o compile_commands.json

    # 生成报表
    oclint-json-compilation-database  \
    -e Pods   \
    -e Lib \
    -e AppDelegate \
    -e Classes -- \
    -report-type html >> $myscheme".html" \
    -rc LONG_LINE=200 \
    -disable-rule ShortVariableName \
    -disable-rule ObjCAssignIvarOutsideAccessors \
    -disable-rule AssignIvarOutsideAccessors \
    -max-priority-1=100000 \
    -max-priority-2=100000 \
    -max-priority-3=100000
    
    if [ -f ./$myscheme".html" ]; then
        echo -e $COLOR_SUCC'✅✅✅分析完毕'$COLOR_SUCC
    else
        echo -e $COLOR_ERR'❌❌❌分析失败'$COLOR_ERR
        return -1
    fi
    echo -e $COLOR_AW'将要自动打开 lint 的分析结果'$COLOR_AW

    # 归档文件
    name=$(date +%Y-%m-%d-%H%M%S)
    OCLint="OCLint"
    mkdir $OCLint
    cd $OCLint
    mkdir $name
    cd ..
    cp -r ./$myscheme".html"  ./OCLint/$name
    cp -r ./compile_commands.json  ./OCLint/$name

    # 删除文件
    rm -rf ./$myscheme".html"
    rm -rf ./compile_commands.json
    
    # 用 safari 浏览器打开 oclint 的结果
    open -a "/Applications/Safari.app" ./OCLint/$name/$myscheme".html"
}

oclintForProject
