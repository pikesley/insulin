require 'insulin'
require 'prawn'

module Insulin
  class Pdf
    def initialize period, outfile
      @period = period
      @outfile = outfile
      @default_colour = "007700"

      @pdf = Prawn::Document.new
      @pdf.font "Courier"
      @pdf.font_size 12

      @pdf.formatted_text [{
        :text => "insulin",
        :styles => [
          :bold
        ],
        :color => "AA0000",
        :size => 16
      },
      {
        :text => " report for %s beginning %s" % [
          @period.descriptor,
          @period.start_date
        ]
      }]

      s = " report for %s beginning %s" % [
        @period.descriptor,
        @period.start_date
      ]
      @pdf.text "\n"
      @pdf.text "\n"
 
      @pdf.font_size 8

      colour = @default_colour
      if @period.average_glucose < 4
        colour = 'FF0000'
      end
      if @period.average_glucose > 8
        colour = '0000FF'
      end
      @pdf.table [
        [
          "latest hba1c (from %s)" % [ 
            @period.hba1c["date"],
          ],
          "%0.1f%s" % [
            @period.hba1c["value"],
            @period.hba1c["units"]
          ]
        ],
        [
          "average blood glucose for %s commencing %s" % [
            @period.descriptor,
            @period.start_date
          ],
          "<color rgb='%s'>%0.2f%s</color>" % [
            colour,
            @period.average_glucose,
            @period[0].glucose_units
          ]
        ]
      ],
      :position => :center,
      :column_widths => [
        300,
        200
      ],
      :row_colors =>
      [
        "F0F0F0",
        "D0D0D0"
      ],
      :cell_style => {
        :border_color => "333333",
        :border_width => 1,
        :inline_format => true
      }
      @pdf.text "\n"
      @pdf.text "\n"
      @pdf.text "\n"

      @period.each do |d|
        @pdf.formatted_text [{
          :text => "%s (%s)" % [
            d.date,
            d.day
          ],
          :color => "AA0000",
          :size => 10
        }]
        @pdf.text "\n"

        @grid = []
        @pdf.font_size 8
        d["all"].each do |e|
          colour = "000000"
          if e.simple?
            if e["type"] == "glucose"
              colour = @default_colour
              if e["value"] < 4
                colour = "0000FF"
              end
              if e["value"] > 8
                colour = "FF0000"
              end
            end
            @grid << [
              e["short_time"],
              e["tag"],
              e["type"],
              e["subtype"],
              "<color rgb='%s'>%s</color>" % [
                colour,
                e["formatted_value_with_units"]
              ]
            ]
          end
        end
        @pdf.table @grid,
          :position => :center,
          :column_widths => [
            100,
            100,
            100,
            100,
            100
          ],
          :row_colors =>
          [
            "F0F0F0",
            "D0D0D0"
          ],
          :cell_style => {
            :border_color => "333333",
            :border_width => 1,
            :inline_format => true            
          }
        @pdf.text "\n"
        @pdf.text "\n"
        @pdf.text "\n"
      end

      @pdf.stroke_horizontal_rule
      @pdf.text "\n"
      @pdf.text "\n"
      @pdf.text "\n"
      @pdf.formatted_text [{
        :text => "insulin",
        :color => "007700",
        :link => "http://pikesley.github.com/insulin/"
      
      },
      {
        :text => " written and maintained by Sam Pikesley"
      }]
    end

    def render
      @pdf.render_file @outfile
    end
  end
end
