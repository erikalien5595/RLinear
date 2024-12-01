export CUDA_VISIBLE_DEVICES=0,1,2,3
gpu=0

if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi
seq_len=96
pred_len=96
python -u run.py \
  --is_training 1 \
  --model RLinear \
  --root_path ./dataset/weather/ \
  --data_path weather.csv \
  --model_id Weather'_'$seq_len'_'$pred_len \
  --data custom \
  --individual \
  --features M \
  --channel 21 \
  --batch_size 128 \
  --rev \
  --seq_len 336 \
  --pred_len 96 \
  --learning_rate 0.005 \
  --des 'individual' \
  --gpu $gpu \
  --itr 1 \


