clear; close all; clc; BBox=[]; load('VOC2007_Regions.mat');
List = importdata('./datasets/VOC2007/List.txt');

%caffe('set_device',2); 
%rcnn_model = rcnn_create_model(55,'./model-defs/VGG_ILSVRC_19_layers_batch_55_fc6.prototxt', './data/caffe_nets/VGG_ILSVRC_19_layers.caffemodel');
%rcnn_model = rcnn_load_model(rcnn_model);
%rcnn_model.detectors.crop_mode = 'wrap';
%rcnn_model.detectors.crop_padding = 16;

% Test the 'fast' version, which takes around 5 seconds in mean
% [candidates_mcg, ucm2_mcg] = im2mcg(im,'fast');

% Test the 'accurate' version, which tackes around 30 seconds in mean
% [candidates_mcg, ucm2_mcg] = im2mcg(im,'accurate');

cooc = zeros(20,20);

for i=1:422
  im = imread(['./datasets/VOC2007/Images/' List{i} '.png']); 
  fprintf('Extract %d Train Feature\n',i); 
  load(['./datasets/VOC2007/MCG/' List{i} '.mat']);
  load(['./datasets/VOC2007/MCG_RCNN/' List{i} '.mat']);
  X_tst = feat; Y_tst = ones(1,size(X_tst,1))'; bboxes = []; 
  %feat = rcnn_features(im, boxes, rcnn_model);
  %save(['./datasets/VOC2007/MCG_RCNN/' List{i} '.mat'],'boxes','feat','-v7.3');
  for k=2:21
    if (VOC2007_TrainY(i,k))
      [X,Y,Z] = predict(Y_tst,sparse(double(X_tst)),SVM_model(k));
      Regions = [boxes,X]; Regions = sortrows(Regions,-5); 
      N_Regions = size(find(Regions(:,5)==1),1);
      bboxes(k-1,:) = vl_gmm(Regions(1:N_Regions,1:4)',1)';
      for j=2:k-1
        if (VOC2007_TrainY(i,j))
          cooc(j-1,k-1) = cooc(j-1,k-1) + boxoverlap(bboxes(j-1,:),bboxes(k-1,:));
        end
      end
    end
  end
  %showboxes(im,bboxes(:,2:5),'g');
  %BBox = [BBox; bboxes];
end
%save(['./datasets/VOC2007/BBox.mat'],'','BBox','-v7.3');

LabelCount = zeros(1,4);
for i=1:422
  Current = sum(VOC2007_TrainY(i,:)) - 1;
  if (Current) LabelCount(Current) = LabelCount(Current) + 1; end
end
TrainLabelCount = LabelCount

LabelCount = zeros(1,5);
for i=1:210
  Current = sum(VOC2007_TestY(i,:)) - 1;
  if (Current) LabelCount(Current) = LabelCount(Current) + 1; end
end
TestLabelCount = LabelCount

k=4;
for i=1:422
  Current = sum(VOC2007_TrainY(i,:)) - 1;
  if (Current==k) fprintf('Total %d Labels: #%d\n',k,i); end
end
