train_urls = h5read('eee443_project_dataset.h5','/train_url');
train_image_ids = h5read('eee443_project_dataset.h5', '/train_imid');
train_cap = h5read('eee443_project_dataset.h5', '/train_cap')+1;
feature_vec_train_ims = h5read('eee443_project_dataset.h5', '/train_ims');

word_key = h5read('eee443_project_dataset.h5', '/word_key');

test_urls = h5read('eee443_project_dataset.h5','/train_url');
test_image_ids = h5read('eee443_project_dataset.h5', '/train_imid');
test_cap = h5read('eee443_project_dataset.h5', '/train_cap')+1;
feature_vec_test_ims = h5read('eee443_project_dataset.h5', '/train_ims');

%%
%Data preparation: Exctract labels from the captions using idf.
n_total_files = size(train_cap,2);
dict = (1:size(word_key.id_2_word,2));
idfs = zeros(size(word_key.id_2_word,2),1);
for i=  1:size(dict,2)
    cur_word = dict(i);
    [I,J] = find(train_cap == cur_word);
    included_files = unique(J);
    idfs(i) = log(n_total_files / (size(included_files,1)+1));
end

