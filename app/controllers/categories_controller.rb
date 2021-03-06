
class CategoriesController < ApplicationController
  def social
    show_articles("社会")
  end

  def accident
    show_articles("事件事故")
  end

  def molestation
    show_articles("痴漢")
  end

  def economy
    show_articles("政治経済")
  end

  def science
    show_articles("科学技術")
  end

  def vehicle
    show_articles("車両")
  end

  def event
    show_articles("イベント")
  end

  private

  def show_articles(category)
    @category = category
    @articles = Article.
      division("鉄道").
      category(category).
      paginate(
        :order    => "articles.created_at DESC",
        :page     => params[:page],
        :per_page => 100)
    render(:template => "categories/common")
  end
end
