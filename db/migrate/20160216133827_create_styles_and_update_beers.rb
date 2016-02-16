class CreateStylesAndUpdateBeers < ActiveRecord::Migration
  def change
    create_table :styles do |t|
        t.string :name
        t.text :description
    end

    change_table :beers do |t|
        t.rename :style, :old_style
    end

    add_column :beers, :style_id, :integer

    style_names = Beer.all.map { |beer| beer.old_style }.uniq

    style_names.each do |name|
        Style.create name:name, description:'No description.'
    end

    Beer.all.each do |beer|
        style_name = beer.old_style
        beer.style_id = Style.all.detect { |style| style_name == style.name }.id
        beer.save       
    end

    remove_column :beers, :old_style, :string
  end
end
