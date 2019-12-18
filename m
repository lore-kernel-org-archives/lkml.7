Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB81C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C1E227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576669588;
	bh=AsC2IgWPzLMS684v1+6jrfz69eVm0rBJI831T+JRfWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQA81+8Th3yXEZp5FfDzYwBq6uy++sz0JUazrKa9nu2cy2WpQKtTMkvLGCtNirk09
	 OO8fx+pX8CzAbKjFrNKQho88VQmOUGSh7BUHwCtOsEYlBtoBd5MyWBmhsM28R7G6Ic
	 +Xg+bklQMUiV86aw5KEN0NaWUrqUHd2bdiMeOHwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLRLq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:46:27 -0500
Received: from foss.arm.com ([217.140.110.172]:43340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRLq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:46:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DC430E;
        Wed, 18 Dec 2019 03:46:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE713F6CF;
        Wed, 18 Dec 2019 03:46:26 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:46:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 03/11] ASoC: wcd934x: add support to wcd9340/wcd9341
 codec
Message-ID: <20191218114624.GB3219@sirena.org.uk>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
 <20191217121642.28534-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20191217121642.28534-4-srinivas.kandagatla@linaro.org>
X-Cookie: Power is poison.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2019 at 12:16:34PM +0000, Srinivas Kandagatla wrote:

> +config SND_SOC_WCD934X
> +	tristate "WCD9340/WCD9341 Codec"
> +	depends on SLIMBUS
> +	select REGMAP_SLIMBUS
> +	select REGMAP_IRQ
> +	help

Why does this not depend on the MFD change?

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl36EY8ACgkQJNaLcl1U
h9CJewf/UNyw0O0xrJ7lqLqOtpx2X0NT8thQQh2NcyNp4m8qbmYDJ15qmTMAM+yj
mP+3wP/Qf8hD8sTAidpOg9krTC5rCGi8k7lHizePkZEkmxilFp6IEr4xPSFimHhR
bp2p/9XvAgJcXlsDTaRRknBtErDfSIfcNmPjC9Lz0Q9jAlQKMjPVj9K7Wm4o96zQ
L/Cz3jQOHeNSRCBQKjkMDUSesDQIzZUAAEShRq82RT+dxa8K531f8AoFQKf+D2KZ
3EmrYGye3MJgMTZ+8elie/8uBaRKqhCei3zZecF05lN43KThV/U5aEGY/p/RW6O4
xnnuzr+hkC5Hu7jMR8DbzcNHfEuS+g==
=vos4
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
