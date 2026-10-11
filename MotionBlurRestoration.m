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
            % Test data uses clockwise angles; fspecial uses counterclockwise.
            psf = fspecial('motion', motionLength, -angle);

            imageSize = [size(G, 1), size(G, 2)];
            if any(size(psf) > imageSize)
                error('MotionBlurRestoration:PSFTooLarge', ...
                    ['The motion PSF is %d-by-%d, but the image is %d-by-%d. ' ...
                    'Reduce the motion length or use a larger image.'], ...
                    size(psf, 1), size(psf, 2), imageSize(1), imageSize(2));
            end
            H = psf2otf(psf, imageSize);
        end

    end
end
