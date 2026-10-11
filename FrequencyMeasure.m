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
            % u and v use cycles/pixel, matching the spectrum axes (+/-0.5).
            % Distances use the same corner-normalized scale as frequencyRadius.

            height = size(F, 1);
            width  = size(F, 2);

            fx = (-floor(width/2) : ceil(width/2)-1) / width;
            fy = (-floor(height/2) : ceil(height/2)-1) / height;

            [FX, FY] = meshgrid(fx, fy);

            % Wrap at Nyquist because the DFT frequency grid is periodic.
            dx1 = mod(FX - u + 0.5, 1) - 0.5;
            dy1 = mod(FY - v + 0.5, 1) - 0.5;
            dx2 = mod(FX + u + 0.5, 1) - 0.5;
            dy2 = mod(FY + v + 0.5, 1) - 0.5;
            D1 = sqrt(2) * hypot(dx1, dy1);
            D2 = sqrt(2) * hypot(dx2, dy2);
        end
    end
end
