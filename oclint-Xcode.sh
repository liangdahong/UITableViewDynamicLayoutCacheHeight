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
    --\
    -report-type xcode \
    -rc LONG_LINE=200 \
    -disable-rule ShortVariableName \
    -disable-rule ObjCAssignIvarOutsideAccessors \
    -disable-rule AssignIvarOutsideAccessors \
    -max-priority-1=100000 \
    -max-priority-2=100000 \
    -max-priority-3=100000

#    echo "oclint-json-compilation-database"
#    oclint-json-compilation-database \
#    -e Pods \
#    -e Pods \
#    -e Lib  \
#    -e AppDelegate \
#    -- \
#    -stats \
#    -verbose \
#    -report-type xcode \
#    -max-priority-1=99999 -max-priority-2=99999 -max-priority-3=99999 \
#    -rc LONG_LINE=200 \
#    -rc LONG_METHOD=100 \
#    -rc LONG_VARIABLE_NAME=40 \
#    -disable-rule=BrokenOddnessCheck \
#    -disable-rule=VerifyProhibitedCall \
#    -disable-rule=VerifyProtectedMethod \
#    -disable-rule=SubclassMustImplement \
#    -disable-rule=BaseClassDestructorShouldBeVirtualOrProtected \
#    -disable-rule=DestructorOfVirtualClass \
#    -disable-rule=ParameterReassignment \
#    -disable-rule=AvoidDefaultArgumentsOnVirtualMethods \
#    -disable-rule=AvoidPrivateStaticMembers \
#    -disable-rule=TooManyParameters

    # 删除文件
    rm -rf compile_commands.json
# 【 -rc LONG_LINE=200 】 Xcode 中的最长编码限制线条
#    When the number of characters for one line of code is very high, it largely harms the readability. Break long lines of code into multiple lines.
#    简单解释：单行代码太长，影响可读性。
# https://www.jianshu.com/p/e905b5448b2c

# https://oclint-docs.readthedocs.io/en/stable/rules/size.html
# NCSS_METHOD     https://oclint-docs.readthedocs.io/en/stable/rules/size.html
# 方法中的代码行数
# TOO_MANY_PARAMETERS
# 方法参数
}

oclintForProject
