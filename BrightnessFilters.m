classdef BrightnessFilters
    methods (Static)
        function F = scaleDC(F, value)
            F(1, 1) = F(1, 1) * value;
        end
    end
end