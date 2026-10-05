classdef NotchRejectFilter
    methods (Static)

        function result = ideal(F, u, v, radius)
            [D1, D2] = FrequencyMeasure.mirrorPointRadius(F, u, v);

            % Binary Mask
            H = D1 >= radius & D2 >= radius;

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = gaussian(F, u, v, radius)
            [D1, D2] = FrequencyMeasure.mirrorPointRadius(F, u, v);
            
            % Mask Gaussian
            ratio1 = - D1.^2 / (2 * radius^2);
            factor1 = 1 - exp(ratio1)
            ratio2 = - D2.^2 / (2 * radius^2);
            factor2 = 1 - exp(ratio2);
            H = factor1 .* factor2;

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = butterworth(F, u, v, radius, order)
            [D1, D2] = FrequencyMeasure.mirrorPointRadius(F, u, v);
            
            % Mask Gaussian
            ratio1 = radius / D1;
            factor1 = 1 / (1 + ratio1 .^ (2 * order));
            ratio2 = radius / D2;
            factor2 = 1 / (1 + ratio2 .^ (2 * order));
            H = factor1 .* factor2;

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end

    end
end