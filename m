Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F405DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF29217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554979350;
	bh=SzhwoeTt1bV78tIOPbRkNM6JFT03ZmbA0WN3g3sptE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JMUjU0mCaLWKd/O1uLc8QB9Og6zW+6NHgV3672G3QcS0lGSuUwV0dejS70+seTFSP
	 PEWQ/IzWFRY4TnCVecKREsyMBGwSguYPEdLbBXnofdJU1/I5YMdJxE4XY7d2J4nSP0
	 DK6n9lXNlYCkIO7oIA00YykIUcET5LZPRlV0GDjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDKKm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:42:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RxYTHYqAnDKdcAy1D9zNoaWmD5GLxh6inlwtWWJPs3k=; b=fkNL7GdvG58XmAo/TRVAIrexb
        YfvVr0MG3ffa0T+DSrYeDblB2z8bysJtNhWMagrch3Y2E8mXaghZsMfq7EPq87XuMta1q6XSQjpoA
        ajJ1qCK895xhAGRUOG8S2sfrULzp0UL1BUJDW+HrmGGkS+KPC5an/kdydPHOWZzMb0/Vg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEX9u-0008Nr-Re; Thu, 11 Apr 2019 10:42:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D8FF51126DD0; Thu, 11 Apr 2019 11:42:12 +0100 (BST)
Date:   Thu, 11 Apr 2019 11:42:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Message-ID: <20190411104212.GA7953@sirena.org.uk>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
 <6eeaf42f4d3f42c58546c429194213b8@asem.it>
 <20190410152820.GT6106@sirena.org.uk>
 <7ad025c8049e4e828ce75ef1e41dcbfd@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <7ad025c8049e4e828ce75ef1e41dcbfd@asem.it>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2019 at 07:14:06AM +0000, Flavio Suligoi wrote:

> > Right, yes - that analysis seems correct.  The interfaces seem a bit
> > weird here but fixing them looks like the most complete and robust fix.

> Ok Mark, I'll fix this problem as soon as I can, using EPROBE_DEFER.
> For now, in my application, I use the patch that I already sent,
> with the "softdep" workaround:

> MODULE_SOFTDEP("pre: dw_dmac");

> I tested it a lot, with more than 2000 cold reboot (automatic
> switch on/off using a controlled power supply) and it always worked good.

Right, and to be clear that patch is good and useful independently of
the deferred probe fix so assuming nothing else comes up in review I'll
apply it.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyvGgIACgkQJNaLcl1U
h9A0zwf6AirGRh8bQQli94rYunYRwRhABvSKVNVzjNeqW24AoyboZcJZQcx/mc54
H/sAv4CsbVbYE+zrc1HtH/tV4fDucGRAuBGMAnUDOCCqbPYJWfLr+JfT3bqIiqX2
xY7sw7D9zv9HeSh2zOZzSFniLz59BiJ/iPf+FQC86UGwOZGD7ObiGcUbhQHuqYXT
4DYwgPTMpp4lFCZXnSXXJarOhgbXAW1qgAIRBNHkeRcns49p5K9otzxQX/S5BJ/i
8Wc5VqAHlqpDAeRN0slBFk5b46GrfCM0vvBiumcl0IZhxESXSN5lneqpIohPF0nq
r1/WWyaRdIE36xqIMv02mAgujBqkmQ==
=2+YG
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
