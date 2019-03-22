Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6779E218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfCVIfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52830 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfCVIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B7546805A9; Fri, 22 Mar 2019 09:35:41 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:35:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 04/25] dt-bindings: leds: Add LED_COLOR_NAME definitions
Message-ID: <20190322083548.GC27015@amd>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-5-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20190310182836.20841-5-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-03-10 19:28:15, Jacek Anaszewski wrote:
> Add common LED color name definitions for use in Device Tree.

Could we do "LED_COLOR_NAME_" =3D> "LED_COLOR_"?

								Pavel

> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds=
/common.h
> index ffcd46317307..0e986bb59391 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -57,4 +57,13 @@
>  #define LED_FUNCTION_WLAN "wlan"
>  #define LED_FUNCTION_WPS "wps"
> =20
> +/* Standard LED colors */
> +#define LED_COLOR_NAME_WHITE    "white"
> +#define LED_COLOR_NAME_RED      "red"
> +#define LED_COLOR_NAME_GREEN    "green"
> +#define LED_COLOR_NAME_BLUE     "blue"
> +#define LED_COLOR_NAME_AMBER    "amber"
> +#define LED_COLOR_NAME_VIOLET   "violet"
> +#define LED_COLOR_NAME_YELLOW   "yellow"
> +
>  #endif /* __DT_BINDINGS_LEDS_H */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUnmQACgkQMOfwapXb+vJxMgCdHOxOKhMea4/n7TNUWsezfMib
zB4AoIaGGGyboAeThjrhCWBHftooD4qE
=D0EN
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
