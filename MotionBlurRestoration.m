classdef MotionBlurRestoration
    methods (Static)

        function result = inverse(G, motionLength, angle, threshold)
            H = MotionBlurRestoration.transferFunction( ...
                G, motionLength, angle);

            inverseH = zeros(size(H));
            valid = abs(H) > threshold;
            inverseH(valid) = 1 ./ H(valid);

            result = G .* inverseH;
        end

        function result = wiener(G, motionLength, angle, K)
            H = MotionBlurRestoration.transferFunction( ...
                G, motionLength, angle);

            denominator = abs(H).^2 + K;

            W = zeros(size(H));
            valid = denominator > 0;
            W(valid) = conj(H(valid)) ./ denominator(valid);

            result = G .* W;
        end

    end

    methods (Static, Access = private)

        function H = transferFunction(G, motionLength, angle)
            psf = fspecial('motion', motionLength, angle);

            imageSize = [size(G, 1), size(G, 2)];
            H = psf2otf(psf, imageSize);
        end

    end
end