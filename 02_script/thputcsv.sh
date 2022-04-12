#######################################################################################
#
# <スクリプト名>
# 温湿度情報スクリプト
#
# <概要>
# 取得した温湿度情報を基に以下の処理を実行する
# - 温湿度情報をデータ(CSV)として出力
#
# <更新履歴>
# 20210906 - 新規作成
# 20220408 - 全体的な処理ロジックを更新
#
#######################################################################################
#!/bin/bash


#####################################################################
## 事前設定
#####################################################################
# 今日の日付を取得
today=$(date "+%Y%m%d")
# 現在の時刻を取得
time=$(date '+%Y/%m/%d %T')
# カレントパスを取得
current_path=$(cd $(dirname $0); pwd)


####################################################################
# パラメータ設定
####################################################################
#設定ファイルから変数を取得
source $current_path/../01_param/common.conf


####################################################################
# 事前準備
####################################################################
# データファイル格納先ディレクトリを作成
if [ ! -d $CsvDir ];then mkdir $CsvDir ;fi


###################################################################
## 温湿度を取得
###################################################################
# 温湿度値取得スクリプトを実行
str_raw=`python $current_path/basicdht22.py`


####################################################################
## 関数：取得した温湿度情報から必要事項を各変数に格納
####################################################################
# -- 設定パラメータ情報 --
# [str_time] = 時刻
# [str_temp] = 温度
# [str_humi] = 湿度
#
####################################################################
function FuncSedTH() {
  # 配列に格納
  ary=(`echo $str_raw`)
  # 配列から要素を抜き出す
  str_time=`echo ${ary[0]}`
  str_temp=`echo ${ary[1]}`
  str_humi=`echo ${ary[2]}`
}


#####################################################################
## 関数：CSVファイルへ取得情報を追記
#####################################################################
function FuncWriteingCsv() {
  echo -e $str_time"\t"$str_temp"*C""\t"$str_humi"%" | tee -a $CsvPath
}


#####################################################################
## メイン処理
#####################################################################
FuncSedTH
FuncWriteingCsv
