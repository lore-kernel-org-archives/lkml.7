Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CFEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCGIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:35:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55570 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:35:21 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 76299804A1; Thu,  7 Mar 2019 09:35:12 +0100 (CET)
Date:   Thu, 7 Mar 2019 09:35:18 +0100
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
Message-ID: <20190307083518.GA8052@amd>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
 <20190306231003.GD7915@amd>
 <20190307041808.GK26690@windriver.com>
 <20190307082524.GB4634@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20190307082524.GB4634@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Pavel, I hope this more extended explanation makes sense to you, and
> > that you simply have not seen me write these same details in the past.
>=20
> Blimey.  That's a really long winded way of saying:
>=20
>   "Modular-ness is actually broken in these drivers; [Paul]'s patches
>    make that point clear for all to see.  If people (authors/distros)
>    wish them to be modular, they need to fix them properly."

Has that been checked?

I mean... when I saw the patch I thought "perhaps it should be doing
bool->tristate instead"?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyA18YACgkQMOfwapXb+vLAxgCgjWvBc8EJQsh4mCq7bC/TE0MP
NMcAnj2AFRWY1cOOafm4t7W7JJ/IunmV
=V5hv
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
