function [ im_to ] = set_block( im_to, im_from, bsize, row, col )
%GET_BLOCK Returns the subimage of im at (row, col), given block size 

if row == 1
  hcut = 1:bsize;
else
  hcut = row*bsize:(row+1)*bsize;
end

if col == 1
  vcut = 1:bsize;
else
  vcut = col*bsize:(col+1)*bsize;
end

im_to(vcut, hcut, :) = 255;

end
