Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B594C468A7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9EF216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGEUXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:23:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37477 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGEUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:23:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 67D6480594; Fri,  5 Jul 2019 22:23:07 +0200 (CEST)
Date:   Fri, 5 Jul 2019 22:23:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] leds: as3645a: Fix misuse of strlcpy
Message-ID: <20190705202317.GA5445@amd>
References: <cover.1562283944.git.joe@perches.com>
 <79fe35321ff794dccf1d08b415cee40636fa5fce.1562283944.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <79fe35321ff794dccf1d08b415cee40636fa5fce.1562283944.git.joe@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-04 16:57:42, Joe Perches wrote:
> Probable cut&paste typo - use the correct field size.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Ack.
									Pavel
> ---
>  drivers/leds/leds-as3645a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
> index 14ab6b0e4de9..050088dff8dd 100644
> --- a/drivers/leds/leds-as3645a.c
> +++ b/drivers/leds/leds-as3645a.c
> @@ -668,7 +668,7 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
>  	};
> =20
>  	strlcpy(cfg.dev_name, led->name, sizeof(cfg.dev_name));
> -	strlcpy(cfgind.dev_name, flash->iled_cdev.name, sizeof(cfg.dev_name));
> +	strlcpy(cfgind.dev_name, flash->iled_cdev.name, sizeof(cfgind.dev_name)=
);
> =20
>  	flash->vf =3D v4l2_flash_init(
>  		&flash->client->dev, flash->flash_node, &flash->fled, NULL,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0fsbUACgkQMOfwapXb+vIanwCguZhbbEab7n2anLambt3YwIU5
BnkAoLc4SKnIko69xeOf6HmHCL495jOx
=S9vd
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
