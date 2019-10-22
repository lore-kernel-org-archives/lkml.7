Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF391CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81DF205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762402;
	bh=qzw4H24i5wT2P9XqsoiLtE39qc3Xr5JeEHgOsZqF2E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P5BZpZ3eI+4dORJgzIFNrRfkhq4Z9qeYvn9Dv8QAezxno7lD1/RR+8z3GmMmcgBJ6
	 +nmF7gsqjhQRAngep1L6YCEpeabj0PrNx/JOSqFeezh0nQaLoHqnsArQJFKif7G2Qe
	 v96am5m9ROHpGyzKBmYr1STwJXXX4GO6lYKpsqzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbfJVQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:40:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbfJVQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qzw4H24i5wT2P9XqsoiLtE39qc3Xr5JeEHgOsZqF2E8=; b=nmZ4YUJZkXoFq/0K0+fsp/oLi
        v6olQ5aRCRgeis8SLK8AL9g5WKFw1fwkNYSW2r0RJxXLxZCvA7WHLq2lu3GafBLvD4faZZEGhw+xO
        v36gO58/IlzFCRkEtqLIGPwX+jF1cHdODPGyEUbT4Ywsrn7OU92hktD0zZ2z2MGKvS5fU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxCQ-00074Z-Fm; Tue, 22 Oct 2019 16:39:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 039C42743259; Tue, 22 Oct 2019 17:39:57 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:39:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 32/46] ASoC: pxa: i2s: use normal MMIO accessors
Message-ID: <20191022163957.GW5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-32-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QVzQgM+zdZ3YWXqn"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-32-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QVzQgM+zdZ3YWXqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:47PM +0200, Arnd Bergmann wrote:
> To avoid dereferencing hardwired constant pointers from a global header
> file, change the driver to use devm_platform_ioremap_resource for getting
> an __iomem pointer, and then using readl/writel on that.

Acked-by: Mark Brown <broonie@kernel.org>

--QVzQgM+zdZ3YWXqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMN0ACgkQJNaLcl1U
h9AR2Qf+KErM5EMnNx2LKVCOPfSuSN0Tyx/CfJONY87iW8gmPKc33rZ7qwEETZOm
oJpXIqkpkv4i20C/g0p8tma1Tc5S3nSchO4+DGEXf6Ym/0EMz7XweRalM9IpdI9E
TjdnVCbBt1JXRGeHp7MJJb1/Y7pNUhmUiTA4Tjy9a2LLTCwNqjNplPFikzEpT7h8
UmcDTLkr/evh6CCETbmWcdFvWCYsqHi866/9VHvfU7lSAQ2agmxQ9roTZ/mQZpe4
0xpDBqHawfsw7hoHrLpdz3TQcu6p27muy9ECoJ08WiCY7qYt0vR7pEwItPHaQn27
VzNBaEhD/oaZIr7AtQ7335B0Z4zz3Q==
=0eC3
-----END PGP SIGNATURE-----

--QVzQgM+zdZ3YWXqn--
