Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E73C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943C5214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551354058;
	bh=zorMPTfb1TPeO4nwA4T4qEy8dDYyeF8JQMspHx5/z3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d3Sl84a5hsoKta6ZyyNgb+vBShApM/QJJNMnlhBp48gLh6eI84m53BZKmDcXQilv0
	 9DtX6KALoB+56OSO+6VW76YCnOGRO1ih+imqrTtGfauBuOdyfvAw1wNkGuc/TAq6KE
	 ENe3NOezXvlwS0nsLKGhvP/PRFzPg/CZHFs9+0UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfB1Lk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:40:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49356 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbfB1Lk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LLiNH4oIr4+JwdwcpJ+DDQQsoNcU24lAEfaNV3Etzf0=; b=um/mSy8gXDP3Bi4q2X0zs4/KY
        ovato2EYhXlJMgy405qMYClvzMZQTbCYqXAEuDVJMe+82ZwPbq8e0YvsQFKn4K7yDGLBtGYSYgh1c
        monHmeuu0SplBQmXvsXqnWw9fME5DAZ8LRFcsLSX5TlsludkIncTDtx+bH16GH22hAlH8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gzK3E-0005kG-Dr; Thu, 28 Feb 2019 11:40:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 74BA21126E9D; Thu, 28 Feb 2019 11:40:26 +0000 (GMT)
Date:   Thu, 28 Feb 2019 11:40:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190228114026.GA6802@sirena.org.uk>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20190228070450.GB3773@localhost.localdomain>
X-Cookie: You must be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 09:04:50AM +0200, Matti Vaittinen wrote:
> On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:

>> Patch series introducing support for ROHM BD70528 PMIC
>=20
> I was wondering if there is anything that could be done to allow the MFD
> part of this series to end up in upstream without having to wait the
> regmap-irq changes
> (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commi=
t/?h=3Dtopic/irq)
>  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> To me it looks like getting them to MFD via Linus' tree will take a while.

They're targeted for v5.1 and I sent a pull request to Lee for that
branch IIRC.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx3yKcACgkQJNaLcl1U
h9D7LQgAgBAtFp4ti3bwtZh4iVfn9N4nYX2Sy8YynfGs/Nfwxm+m+KAl+IiOOo6C
S1kWALtElOcido6myPacabi0EAyre1Q+Ne7tqUITOb4HQL0dGDpi/a1llthziX7d
ZG6Slh0JGjOlPVZ8dMyxqXzySEjtwbKUMY4FqMd9LpkQ64FCmo5WdI9R6dnu0BZn
DJjdUbHmqAbgNoxJ9M/U6mqDTXEviO2eqPhUCAnISc6GvabHA7UdRUxIzi770HjM
Zi+AFlBE8mWAGvzn3C5u0h+4dnZxCMxMpSpyGokXkL25v5MzHB7lXOpi7a37Zpvo
VBkTW0n5LezH7ejhsiqf90PtqfUptQ==
=/nOu
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
