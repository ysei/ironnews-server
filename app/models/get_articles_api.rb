
# 記事取得API
class GetArticlesApi < ApiBase
  ArticleIdsFormat = /\A\d+(,\d+)*\z/

  column :article_ids, :type => :text

  validates_presence_of :article_ids
  validates_format_of :article_ids, :with => ArticleIdsFormat, :allow_blank => true

  def self.from(params)
    return self.new(self.suppress_parameter(params))
  end

  def parsed_article_ids
    return self.article_ids.split(/,/).map(&:to_i)
  end

  def execute
    unless self.valid?
      return {:success => false}
    end

    articles = Article.find_all_by_id(self.parsed_article_ids.sort.uniq).inject({}) { |memo, article|
      memo[article.id] = {
        :title => article.title,
        :url   => article.url,
      }
      memo
    }

    return {
      :success => true,
      :result  => articles,
    }
  end
end
