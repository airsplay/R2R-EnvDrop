name=speaker
flag="--attn soft --angleFeatSize 128
      --train speaker
      --subout max --dropout 0.6 --optim adam --lr 1e-4 --iters 1000000 --maxAction 35"
mkdir -p snap/$name
CUDA_VISIBLE_DEVICES=$1 unbuffer python r2r_src/train.py $flag --name $name | tee snap/$name/log
