Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9683C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CD220679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564608222;
	bh=6nNxcMEovTcHoIiAfEq3DqoB8lHWiq9aCZJ9QtYeXkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PNboMgUdSJMPP+/bwIgykcVHBeltD7DNZu+KnU9ScepeC3BM63Jj4nLQP79ZOVVwl
	 h+Ibw9s8dOEt1PTzzeWKPCrHw/xH/brJ2PXCbAu4ehSbXqq435k7EFAD/9T4Y/A/vV
	 zr8AVT1Dfwxjec2mIFaOIkVrRgLa7DH/eDd7OaiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfGaVXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:23:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44610 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfGaVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JkzFMfYYWR9hL+mE/onPPqot2hOPIdqB/0Q4DZvIvmI=; b=wtZw7VNA1bHlFQACBOu3kQnWO
        V3gFvCw1cvov+R/1YVxL9DcyW7NCWWy4F8XpPBfeFecFj56NJ9bZs8a7P0Lq82SxO5k1nZbQpxGKH
        KaExNVsQloZHiOkpskzSTHkb/s3v1GDMTKE9g/Q/XrvdDiIck1QejIuU2RBkv+zRKL/gM=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsw4O-0003MU-Te; Wed, 31 Jul 2019 21:23:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DCE4C2742C6C; Wed, 31 Jul 2019 22:23:35 +0100 (BST)
Date:   Wed, 31 Jul 2019 22:23:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Message-ID: <20190731212335.GL4369@sirena.org.uk>
References: <20190730173006.15823-1-dev@pschenker.ch>
 <20190730173006.15823-2-dev@pschenker.ch>
 <20190730181038.GK4264@sirena.org.uk>
 <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
In-Reply-To: <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
X-Cookie: FEELINGS are cascading over me!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 09:00:01PM +0000, Philippe Schenker wrote:
> On Tue, 2019-07-30 at 19:10 +0100, Mark Brown wrote:
> > On Tue, Jul 30, 2019 at 07:30:04PM +0200, Philippe Schenker wrote:

> > > This adds the possibility to enable a fixed-regulator with a clock.

> > Why?  What does the hardware which makes this make sense look like?

> Tomorrow I can provide some schematics if needed. But its just a simple
> switch that is switched by a clock (on when clock is on and off when
> clock is off). This clock is the RGMII 50MHz clock for the ethernet
> PHY.

So it's not switching with the clock, the circuit somehow keeps the
switch latched?

> Why is a regulator even needed?
> - On power up of the PHY there is a huge time I have to wait for
> voltage rail to settle. In the range of 100ms.
> - Because there is a switch in the circuit I abstract it with a
> regulator-fixed in devicetree to make use of the startup-delay.
> - This regulator/switch is enabled with a clock. So to be able to use
> the startup delay I need an enable-by-clock on regulator-fixed.

It does feel like it might be simpler to just handle this as a quirk in
the PHY or ethernet driver, this feels like an awful lot of work to
add a sleep on what's probably only going to ever be one system.

> Why do I think this should be in core?
> - Normally this task is done with gpio that is already in regulator-
> core.
> - Because that is already there I added the functionality for enabled-
> by-clock-functionality.
> - I thought of creating a new regulator-clock driver but that would
> hold a lot of code duplication from regulator-fixed.

Hopefully not a *lot* of duplication.  The GPIOs are handled in the core
because they're really common and used by many regulator devices, the
same will I hope not be true for clocks.

> Why is this a good Idea at all?
> - Well I'm here for the software part and should just support our
> hardware. If that is a good Idea at all I don't know, for sure it is
> not a solution that is from some school-book. But I tried it and
> measured it out and it seems to work pretty fine.
> - The reason behind all of that is limited GPIO availability from the
> iMX6ULL.

I guess my question here is what the trip through the regulator API buys
us - it's a bit of a sledgehammer to crack a nut thing.

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1CBtcACgkQJNaLcl1U
h9BslQf/aeF1Faxrh/xk/9g7IdzY8k5d73wxX6BrfKWrHMJNi4YHOUw4uCeHs/kh
W5z5AoEaqzPNIxENappg2KULLrNNMqtXqArS0TXeaqLvm0u1zXuAYVDxXzQ+S6R1
CH1EyZbHb7e56AKunLAfrxrOVy/NS0jMGIGjLslrxJYCwA5BAJwkGlTdK358u7OG
UrrDOjoLxQxDZBzbnx0+BtlNkJoaPgjXNTSYuQRekdN19vG3+7s8/cOil6K7dF+d
tCM6+yiI/32YVHvOlrdiSeYW3iaHqK3DoUhETPUCiEu3W3FYeB1hT35uiFxKyn8J
KCaHwVksAVm6z6O0840d8QSoPJDPoA==
=HHd2
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--
