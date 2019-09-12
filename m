Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF0C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276E20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568280761;
	bh=NCCGHqcUsoAmYmJAE8U3jvNgVr+TTfXH7LprAZ8aZlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L/XmY4Wr+nU50/gvCo0U4VBXrBBotr2fWSVkyJrH7NjjSvYpAe3JJjgJdMjEjkS11
	 MXAkjxWC+etA+/TlB+Kyy1FZuVK19gdzBLzyndSSagX8oyxjVQ7l3MXKHzBTKfDFAD
	 dHygBkHXMVYORhaZzL8ABhTPcAY9KflxH7jM/ZnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfILJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:32:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfILJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3mFlkL6LvJaHhmldjRcA8fde/UOpm7KObuOHbWtlrTc=; b=bwBZKqN5kk1WMU5x6Av29Vme7
        4JM6sEhhrGVE5L/2MjiW4Q2LSCxBNhNzfX03LsqYWAuukw9LfptenmjZxSk1lrfy2txvcOtldCall
        OXN22cYVw3wKOPzL+sjnK6oQ5FBrI+av85lScnLBbjnnByrmC0nRfD6dsYbNHbpU7DWBo=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8LSp-0006Qq-L8; Thu, 12 Sep 2019 09:32:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EF65DD00AB0; Thu, 12 Sep 2019 10:32:30 +0100 (BST)
Date:   Thu, 12 Sep 2019 10:32:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: Kconfig: Fix EXYNOS driver dependencies
Message-ID: <20190912093230.GG2036@sirena.org.uk>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
 <79755cb29b8c23709e346b5dd290481a36627648.1568239378.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aPOcx+xoD6gZZHnz"
Content-Disposition: inline
In-Reply-To: <79755cb29b8c23709e346b5dd290481a36627648.1568239378.git.amit.kucheria@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aPOcx+xoD6gZZHnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2019 at 03:48:48AM +0530, Amit Kucheria wrote:

> Push various EXYNOS drivers behind ARCH_EXYNOS dependency so that it
> doesn't get enabled by default on other platforms.

>  config REGULATOR_S2MPS11
>  	tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
> +	depends on ARCH_EXYNOS
>  	depends on MFD_SEC_CORE
>  	help
>  	 This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage

This doesn't match the changelog at all.  This driver is not
enabled by default since it's just a normal tristate, they are
disabled by default.  As far as I can see all this change will
do is reduce our build test coverage by adding an artificial
dependency without an || COMPILE_TEST.

--aPOcx+xoD6gZZHnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16EK4ACgkQJNaLcl1U
h9Dn7gf/YZh55qkA7bTLAJHRocCdo/3Gm4Me5DO+Rnt0FyEcbwX3+E2akxCedkaX
vqvhDX4nSIwMVmq6qzNR+c4H2lZcev0KD0Glwi6Hi5olMJAiHYmVl9Da2MNPiYAe
mnlnY/bgrpmJ41nqm63s2PvtEWp+PL2QbnIikDS4Rb5vGLjTQGSmhGlU3o6dB3Om
WxlDHZkCMO/9csX/UHjJUro2TPkgc9FfLnqx9N3Rs5/pL6zdXtZL5TK+6PGpkC/B
NRx26W9Az9yIWMAu0MO7QPlcpT1b1O8dCYg3mM6fMjSiv9y3u8NLnp+zwhrHfIx+
3xM5RHEbBYANmiIr66vXfKMKbQvvEw==
=hxyF
-----END PGP SIGNATURE-----

--aPOcx+xoD6gZZHnz--
