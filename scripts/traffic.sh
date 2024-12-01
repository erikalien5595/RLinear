export CUDA_VISIBLE_DEVICES=0,1,2,3
gpu=0

if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi
root_path_name=./dataset/traffic/
data_path_name=traffic.csv
model_id_name=Traffic # 如果是聚类后的模型，model_id_name后面再加上_cluster
data_name=custom
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
  --channel 862 \
  --batch_size 32 \
  --rev \
  --seq_len $seq_len \
  --pred_len $pred_len \
  --learning_rate 0.001 \
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
  --channel 862 \
  --batch_size 32 \
  --rev \
  --seq_len $seq_len \
  --pred_len $pred_len \
  --learning_rate 0.001 \
  --individual \
  --des 'individual' \
  --gpu $gpu \
  --itr 1
done