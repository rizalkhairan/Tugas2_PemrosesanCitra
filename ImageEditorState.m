classdef ImageEditorState < handle
    % Shares image and its frequency-domain representation

    properties (SetAccess = private, SetObservable)
        PreviewImage = []
        PreviewImageFreq = []
        HasPreview = false
    end

    properties (Access = private)
        OriginalImage = []
        CurrentImageFreq = []
        CurrentImage = []
        undoStack = {}
        redoStack = {}
    end

    methods (Access = private)
        function setImageFreq(obj, imageFreq, isPreview)
            image = real(ifft2(imageFreq));

            if isPreview
                obj.PreviewImageFreq = imageFreq;
                obj.PreviewImage = image;
            else
                obj.CurrentImageFreq = imageFreq;
                obj.CurrentImage = image;
            end
        end
    end

    methods
        function adjustBrightness(obj, value)
            % Scale DC
            imageFreq = obj.CurrentImageFreq;
            imageFreq(1, 1, :) = imageFreq(1, 1, :) .* value;

            obj.preview(imageFreq);
        end

        function loadImage(obj, image)
            obj.OriginalImage = image;

            imageFreq = fft2(image);

            obj.setImageFreq(imageFreq, false);
            obj.setImageFreq(imageFreq, true);

            obj.HasPreview = false;
            obj.undoStack = {};
            obj.redoStack = {};
        end

        function preview(obj, imageFreq)
            obj.setImageFreq(imageFreq, true);
            obj.HasPreview = true;
        end

        function apply(obj)
            if ~obj.HasPreview
                return;
            end

            if ~isequal(obj.CurrentImageFreq, obj.PreviewImageFreq)
                obj.undoStack{end+1} = obj.CurrentImageFreq;

                obj.setImageFreq(obj.PreviewImageFreq, false);

                obj.redoStack = {};
            end

            obj.HasPreview = false;
        end

        function cancel(obj)
            obj.setImageFreq(obj.CurrentImageFreq, true);
            obj.HasPreview = false;
        end

        function undo(obj)
            if ~obj.canUndo()
                return;
            end

            obj.redoStack{end+1} = obj.CurrentImageFreq;

            previousFreq = obj.undoStack{end};
            obj.undoStack(end) = [];

            obj.setImageFreq(previousFreq, false);
            obj.cancel();
        end

        function redo(obj)
            if ~obj.canRedo()
                return;
            end

            obj.undoStack{end+1} = obj.CurrentImageFreq;

            nextFreq = obj.redoStack{end};
            obj.redoStack(end) = [];

            obj.setImageFreq(nextFreq, false);
            obj.cancel();
        end

        function available = canUndo(obj)
            available = ~isempty(obj.undoStack);
        end

        function available = canRedo(obj)
            available = ~isempty(obj.redoStack);
        end
    end
end