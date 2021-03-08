# Autentikointi ja sessioiden hallinta

Aiemmin olemme toteuttaneet yksinkertaisen sisäänkirjautumislomakkeen. Onnistunut kirjautuminen ohjaa käyttäjän /userpages -sivulle. Mikään ei kuitenkaan estä ketä tahansa kyseisen osoitteen tuntemaa kirjoittamaan osoitetta selaimeen ja siirtymään sinne. Jotta tietoa  käyttäjän onnistuneesta kirjautumisesta voidaan turvallisesta ylläpitää tarvitaan sessioita.

Sessioiden hallinta on keskeinen osa modernien verkkosovellusten toimintaa. HTTP on itsessään tilaton protokolla, eli protokolla ei tiedä pyytääkö haettavaa sivua kirjautunut käyttäjä vaiko joku muu. Näinollen ohjelmoijan tulee välittää ja ylläpitää tietoa onnistuneesta kirjautumisesta sivupyyntöjen välillä. 



Sessioita voidaan toteuttaa useammalla tavalla. Yksi tavanomaisimmista on antaa onnistuneesti kirjautuneelle käyttäjän yksilöivä tunniste evästeeseen, salata sen sisältö ja tallentaa se käyttäjän selaimeen. Evästeet kulkevat sivupyyntöjen mukana palvelimelle, jossa niiden tietoja voidaan tutkia. Salattujen evästeiden lukeminen vaatii luonnollisesti salausavaimen tuntemista.

Katsotaan esimerkki 



Autentikointiin ja sessioiden hallintaan liittyviä asioita on esitelty hyvin. seuraavsaa blogissa: [https://stormpath.com/blog/everything-you-ever-wanted-to-know-about-node-dot-js-sessions](https://stormpath.com/blog/everything-you-ever-wanted-to-know-about-node-dot-js-sessions)



