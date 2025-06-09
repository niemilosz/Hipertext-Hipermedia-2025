<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Zmienne globalne -->
    <xsl:variable name="nazwaAutor">
        <xsl:value-of select="/hobby/informacje/autor"/>
    </xsl:variable>

    <!-- Styl CSS -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Moje hobby - turystyka gorska</title>
                <style>
                    body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: linear-gradient(to bottom, #A9BCD0, #D8DBE2);
                    margin: 0;
                    padding: 20px;
                    }
                    naglowek {
                        background-color: #D8DBE2;
                        width: 100%
                    }
                    h1, h2, h3 {
                    color: #1B1B1E;
                    text-align: center;
                    margin-bottom: 10px;
                    }
                    h1 {
                    font-size: 2.2em;
                    }
                    h2 {
                    margin-top: 10px;
                    font-size: 1.5em;
                    }
                    h3 {
                    margin-top: 30px;
                    font-size: 1.3em;
                    text-transform: capitalize;
                    }
                    .szczyt {
                    border: 1px solid #d0d0d0;
                    background-color: #ffffff;
                    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
                    border-radius: 10px;
                    margin: 20px auto;
                    padding: 15px;
                    max-width: 900px;
                    transition: transform 0.2s;
                    }
                    .szczyt:hover {
                    transform: scale(1.01);
                    }
                    .nazwa-szczytu {
                    text-align: center;
                    font-size: 1.6em;
                    font-weight: bold;
                    margin-bottom: 10px;
                    color: #1B1B1E;
                    }
                    .szczyt-content {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 20px;
                    justify-content: center;
                    align-items: flex-start;
                    }
                    .szczyt-content img {
                    max-width: 300px;
                    height: auto;
                    border-radius: 8px;
                    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                    }
                    .szczyt-opis {
                    flex: 1;
                    min-width: 250px;
                    }
                    .szczyt-opis p {
                    margin: 8px 0;
                    font-size: 1.5em;
                    }
                    a {
                    color: #0077cc;
                    text-decoration: none;
                    font-weight: bold;
                    }
                    a:hover {
                    text-decoration: underline;
                    color: #005599;
                    }
                </style>
            </head>
            <body>
                <div class="naglowek">
                    <h1>Moje hobby: Turystyka gorska</h1>
                    <h2>Strona ukazuje moje hobby, czyli turystyke gorska, przedstawiam jedne z piekniejszych z polskich szczytow oraz moje plany co do zdobywania kolejnych, tym razem poza Polska.</h2>
                </div>
                <xsl:call-template name="pokazZdobyte"/>
                <xsl:call-template name="pokazPlanowane"/>
                <h2>Autor: <xsl:value-of select="$nazwaAutor"/></h2>
            </body>
        </html>
    </xsl:template>

    <!-- Nazwany szablon -->
    <xsl:template name="pokazZdobyte">
        <h2>Zdobyte szczyty</h2>
        <xsl:for-each select="/hobby/zdobyte/pasmo_górskie/*">
            <h3><xsl:value-of select="name()"/></h3>
            <xsl:for-each select="szczyt">
                <xsl:sort select="wysokość" data-type="number" order="descending"/>
                <div class="szczyt">
                    <div class="nazwa-szczytu">
                        <xsl:number level="any" format="1."/> <xsl:value-of select="nazwa"/>
                    </div>
                    <div class="szczyt-content">
                        <img src="{zdjecie}" alt="{nazwa}"/>
                        <div class="szczyt-opis">
                            <xsl:if test="@najwyższy='tak'">
                                <p style="color:#005599;">To najwyzszy szczyt w tym pasmie gorskim!</p>
                            </xsl:if>
                            <p><b>Wysokosc: </b> <xsl:value-of select="wysokość"/> m n.p.m.</p>
                            <p><b>Trudnosc: </b> <xsl:value-of select="@trudność"/></p>
                            <p><b>Opis: </b> <xsl:value-of select="opis"/></p>
                            <a href="{link}" target="_blank">Dowiedz sie wiecej!</a>
                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="pokazPlanowane">
        <h2>Planowane wyprawy</h2>
        <xsl:for-each select="/hobby/planowane/kontynent/*">
            <h3><xsl:value-of select="name()"/></h3>
            <xsl:for-each select="szczyt_planowany">
                <xsl:variable name="rokWyprawy" select="@rok"/>
                <div class="szczyt">
                    <div class="nazwa-szczytu">
                        <xsl:value-of select="nazwa"/> (<xsl:value-of select="$rokWyprawy"/>)
                    </div>
                    <div class="szczyt-content">
                        <img src="{zdjecie}" alt="{nazwa}"/>
                        <div class="szczyt-opis">
                            <p><b>Wysokosc: </b> <xsl:value-of select="wysokość"/> m n.p.m.</p>
                            <p><b>Kraje: </b>
                                <xsl:for-each select="kraje/kraj">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() != last()"> – </xsl:if>
                                </xsl:for-each>
                            </p>
                            <xsl:choose>
                                <xsl:when test="kraje/@graniczny='tak'">
                                    <p style="color:#005599;">Ten szczyt lezy na granicy dwoch panstw.</p>
                                </xsl:when>
                                <xsl:otherwise>
                                    <p style="color:#005599;">Ten szczyt lezy w jednym kraju.</p>
                                </xsl:otherwise>
                            </xsl:choose>
                            <a href="{link}" target="_blank">Dowiedz sie wiecej!</a>
                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <!-- Szablon dopasowany do atrybutu -->
    <xsl:template match="@student">
        <span>Student: <xsl:value-of select="."/></span>
    </xsl:template>

</xsl:stylesheet>