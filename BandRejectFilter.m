classdef BandRejectFilter
    methods (Static)

        function result = ideal(F, centerFreq, bandwidth)
            D = FrequencyMeasure.frequencyRadius(F);

            % Binary Mask
            H = (D >= centerFreq + bandwidth/2) | (D <= centerFreq - bandwidth/2) ;

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = gaussian(F, centralFreq, bandwidth)
            D = FrequencyMeasure.frequencyRadius(F);
            D_0 = centralFreq;
            W = bandwidth;

            % Mask Gaussian
            if cutoff == 0
                H = D == 1;
            else
                ratio = (D.^2 - D_0^2) ./ (D .* W);
                H = 1 - exp(-0.5 .* ratio.^2);
            end

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = butterworth(F, centralFreq, bandwidth, order)
            D = FrequencyMeasure.frequencyRadius(F);
            D_0 = centralFreq;
            W = bandwidth;

            % Mask Butterworth
            ratio = (D .* W) / (D.^2 - D_0^2);
            H = 1 ./ (1 + ratio.^(2 * order));
            
            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end

    end
end