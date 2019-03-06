Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34207C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C53620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCFXKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:10:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57490 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:10:06 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E7F038046C; Thu,  7 Mar 2019 00:09:56 +0100 (CET)
Date:   Thu, 7 Mar 2019 00:10:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        linux-omap@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Message-ID: <20190306231003.GD7915@amd>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20190116132431.GE23399@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-16 13:24:31, Lee Jones wrote:
> [...]
>=20
> > Paul Gortmaker (18):
> >   mfd: aat2870-core: Make it explicitly non-modular
> >   mfd: adp5520: Make it explicitly non-modular
> >   mfd: as3711: Make it explicitly non-modular
> >   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
> >   mfd: htc-i2cpld: Make it explicitly non-modular
> >   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
> >   mfd: rc5t583: Make it explicitly non-modular
> >   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
> >   mfd: syscon: Make it explicitly non-modular
> >   mfd: tps65090: Make it explicitly non-modular
> >   mfd: tps65910: Make it explicitly non-modular
> >   mfd: tps80031: Make it explicitly non-modular
> >   mfd: wm831x-spi: Make it explicitly non-modular
> >   mfd: wm831x-i2c: Make it explicitly non-modular
> >   mfd: wm831x-core: drop unused module infrastructure from non-modular =
code
> >   mfd: wm8350-i2c: Make it explicitly non-modular
> >   mfd: wm8350-core: drop unused module infrastructure from non-modular =
code
> >   mfd: wm8400-core: Make it explicitly non-modular
> >=20
> >  drivers/mfd/aat2870-core.c      | 40 +++------------------------------=
-------
> >  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
> >  drivers/mfd/as3711.c            | 14 --------------
> >  drivers/mfd/db8500-prcmu.c      | 10 ++++------
> >  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
> >  20 files changed, 41 insertions(+), 332 deletions(-)
>=20
> All applied!

Is it good idea?

We want distro kernels on ARM, too, which means people will eventually
want these as a modules, no?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU0sACgkQMOfwapXb+vK87gCfYqDOuTU/ycnXzAkAmrnRwdxB
rzkAn1eqwcVZ9SI2Z+rhSE1L7etSgIz+
=iMdg
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
