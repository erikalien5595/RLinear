export CUDA_VISIBLE_DEVICES=0,1,2,3
gpu=1

if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi
seq_len=336
pred_len=96
for pred_len in 96 192 336 720
do
python -u run.py \
  --is_training 1 \
  --model RLinear \
  --root_path ./dataset/ETT-small/ \
  --data_path ETTm2.csv \
  --model_id ETTm2'_'$seq_len'_'$pred_len \
  --data ETTm2 \
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
  --root_path ./dataset/ETT-small/ \
  --data_path ETTm2.csv \
  --model_id ETTm2'_'$seq_len'_'$pred_len \
  --data ETTm2 \
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