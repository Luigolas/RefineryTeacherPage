Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-customizations').blank?
        user.plugins.create(:name => 'refinerycms-customizations',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  Refinery::Customizations::Customization.delete_all
  I18n.locale = :en
  custom = Refinery::Customizations::Customization.create(
      name: 'Name',
      desctiption: 'Description'
  )
  I18n.locale = :es
  custom.name = 'Nombre'
  custom.desctiption = 'Descripción'
  custom.save
  I18n.locale = :en

  #url = "/customizations"
  #if defined?(Refinery::Page) && Refinery::Page.where(:link_url => url).empty?
  #  page = Refinery::Page.create(
  #    :title => 'Customizations',
  #    :link_url => url,
  #    :deletable => false,
  #    :menu_match => "^#{url}(\/|\/.+?|)$"
  #  )
  #  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
  #    page.parts.create(:title => default_page_part, :body => nil, :position => index)
  #  end
  #end
end
