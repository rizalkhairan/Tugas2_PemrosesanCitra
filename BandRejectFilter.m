classdef BandRejectFilter
    methods (Static)

        function result = ideal(F, centerFreq, bandwidth)
            % A zero-width band leaves the image unchanged.
            if bandwidth == 0
                result = F;
                return;
            end
            D = FrequencyMeasure.frequencyRadius(F);

            % Binary Mask
            H = (D > centerFreq + bandwidth/2) | (D < centerFreq - bandwidth/2);

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = gaussian(F, centralFreq, bandwidth)
            if bandwidth == 0
                result = F;
                return;
            end
            D = FrequencyMeasure.frequencyRadius(F);
            D_0 = centralFreq;
            W = bandwidth;

            % Mask Gaussian
            ratio = (D.^2 - D_0^2) ./ (D .* W);
            H = 1 - exp(-0.5 .* ratio.^2);
            % At DC, the limit is zero only when the band is centered at DC.
            H(D == 0) = double(D_0 > 0);

            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end


        function result = butterworth(F, centralFreq, bandwidth, order)
            if bandwidth == 0
                result = F;
                return;
            end
            D = FrequencyMeasure.frequencyRadius(F);
            D_0 = centralFreq;
            W = bandwidth;

            % Mask Butterworth
            ratio = (D .* W) ./ (D.^2 - D_0^2);
            H = 1 ./ (1 + ratio.^(2 * order));
            H(D == 0) = double(D_0 > 0);
            
            Fshift = fftshift(F, 1);
            Fshift = fftshift(Fshift, 2);

            Fshift = Fshift .* H;

            result = ifftshift(Fshift, 1);
            result = ifftshift(result, 2);
        end

    end
end
