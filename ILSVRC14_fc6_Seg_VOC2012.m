clear; clc; caffe('set_device',1);
rcnn_model = rcnn_create_model(1,'./model-defs/VGG_ILSVRC_19_layers_batch_1_fc6.prototxt', './data/caffe_nets/VGG_ILSVRC_19_layers.caffemodel');
rcnn_model = rcnn_load_model(rcnn_model);
rcnn_model.detectors.crop_mode = 'wrap';
rcnn_model.detectors.crop_padding = 16;

for i = 1:213988
  fprintf('Extract Seg Features: #%d\n', i);
  im = imread(['/home/zengsheng/VOC2012_trainvaltest_mask/' num2str(i) '.bmp']);
  VOC2012_All(i,:) = rcnn_features(im, [1,1,size(im,2),size(im,1)], rcnn_model);
end

save('VOC2012_All.mat','VOC2012_All','-v7.3'); exit;
