# Code and Data for Paper "Learning to Navigate Unseen Environments: Back Translation with Environmental Dropout" 

## Environment Installation

python requirements:
```
pip install networkx tensorboardX
```

## Code

### Speaker

### Listener

### Speaker + Listener

## Semantic Views
As shown in Fig.6 of our paper which is the same to 
```
semantic_views/17DRP5sb8fy/10c252c90fa24ef3b698c6f54d984c5c/14.png 
```
![semantic](semantic_views/17DRP5sb8fy/10c252c90fa24ef3b698c6f54d984c5c/14.png?raw=true)
![rgb](semantic_views/17DRP5sb8fy/10c252c90fa24ef3b698c6f54d984c5c_rgb/14.jpg?raw=true)

in this repo, we rendered semantic views from [Matterport3D dataset](https://niessner.github.io/Matterport/). We provide a preview of semantic views and rgb views under the forder `semantic_views`.

To access the full rendered data, please first sign the Terms of Use agreement form in <https://github.com/niessner/Matterport> and cc' the email to us <airsplay@cs.unc.edu>. And we would share a download link. 

Thanks to the one who teaches me how to calibrate camera. Note that there would be a small pixel-level disagreement between the RGB view and semantic view, since the semantic view are rendered from 3D annotations while the RGB view are rendered from skyboxes. We are still aiming in solving it.
