Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E51C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2FD21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568196764;
	bh=8L3aNfxvGx7nLHvhGhIYBpVxJTzSNXsZ2mqZSDzbkx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MKEloUD5rUhAUmIwdJwXt3fZuQ4DfMvGOMCmetXAIxO+TNOB2A9iv7d6k2plZm4vS
	 YFQyDi1gzq6tOyKBxjSGQb8Tgp7KmZ/NUQ+Xh4TXVpq0oUuvTmVtw/gtPENlLkH7ZR
	 xp1h2tC8Xfqg6YVH7+xKSPmD+ewFzsBhiuHjqg0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfIKKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:12:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfIKKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ep0j7m5xNfG4CR6HHkPWK2kdBVsDxedxi47kQTEiChI=; b=u0FZLYzmH84kRI/HHbIR4jvdR
        2C4c+MORLpTVFvfvtpOgUR72Ie81FZ0WI5cT7wZG/H0kPOJsJao2htnaEBzSIc9+GXIkGonEV1BjC
        cLWQEUlhORQUEIAUl9+71DDfz8HTcGXwmNVmObPsLP8BfRtYNie3TebUrcKAv5NOAhB7M=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7zbz-0007as-AB; Wed, 11 Sep 2019 10:12:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6E4F0D02A53; Wed, 11 Sep 2019 11:12:30 +0100 (BST)
Date:   Wed, 11 Sep 2019 11:12:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_mqs: Add MQS component driver
Message-ID: <20190911101230.GT2036@sirena.org.uk>
References: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
 <08524f143c18521680b724ab98375828fc18ab2b.1568169346.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HywJcj55HbA57jnN"
Content-Disposition: inline
In-Reply-To: <08524f143c18521680b724ab98375828fc18ab2b.1568169346.git.shengjiu.wang@nxp.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HywJcj55HbA57jnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 10:42:39AM -0400, Shengjiu Wang wrote:

This looks good, a few minor comments below but nothing major -
it's mostly nits with the DT binding.

> --- /dev/null
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC IMX MQS driver
> + *
> + * Copyright (C) 2014-2019 Freescale Semiconductor, Inc.
> + *

Please make the entire comment block a C++ comment so things look
neater.

> +	/* On i.MX6sx the MQS control register is in GPR domain
> +	 * But in i.MX8QM/i.MX8QXP the control register is moved
> +	 * to its own domain.
> +	 */
> +	if (of_device_is_compatible(np, "fsl,imx8qm-mqs"))
> +		mqs_priv->use_gpr = false;
> +	else
> +		mqs_priv->use_gpr = true;

The GPR was listed as a required property in the binding document
but it is only needed here so the binding document should say
"required if compatible is...".

> +	} else {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		regs = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(regs))

You can use devm_platform_ioremap_resource() here.

> +		mqs_priv->ipg = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(mqs_priv->ipg)) {
> +			dev_err(&pdev->dev, "failed to get the clock: %ld\n",
> +				PTR_ERR(mqs_priv->ipg));
> +			goto out;
> +		}

The core clock wasn't listed in the bindings document.

--HywJcj55HbA57jnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14yI0ACgkQJNaLcl1U
h9BO/Af/aIFQPppNc8K51nmTQbe5/qlY6KawrXb2O2vnWrT0cZMpaXII/WfVHarC
N5tQrIStSR99l5V93WUkKolVo3SJS2Gg5Opo4XLHTFt9vHlhOYX8iRt0xz5B+UF9
qKo8AHuR0kOSAsRy2w9lEFq07cRPSFR9bQH3axNxUybh7v6YEbo473gX0rRf3qUL
HRfeAMEzjuK5CQz74088qfUQmfiDoVbCC+cbvkUeWhR0/VbZA3zdeos3wbUDRqrA
KJGMzwAyQISn8+uXAEUNzmepdcKl/tec9JJCjZHh/lSTnMQwAwj6/NPhDhIZwCmy
5GYinXK/xsebKn2yLidfvP2yyzICdw==
=GpDq
-----END PGP SIGNATURE-----

--HywJcj55HbA57jnN--
