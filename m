Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39663CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10175205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762359;
	bh=oA1KbQ+iL4lJATXS+Rqeu+8Px+PrmA76Q7yx0VphYaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1hnt3qo8AHieOvGm7rVAkw8/GVrKNGkExPAnRCJb42G0T9V5FIBblQ9//Og6dWcVr
	 8j9EjotfkjBdmNcncSn0X/vBOWiRKXjH0AQXx9Hannt9NIoXY2yX4ZVJRHBe9wlCEE
	 v+/9j9jXEbrFpukVOnSxF+jZiZBxTVCJnZC34inQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfJVQjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:39:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfJVQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oA1KbQ+iL4lJATXS+Rqeu+8Px+PrmA76Q7yx0VphYaw=; b=V6tU+o2WhZ+Gvunqxu1pwYPXC
        qlrlBZyT944wbkAHtEbGIryATy9jVaQoJddFATuvTLvFSr8SYTEXyz+Fxu7W7ExD8kCkXfzwiXEKx
        /lppA2ah0Y2pgZ0Uon3QdL92ifyOZkKPfEfefYZJONXGT5xuAKf0jFnoVu0NpIpfCA360=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxBi-00074O-E1; Tue, 22 Oct 2019 16:39:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DCD5C2743259; Tue, 22 Oct 2019 17:39:13 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:39:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 30/46] SoC: pxa: use pdev resource for FIFO regs
Message-ID: <20191022163913.GV5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-30-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gYb7txo4D4wAJl1C"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-30-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gYb7txo4D4wAJl1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:45PM +0200, Arnd Bergmann wrote:
> The driver currently takes the hardwired FIFO address from
> a header file that we want to eliminate. Change it to use
> the mmio resource instead and stop including the heare.

Acked-by: Mark Brown <broonie@kernel.org>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--gYb7txo4D4wAJl1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMLEACgkQJNaLcl1U
h9B4BAf+Nigk17USU9kJexq9HKaYufhu9ucbNDUZLT0gHczwHLubKDwFnz4+gbh5
pUlTULZnfpE0LXEGKSAR5sdY8XbPEQ/mZfwzWFYsmNj/kA0X/H36jS5+kGtFZUpl
2BuiFzUmWYqAo/oBVD2Eprt+OgkO18z/7ftvbs4VcNoQaGU4hZNm+ccBnB/KS0UK
6qPnSD640/Tr3lCHDIfhte9DJ2B1W8Rxiv8J0zvpXQhUGn2AyRPWal+8bBFyg6wb
QdOdpouPKeQV+9azp5dam2tL6qzo9eLSHj3ZMjacGJkEfOfmLSPSSe8EVAMknjrb
uHHkt8gIg41WbFX7zBCEMKsRiRA0gg==
=1IWc
-----END PGP SIGNATURE-----

--gYb7txo4D4wAJl1C--
