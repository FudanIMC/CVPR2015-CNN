rcnn_model = rcnn_create_model(1,'./model-defs/ilsvrc_batch_256_output_fc7.prototxt', './data/caffe_nets/ilsvrc_2014_train_iter_610k');
rcnn_model = rcnn_load_model(rcnn_model);
rcnn_model.detectors.crop_mode = 'wrap';
rcnn_model.detectors.crop_padding = 16;

for i = 1:52474
  fprintf('Extract Seg Features: #%d\n', i);
  im = imread(['./datasets/Seg/' num2str(i) '.bmp']);
  SiftFlow_Seg(i,:) = rcnn_features(im, [1,1,size(im)], rcnn_model);
end
