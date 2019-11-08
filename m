Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F87A21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214758;
	bh=HIUUz2JP1Dlj/ZRB9S59Oi8may8POQY+554i6BYD2nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3GUYnCLYoPbIoabHd4INwivnbrVeVQpBugHtauAwX6fYE6A2+ZpJxBufyz3FNuXe
	 2OsmoYY8wLy8uxvXBkc8j3EYKNI0sxn+juiO11EoWiRTf9Vki0PU8B1h+0E5rytQn/
	 NvVTLI48+3YacqkHDcHjiaOfF970VSIrA7SxxDIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbfKHMF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:05:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58504 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbfKHMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u1LSxi/xCIm7BKmi90jrl3S/RxiU2mUU9mchFDPyUmk=; b=wvPi+97JaYr5DNz3EiEYA8J1B
        86NnGoS8DUz4donPwa6uIK0Uh/VQnx7asQLshI9hePIgRQnLk6IDsNzfQMwbGo108UXP4p4RpUAWo
        uxPeOBGlRcjfUpV2/TkglWeRMWvv4sKtKaZJ7A5ygAf95Tl9ZuqOPJYMbv6xznlW3zjEs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT31S-0007Cx-Fg; Fri, 08 Nov 2019 12:05:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 959772740C6C; Fri,  8 Nov 2019 12:05:49 +0000 (GMT)
Date:   Fri, 8 Nov 2019 12:05:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 124/205] gpio: of: Handle SPI chipselect
 legacy bindings
Message-ID: <20191108120549.GA5532@sirena.co.uk>
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-124-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20191108113752.12502-124-sashal@kernel.org>
X-Cookie: Life is like a simile.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 06:36:31AM -0500, Sasha Levin wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>=20
> [ Upstream commit 6953c57ab1721ce57914fc5741d0ce0568756bb0 ]
>=20
> The SPI chipselects are assumed to be active low in the current
> binding, so when we want to use GPIO descriptors and handle
> the active low/high semantics in gpiolib, we need a special
> parsing quirk to deal with this.

This stuff is *incredibly* fragile, are we sure this isn't manifiesting
in later kernels as a result of some other fix or cleanup exposing
issues and won't break without that fixup?  I loose track of all the
GPIO stuff.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3FWhwACgkQJNaLcl1U
h9D6VAf/aQvUCk5KwmYDafiih+sMdQS5rdG1M0qIchk9PsPJfHsAk/+c+Alwdcq5
VFhvlX/FDZspFImn1yh2S+YblDxd084LRo3bC/aLlzt5BC3hLBRQoqR3np12R/6B
sE1WLP9j1G85zUpvCluxCodf5QUPeijr5ByW+L7q70Dmovx8YI8EsNMG7ady8drc
9sdnO+kpoLizkvJDPsSY67RcxSHmD3gdxq28Bsnc8q2HuHq545Ypip8EicHP1ptX
Mt+D5+kjLIztZssCVjpYK8Vssqm6kSiz8Acaq7MShBSAo6pVvdDU2cNoLmGXyezg
R4EkfCZITRI4doWFNGv5hshc54GSng==
=lio8
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
