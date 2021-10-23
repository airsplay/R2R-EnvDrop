# Code and Data for Paper "Learning to Navigate Unseen Environments: Back Translation with Environmental Dropout" 

**Please move to our new code base under CLIP-ViL: [https://github.com/clip-vil/CLIP-ViL/tree/master/CLIP-ViL-VLN](https://github.com/clip-vil/CLIP-ViL/tree/master/CLIP-ViL-VLN). The code logical is the same but the results are much higher with CLIP features (+6% success rate on [R2R](https://bringmeaspoon.org/)). We also provide the [RxR](https://github.com/google-research-datasets/RxR) training script there.**

## Update note about PyTorch version (2021-06)
The original results of 52% on val-unseen are produced with a specific version of PyTorch 0.4.x (see [issue](https://github.com/airsplay/R2R-EnvDrop/issues/17#issuecomment-595588756)).
We are aware of that the results are stablely lower than 52% (around 51%) with PyTorch 0.8~1.2.

With **PyTorch 1.7.1** and exactly the same code/script in this Github, the results magically, supersingly, and unreasonablely reach back to **53.5%** in accuracy. Here is the full log:
```
val_unseen Iter 139100 ,
train , nav_error: 0.681, oracle_error: 0.490, steps: 25.227, lengths: 10.059, success_rate: 0.936, oracle_rate: 0.959, spl: 0.918, 
val_seen , nav_error: 3.804, oracle_error: 2.414, steps: 27.729, lengths: 10.897, success_rate: 0.655, oracle_rate: 0.735, spl: 0.624, 
val_unseen , nav_error: 5.067, oracle_error: 3.324, steps: 32.378, lengths: 12.098, success_rate: 0.535, oracle_rate: 0.607, spl: 0.488
```
These results conclude the two-year question that PyTorch version might have a largely influence, and the answer is True. I would like to share this information to you so everyone could keep an eye on the PyTorch version. 


## Environment Installation
Download Room-to-Room navigation data:
```
bash ./tasks/R2R/data/download.sh
```

Download image features for environments:
```
mkdir img_features
wget https://www.dropbox.com/s/o57kxh2mn5rkx4o/ResNet-152-imagenet.zip -P img_features/
cd img_features
unzip ResNet-152-imagenet.zip
```

Python requirements: Need python3.6 (python 3.5 should be OK since I removed the allennlp dependencies)
```
pip install -r python_requirements.txt
```

Install Matterport3D simulators:
```
git submodule update --init --recursive 
sudo apt-get install libjsoncpp-dev libepoxy-dev libglm-dev libosmesa6 libosmesa6-dev libglew-dev
mkdir build && cd build
cmake -DEGL_RENDERING=ON ..
make -j8
```

## Code

### Speaker
```
bash run/speaker.bash 0
```
0 is the id of GPU. It will train the speaker and save the snapshot under snap/speaker/

### Agent
```
bash run/agent.bash 0
```
0 is the id of GPU. It will train the agent and save the snapshot under snap/agent/. Unseen success rate would be around 46%.

### Agent + Speaker (Back Translation)
After pre-training the speaker and the agnet,
```
bash run/bt_envdrop.bash 0
```
0 is the id of GPU. 
It will load the pre-trained agent and run back translation with environmental dropout.

Currently, the result with PyTorch 1.1 is a little bit lower than my NAACL reported number. It still easily reaches a success rate of 50% (+4% from w/o back translation).



### Implementation Details
1. When training the speaker and listener, we drop out features as much as we can. It means that the image feature are dropped randomly (with a smaller dropout rate), which has been seen used in multiple vision papers. 
2. The ml\_weight is increased in using back translation, since the quality of generated sentence is not high and RL would be misled.
3. Instead of training with augmented data and fine-tuning with training data, we trained them together. 


## Semantic Views
As shown in Fig.6 of our paper which is the same to 
```
semantic_views/17DRP5sb8fy/10c252c90fa24ef3b698c6f54d984c5c/14.png 
```
![semantic](semantic_views/17DRP5sb8fy/10c252c90fa24ef3b698c6f54d984c5c/14.png?raw=true)
![rgb](semantic_views/17DRP5sb8fy/10c252c90fa24ef3b698c6f54d984c5c_rgb/14.jpg?raw=true)

in this repo, we rendered semantic views from [Matterport3D dataset](https://niessner.github.io/Matterport/). We provide a preview of semantic views and rgb views under the forder `semantic_views`.

To access the full rendered data, please first sign the Terms of Use agreement form in <https://github.com/niessner/Matterport> and cc' the email to us <haotan@cs.unc.edu>. And we would share a download link. 

Thanks to the one who teaches me how to calibrate camera. Note that there would be a small pixel-level disagreement between the RGB view and semantic view, since the semantic view are rendered from 3D annotations while the RGB view are rendered from skyboxes. We are still aiming in solving it.

## TODO's
1. Provide test script for beam search. (Code is in `train.py` and `agent.py`)
2. Release pre-trained snapshots.
3. Check PyTorch 1.1 configurations.
4. Update pip requirement with version specifications.

