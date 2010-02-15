function w = linregFitL1InteriorPoint(X, y, lambda)
%% min_w ||Xw-y||_2^2 + lambda ||w||_1
% Wrapper to code by Kwangmoo Koh, Seung-Jean Kim, and Stephen Boyd
    
w = l1_ls(X, y, lambda, 1e-3, true);
