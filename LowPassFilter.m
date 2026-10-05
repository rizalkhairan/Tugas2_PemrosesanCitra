classdef LowPassFilter
    methods (Static)

        function result = ideal(F, cutoff)
            D = FrequencyMeasure.frequencyRadius(F);

            % Binary Mask
            H = D <= cutoff;

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = gaussian(F, cutoff)
            D = FrequencyMeasure.frequencyRadius(F);

            % Mask Gaussian
            if cutoff == 0
                H = D == 0;
            else
                H = exp(-(D.^2) ./ (2 * cutoff^2));
            end

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = butterworth(F, cutoff, order)
            D = FrequencyMeasure.frequencyRadius(F);

            % Mask Butterworth
            if cutoff == 0
                H = D == 0;
            else
                H = 1 ./ (1 + (D ./ cutoff).^(2 * order));
            end

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end

    end
end