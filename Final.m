train_urls = h5read('eee443_project_dataset.h5','/train_url');
train_image_ids = h5read('eee443_project_dataset.h5', '/train_imid');
train_cap = h5read('eee443_project_dataset.h5', '/train_cap')+1;
feature_vec_train_ims = h5read('eee443_project_dataset.h5', '/train_ims');

word_key = h5read('eee443_project_dataset.h5', '/word_key');

test_urls = h5read('eee443_project_dataset.h5','/train_url');
test_image_ids = h5read('eee443_project_dataset.h5', '/train_imid');
test_cap = h5read('eee443_project_dataset.h5', '/train_cap')+1;
feature_vec_test_ims = h5read('eee443_project_dataset.h5', '/test_ims');

% %%
% %Data preparation: Exctract labels from the captions using idf metric.
% n_total_files = size(train_cap,2);
% dict = (1:size(word_key.id_2_word,2));
% idfs = zeros(size(word_key.id_2_word,2),1);
% 
% for i=  1:size(dict,2)
%     cur_word = dict(i);
%     [I,J] = find(train_cap == cur_word);
%     included_files = unique(J);
%     idfs(i) = log(n_total_files / (size(included_files,1)+1));
% end



%% 
%Train & Test


%labels (features_size x dictionary_size) is a matrix where each row corresponds to one-hot encoding of unique labels that
%describe the feature.
[labels_train] = extract_labels(feature_vec_train_ims,train_cap,train_image_ids);
[learned_weights1, learned_weights2] = train_label_network(feature_vec_train_ims,labels_train',43200);

[labels_test] = extract_labels(feature_vec_test_ims,test_cap,test_image_ids);
% test_results = predictor(feature_vec_test_ims,learned_weights1,learned_weights2);



%predictor returns a matrix of dimensions testdata_N x 1004. Each row is
%the test results for one data point and each column corresponds to one
%label. So for example instance at row 1 column 1 is a value between 0 and
%1 telling the probability that testimg 1 could be defined with label 1.

%Take max 10(just a magic number) labels from label list of each data img.  Then check if those
%labels exists in test caption of the realted image. If so the test is
%success if not it is not.



%%
%The game


%Use predictor and the learned weights in order to create labels for each
%image in the turn of a game.

