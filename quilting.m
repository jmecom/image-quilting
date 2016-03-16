% Parameters
bsize = 16;             % Set by user
overlap_size = bsize/6; % Efros and Freeman
tolerance = 0.1;        % Efros and Freeman

% Open image
im = imread('images/sponge.png');
[im_w, im_h, ~] = size(im);

mri = floor(im_w/bsize) - 1;
mci = floor(im_h/bsize) - 1;

out = uint8(zeros(im_w*2, im_h*2, 3));
[out_w, out_h, ~] = size(out);

% Set the first block at random
out(1:bsize, 1:bsize, :) = get_block(im, bsize, randi(mci), randi(mri));

% Fill in first row
for col = 1:(out_w/bsize)+2
  col_cut = col*bsize:(col+1)*bsize;
  
  if length(col_cut) > bsize
    col_cut = col_cut(1:end-1);
  end
  
  out(1:bsize, col_cut, :) = get_block(im, bsize, randi(mci), randi(mri));
end

% Fill in first column
for row = 1:(out_h/bsize)+2            % TODO: always +2 ? edge case?
  row_cut = row*bsize:(row+1)*bsize;
  
  if length(row_cut) > bsize
    row_cut = row_cut(1:end-1);
  end
  
  out(row_cut, 1:bsize, :) = get_block(im, bsize, randi(mci), randi(mri));
end

% Fill in the rest
for row = 1:(out_h/bsize)+2
  row_cut = row*bsize:(row+1)*bsize;
  
  if length(row_cut) > bsize
    row_cut = row_cut(1:end-1);
  end
  
  for col = 1:(out_w/bsize)+2
    col_cut = col*bsize:(col+1)*bsize;
    
    if length(col_cut) > bsize
      col_cut = col_cut(1:end-1);
    end
    
    % Randomly pick blocks
    out(row_cut, col_cut, :) = get_block(im, bsize, randi(mci), randi(mri));
  end
end

imshow(out);