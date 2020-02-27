#!/bin/sh

#  firim_upload.sh
#  CoderHG
#
#  Created by hong.zhu on 2020/02/23.
#  Copyright © 2020 CoderHG. All rights reserved.

## !!!需要先安装 fir-cli : gem install fir-cli

## $1 : 上传文件路径
uploadfFilePath=$1

## $2 : 上传备注
uploadfRemark=$2

## fir.im token (通常这个写死就行, 也可以通过参数决定)
firToken=$3

echo 'fir.im 开始 上船 中...'

## fir.im 开始上船
firimResult=$(fir publish -T $firToken $uploadfFilePath -c $uploadfRemark)

echo 'fir.im 上船日志 开始'
echo $firimResult
echo 'fir.im 上船日志 结束'

## 获取 fir.im 的地址
fir_address=$(echo $firimResult | grep -Eo "Published succeed: (.*?) I")
## 字符截取
fir_address=$(echo ${fir_address% *})
fir_address=$(echo ${fir_address##* })

## 获取对应版本的 release_id
release_id=$(echo $firimResult | grep -Eo "Release id is (.*?) I")
## 字符截取
release_id=$(echo ${release_id% *})
release_id=$(echo ${release_id##* })

## 拼接本次提交的地址
full_path=$fir_address'?release_id='$release_id

## 文件类型: apk || ipa
extension=${uploadfFilePath##*.}

## 设置 descroption (可以是更丰富的内容显示)
echo "DescroptionStart$extension <a href=\"$full_path\">下载地址：$fir_address</a>DescroptionEnd"
