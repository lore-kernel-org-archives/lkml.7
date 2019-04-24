Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F46C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C844218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfDXNtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:49:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55605 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDXNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:49:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 86B31801D0; Wed, 24 Apr 2019 15:49:07 +0200 (CEST)
Date:   Wed, 24 Apr 2019 15:49:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v4 04/26] dt-bindings: leds: Add LED_COLOR_ID definitions
Message-ID: <20190424134915.GB14360@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-5-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-5-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-17 22:54:17, Jacek Anaszewski wrote:
> Add common LED color identifiers.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds=
/common.h
> index da0539490cea..d8c8c38700bd 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -56,4 +56,15 @@
>  #define LED_FUNCTION_WLAN "wlan"
>  #define LED_FUNCTION_WPS "wps"
> =20
> +/* Standard LED colors */
> +#define LED_COLOR_ID_WHITE	0
> +#define LED_COLOR_ID_RED	1
> +#define LED_COLOR_ID_GREEN	2
> +#define LED_COLOR_ID_BLUE	3
> +#define LED_COLOR_ID_AMBER	4
> +#define LED_COLOR_ID_VIOLET	5
> +#define LED_COLOR_ID_YELLOW	6
> +#define LED_COLOR_ID_IR		7
> +#define LED_COLOR_ID_COUNT	8

The "_COUNT" define confused me. I was trying to figure out what color
it is. We sometimes have "_MAX" in that meaning.

Probably can be merged with previous patch?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAaVsACgkQMOfwapXb+vKlcACeLRg3DUaro1K2Ez6hua8Y7WQ9
IJ8AnR0VOOi7clRoT8THP7Vd5xiTk6em
=keiw
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
