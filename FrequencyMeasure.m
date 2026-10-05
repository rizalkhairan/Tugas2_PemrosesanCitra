classdef FrequencyMeasure
    methods (Static)
        function D = frequencyRadius(F)
            % Normalized frequency-radius matrix. Distance to DC
            % For circular filter calculation
            %
            % Horizontal/vertical frequency:
            %   -1 = negative Nyquist
            %    0 = DC
            %   +1 = positive Nyquist
            %
            % Corners have radius 1.

            height = size(F, 1);
            width  = size(F, 2);

            fx = 2 * (-floor(width/2) : ceil(width/2)-1) / width;
            fy = 2 * (-floor(height/2) : ceil(height/2)-1) / height;

            [FX, FY] = meshgrid(fx, fy);

            D = hypot(FX, FY) ./ sqrt(2);
        end

        function [D1, D2] = mirrorPointRadius(F, u, v)
            % Normalized frequency-distance matrix. 
            % Distances to two symmetric pair of points with respect to DC
            % For notch filter calculation
            %
            % Calculates distance to each (u, v) and (-u, -v),
            % then find the min.

            height = size(F, 1);
            width  = size(F, 2);

            fx = 2 * (-floor(width/2) : ceil(width/2)-1) / width;
            fy = 2 * (-floor(height/2) : ceil(height/2)-1) / height;

            [FX, FY] = meshgrid(fx, fy);

            D1 = hypot(FX - u, FY - v) ./ sqrt(2);
            D2 = hypot (FX + u, FY + v) ./ sqrt(2);
        end
    end
end