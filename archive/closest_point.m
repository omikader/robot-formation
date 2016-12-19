function closest = closest_point(coord_list, curr)
    % compute Euclidean distances
    distances = sqrt(sum(bsxfun(@minus, coord_list, curr).^2,2));
    closest = coord_list(distances==min(distances),:)
end

