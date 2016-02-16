b1 = Brewery.create name:"Anheuser-Busch", year:1897
b2 = Brewery.create name:"Milwaukee Brewing Company", year:1042

BeerClub.create name:"Olutklubi", founded:2000, city:"Helsinki"

s1 = Style.create name:"Cream Ale", description:"Cream Ales, spawned from the American light lager style,
are brewed as an ale though are sometimes finished with a lager yeast or lager beer mixed in.
Adjuncts such as corn or rice are used to lighten the body. It is no uncommon for smaller craft brewers
to brew all malt Cream Ales. Pale straw to pale gold color. Low hop bittering and some hop aroma though
some micros have given the style more of a hop character. Well carbonated and well attenuated."

s2 = Style.create name:"Light Lager", description:"The Light Lager is generally a lighter version of a
breweries premium lager, some are lower in alcohol but all are lower in calories and carbohydrates
compared to other beers. Typically a high amount of cereal adjuncts like rice or corn are used to help
lighten the beer as much as possible. Very low in malt flavor with a light and dry body. The hop character
is low and should only balance with no signs of flavor or aroma. European versions are about half the
alcohol (2.5-3.5% abv) as their regular beer yet show more flavor (some use 100% malt) then the
American counterparts. For the most part this style has the least amount of flavor than any other style of beer."

s3 = Style.create name:"German Pilsener", description:'The Pilsner beer was first brewed in Bohemia, a
German-speaking province in the old Austrian Empire. Pilsner is one of the most popular styles of lager
beers in Germany, and in many other countries. Its often spelled as "Pilsener", and often times abbreviated,
or spoken in slang, as "Pils."

Classic German Pilsners are very light straw to golden in color. Head should be dense and rich.
They are also well-hopped, brewed using Noble hops such has Saaz, Hallertauer, Hallertauer Mittelfrüh,
Tettnanger, Styrian Goldings, Spalt, Perle, and Hersbrucker. These varieties exhibit a spicy herbal
or floral aroma and flavor, often times a bit coarse on the palate, and distribute a flash of
citrus-like zest--hop bitterness can be high.'

b1.beers.create name:"Bud Light", style_id:s2.id
b1.beers.create name:"Faust", style_id:s3.id
b2.beers.create name:"Outboard", style_id:s1.id
