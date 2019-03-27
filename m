Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A662075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfC0Nus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:50:48 -0400
Received: from sauhun.de ([88.99.104.3]:36232 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0Nus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:50:48 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 344762E35A2;
        Wed, 27 Mar 2019 14:50:46 +0100 (CET)
Date:   Wed, 27 Mar 2019 14:50:45 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Message-ID: <20190327135045.GE5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
 <20190315124717.x3do5evok5syipo7@verge.net.au>
 <20190315131435.GE9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <20190315131435.GE9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +		if (!ret)
> > > +			timeout =3D 1;
> > > +		else
> > > +			timeout =3D 0;
> >=20
> >=20
> > nit: the following might be cleaner
> >=20
> > 		ret =3D !!timeout;
> >=20
>=20
> Other way around, perhaps,
>=20
>       timeout =3D !ret;

I saw that but didn't want to modify this patch. But yes, this is easy
enough and looks a lot better.


--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybf7UACgkQFA3kzBSg
KbYUGA/7BMcz1G20aqZ92ejVHHeFnpHcGGpc1H8Ltdv07p4tnjcbDQDeXjfplXZl
RmBhHZegpLh2+G7DrDvMQGkL5ShRDwAQ75OO2ZRAdMYOPAKjcS+unsKf9iJVI1eB
GbOlPIzS9hbVoxtT+Rkk+4g3mkN7OPFynEza4JKxC/lGgTnosNZwAaimboVCiwRs
l00n20ZXYY5wGoGd33rlhr47A4kZ/j9RIr8wmsZ5MSOl+GP6G9gB+IryYb7jux7m
nLjElLwtQHyWcu3lz6YgOEwRsBoTdhOpaSDGze0TGGhuaRQTmQqvkiGPaqBaru1G
pTQePBso6cBfAXgZ3kXx1h3hbyan4Vn3L56kL9FcmHqmGQo/VM1g6J+OhtWLOi3y
5mEPZZefUMzUiHgB3IpTNeWfXMC5905HJKaQ1XbM9/qGW9jDCJ3sFmqEC0VVkkBZ
04n0zVMQJL0xuEzhiNYLGcvyJaFWX7b0sZNH1BGOeOOkQ1upEOaAzWMM/EGG+EGJ
nCh8/QLxhWvKvvuNSfPaX5EGGLd/6qYDFjBtJ206hdKnGVe/0OogEYMH5fcr8Ein
GeEhnpQ7wbkn/62ugZYtkakTw2PrK3Uvm+lRZgxagfddWi/Oa6cTo8ZtsC4sUGnf
m1DTK5M6iNQw2iRo0VzgTvvqqGr4w22fayvvEauu7Pp5aqZi8N0=
=BBzs
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
