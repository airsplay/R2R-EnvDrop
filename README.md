# Code and Data for Paper "Learning to Navigate Unseen Environments: Back Translation with Environmental Dropout" 

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

