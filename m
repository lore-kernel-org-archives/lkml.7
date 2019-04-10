Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E5C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957E32133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554892744;
	bh=IZmes9JcOdV8EervROILYHX7zM4zkKTIFV86xCcr6n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pp9zXwixdSB5tcBqKYWGOcQiTdNHnktBqT85FFi8WMv83zPCVXW48mA/wZUtT92EX
	 r8WOxjvXiORaF/iUrq9nCkTTBKcDY9inxpinKQu5mOkQyQAIrKpdzGtRm8tY5EOqE8
	 zfEWfBVdWMIZc8CFe9chiy42IQB/YxGlDFnG228c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfDJKjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:39:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rb8h7srweVIlCYh4WP9pjAPwHlZPiJE0uMHA8CLN9i8=; b=l7Hayi0088LbWc9ADpUGFFxWJ
        PXqnTvDun5HP6cw4EicPGx58bCHaDWe08syhvySJLcJlcvuinrrbYyfosIkW0y1M6/oyCgKhBZY7q
        WbNZkcglAWuW3fHIWzWDjDBo6ev8I84yppGrwU4vNOlh7ypAQjX5CWlElk8q51CJBV7Qo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEAd4-0007mC-F3; Wed, 10 Apr 2019 10:38:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2BC011128ED3; Wed, 10 Apr 2019 11:38:52 +0100 (BST)
Date:   Wed, 10 Apr 2019 11:38:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] regulator: Add support for stm32 power regulators
Message-ID: <20190410103852.GG6106@sirena.org.uk>
References: <1554737044-9460-1-git-send-email-p.paillet@st.com>
 <1554737044-9460-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <1554737044-9460-3-git-send-email-p.paillet@st.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 03:24:08PM +0000, Pascal PAILLET-LME wrote:

> +config REGULATOR_STM32_PWR
> +	bool "STMicroelectronics STM32 PWR"
> +	depends on ARCH_STM32

There's no build time dependency here, please also add an || COMPILE_TEST t=
o=20
help with build coverage.

> +int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct stm32_pwr_reg *priv =3D rdev_get_drvdata(rdev);
> +	u32 val;
> +
> +	val =3D readl_relaxed(priv->base + REG_PWR_CR3);
> +
> +	return (val & priv->ready_mask);
> +}

This looks like it's reading back a status bit from the hardware not the
state requested by software - I'd expect an _is_enabled() to reference
the same bit that's updated by the enable/disable functions.  This looks
like a better fit for _get_status().

> +	of_regulator_match(&pdev->dev, np, stm32_pwr_reg_matches,
> +			   STM32PWR_REG_NUM_REGS);

You don't need to open code the matching any more, just set of_match and
regulators_node in the regulator_desc and the core will do it for you.

> +MODULE_DESCRIPTION("STM32MP1 PWR voltage regulator driver");
> +MODULE_AUTHOR("Gabriel Fernandez <gabriel.fernandez@st.com>");
> +MODULE_LICENSE("GPL v2");

No signoff from Gabriel?

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytx7sACgkQJNaLcl1U
h9BwVgf+LLgiEYtwgfFTsrSp6gKGUw64bODOr0luZtJ6amf8o2zZSuNbVuNzP1Ys
mK2fUUATzt+Icf/Y/3/IPgAOkgsp/bXvaR1QpG++/Q29iwP0uMkJwM2Tf0pkUiEL
A8JfyoT0fHdVC4Q0UG6cYVfwZBaQM8FLgc6o32KqDqLSPDu0ii9rEDfdhJIqbMu+
3YEU1P8BsoMzVok3FUcEUuzXoYChT3yE0uuGzHrURwiTOjGIatsDNlQuyRfECRG9
kTM/UBk09kP/ZxIla3c83lOdiCv83GGGaP+G3yQvPIyEXU4MPdveoCQCuvw9RtxN
6+Af+T1TM6kk16CmFEpuWDL9x0Uq2A==
=tUtb
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
