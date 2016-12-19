function imgLayers


    % initialize figure
    figure(1), clf, hold on

    % just some random image (included with Matlab) to server
    % as the background
    img{1,1} = imresize(imread('DubinCar.png'), 4);    
    img{1,2} = [0 0];

    % rotate the image and discolor it to create another image
    img{2,1} = uint8(imresize(imrotate(img{1}, +12), 0.3)/2.5);
    img{2,2} = [150 20];

    % and another image
    %img{3,1} = uint8(imresize(imrotate(img{1}, -15), 0.5)*2.5);
    img{3,2} = [450 80];

    % show the stacked image
    imshow(stack_image(img));

    %% create new image, based on several layers

    function newImg = stack_image(imgs)

        % every image contained at a cell index (ii) is placed 
        % on top of all the previous ones (0:ii-1)

        rows = cellfun(@(x)size(x,1),imgs(:,1));
        cols = cellfun(@(x)size(x,2),imgs(:,1));

        % initialize new image        
        newImg = zeros(max(rows(:)), max(cols(:)), 3, 'uint8');

        % traverse the stack
        for ii = 1:size(imgs,1)

            layer  = imgs{ii,1};
            offset = imgs{ii,2};

            newImg( offset(1)+(1:rows(ii)), offset(2)+(1:cols(ii)), :) = layer;

        end   
    end   

end