#!/bin/zsh
# 正規表現でマッチしたgitのbranchを削除する関数
# 例）$ ./rmbranch 'issue7.*'
function rmbranch () {
    if [ -z "$1" ] ; then
        echo -e "ブランチ名を正規表現で入力してください. \nex)\n\$ rmbranch 'feature/practice.+'"
        return 1
    fi

    rmTargets=`git branch | egrep "$1"`

    if [ -z "$rmTargets" ] ; then
        echo "削除対象ブランチがないため処理を終了します."
        return 0
    fi

    echo "削除対象ブランチ:"
    echo $rmTargets
    echo "----------------------------"
    echo "ブランチ削除を実行しますか?"
    echo "  実行する場合は y、実行をキャンセルする場合は n と入力して下さい."
    read input

    if [ -z $input ] ; then

        echo "  y または n を入力して下さい."
        rmbranch

    elif [ $input = 'yes' ] || [ $input = 'YES' ] || [ $input = 'y' ] ; then

        echo "  削除を実行します."
        git branch | egrep "$1" | xargs git branch -D

    elif [ $input = 'no' ] || [ $input = 'NO' ] || [ $input = 'n' ] ; then

       echo "  処理をキャンセルしました."
       return 1

    else

        echo "  y または n を入力して下さい."
        rmbranch

    fi

    return 0
}

rmbranch $1
