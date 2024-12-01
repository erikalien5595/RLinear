export CUDA_VISIBLE_DEVICES=0,1,2,3
gpu=3

if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi
root_path_name=./dataset/ETT-small/
data_path_name=ETTh2.csv
model_id_name=ETTh2 # 如果是聚类后的模型，model_id_name后面再加上_cluster
data_name=ETTh2
seq_len=336
pred_len=96
for pred_len in 96 192 336 720
do
python -u run.py \
  --is_training 1 \
  --model RLinear \
  --root_path $root_path_name \
  --data_path $data_path_name \
  --model_id $model_id_name'_'$seq_len'_'$pred_len \
  --data $data_name \
  --features M \
  --channel 7 \
  --batch_size 128 \
  --rev \
  --seq_len $seq_len \
  --pred_len $pred_len \
  --learning_rate 0.005 \
  --des 'share' \
  --gpu $gpu \
  --itr 1

python -u run.py \
  --is_training 1 \
  --model RLinear \
  --root_path $root_path_name \
  --data_path $data_path_name \
  --model_id $model_id_name'_'$seq_len'_'$pred_len \
  --data $data_name \
  --features M \
  --channel 7 \
  --batch_size 128 \
  --rev \
  --seq_len $seq_len \
  --pred_len $pred_len \
  --learning_rate 0.005 \
  --individual \
  --des 'individual' \
  --gpu $gpu \
  --itr 1
done