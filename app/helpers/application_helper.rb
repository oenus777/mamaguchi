# frozen_string_literal: true

module ApplicationHelper
    def default_meta_tags
        {
            site: '育児の孤独感やストレス、ママ友に疲れたり働くママたちのSNSならママぐち',
            title: '育児の孤独感やストレス、ママ友に疲れたり働くママたちのSNSならママぐち',
            reverse: true,
            charset: 'utf-8',
            description: '子育てや育児で感じる孤独感やストレス、保育園や幼稚園や学校のママ友関係のストレス、働くママだけにしか分からない悩み、誰にも言えない悩みや愚痴だからこそ辛いそんなママさんにママぐち。どんなあなたでも受け止める、そんな場所でありたいと思い運営しています。',
            separator: '|',
        }
    end
end
