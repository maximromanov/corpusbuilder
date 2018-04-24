module Documents::Export
  class ExportLinePng < Action::Base
    attr_accessor :zone, :document, :dir_path, :image

    def execute
      cropped_image.save out_path
    end

    def out_path
      File.join dir_path, "#{zone.id}.png"
    end

    def cropped_image
      memoized do
        image.crop line_box.x, line_box.y, line_box.width, line_box.height
      end
    end

    def line_box
      memoized do
        Area.span_boxes graphemes.map(&:area)
      end
    end

    def graphemes
      memoized do
        Graphemes::QueryLine.run!(
          zone: zone,
          document: document,
          revision: document.master.revision
        ).result
      end
    end
  end
end