class Ad < ApplicationRecord
    belongs_to :team

    #e posso così salvare @ad.lanes = { top: true, jgl: false, mid: true, adc: true, sup: false }
    #con true che indica lane occupata e false no
end