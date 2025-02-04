addpath('selective_search');
addpath('selective_search/SelectiveSearchCodeIJCV');
addpath('selective_search/SelectiveSearchCodeIJCV/Dependencies');
addpath('vis');
addpath('utils');
addpath('bin');
addpath('nms');
addpath('finetuning');
addpath('bbox_regression');
addpath('external/caffe/matlab/caffe');
addpath('external/liblinear/matlab');
addpath('experiments');
addpath('imdb');
addpath('vis/pool5-explorer');
addpath('examples');
addpath('rcnn');
addpath('localize');
addpath('external/caffe');
addpath('external/pLSA');
addpath('external/VOCcode');
run('external/vlfeat/toolbox/vl_setup')
cd external/MCG
install
cd ../../
maxNumCompThreads(32);
setenv('OMP_NUM_THREADS','32');
fprintf('Startup Done\n');
