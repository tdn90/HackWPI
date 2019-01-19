class PhotoController < ApplicationController
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def upload()
        pict = params[:fileset]

        image_annotator = Google::Cloud::Vision::ImageAnnotator.new

        response = image_annotator.document_text_detection image: pict.tempfile.path

        text = ""
        response.responses.each do |res|
        res.text_annotations.each do |annotation|
            text << annotation.description
        end
        end

        # Preprocessing
        text = text.split("SUBTOTAL").first
        text = text.slice(text.index("Member")..-1)
        text = text.gsub(/Member # [0-9]*\n/, "")
        text = text.gsub(/[0-9]*. # [0-9]*\n/, "")
        text = text.gsub(/[0-9]*\.[0-9]* lb @ [0-9]*\.[0-9]* per( lb)?/, "")
        text = text.gsub(/FA.SAVED [0-9]*\.[0-9]*/, "")
        text = text.gsub(/(?![0-9]*\.[0-9]* )F\.?/, "")
        text = text.gsub(/T?.?F?A.I?SAVED [0-9]*\.[0-9]*/, "")

        result = text.scan(/([a-zA-Z 0-9]*)\n?[ \n]+([0-9 ]+\.[0-9 ]*)?\n?/)

        for item in result
            if(!item[1].nil?)
                item[1] = item[1].gsub(/\s+/,"")
            end
        end

        result = result.delete_if{|x| x[0] == " "}

        p result

        render json: {"status": "OK", "result": result}
    end
end
