Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1631BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53A121019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfEWMuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:50:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59581 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWMuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:50:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A0C3D80375; Thu, 23 May 2019 14:50:02 +0200 (CEST)
Date:   Thu, 23 May 2019 14:50:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, broonie@kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 6/6] leds: lm36274: Introduce the TI LM36274
 LED driver
Message-ID: <20190523125012.GB20354@amd>
References: <20190522192733.13422-1-dmurphy@ti.com>
 <20190522192733.13422-7-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20190522192733.13422-7-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/leds/leds-lm36274.c

> +static int lm36274_parse_dt(struct lm36274 *lm36274_data)
> +{
> +	struct fwnode_handle *child =3D NULL;
> +	char label[LED_MAX_NAME_SIZE];
> +	struct device *dev =3D &lm36274_data->pdev->dev;
> +	const char *name;
> +	int child_cnt;
> +	int ret =3D -EINVAL;
> +
> +	/* There should only be 1 node */
> +	child_cnt =3D device_get_child_node_count(dev);
> +	if (child_cnt !=3D 1)
> +		return ret;

I'd do explicit "return -EINVAL" here.

> +static int lm36274_probe(struct platform_device *pdev)
> +{
> +	struct ti_lmu *lmu =3D dev_get_drvdata(pdev->dev.parent);
> +	struct lm36274 *lm36274_data;
> +	int ret;
> +
> +	lm36274_data =3D devm_kzalloc(&pdev->dev, sizeof(*lm36274_data),
> +				    GFP_KERNEL);
> +	if (!lm36274_data) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}

And certainly do "return -ENOMEM" explicitly here.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzmlwQACgkQMOfwapXb+vKGTQCfXMX0uKvUxpwhTf9eLraj5005
zNIAn05ddGsfmRuYiC1Yw79dIQwKFUNn
=UqIj
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
