Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE294C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91000206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565789608;
	bh=zlMOkJBdmi2gPUlrd7C9NUTOKbMwTG3hN1hXwIzYsG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jvOTVnXFxmSR/5fEqY2J3zi2Ge5TGR5Rv+cEtfohpGCK1QxsnpNnNhmAdqogFriTH
	 3Cyk7eFzE28RBo14W672Ty4q1SV7SPeUfrJ7frP2k6Vav5+Dt/AQMJQgQ08ClDauz2
	 HaK+VoOZgeVjlGPed9RY7Ms9F2blUA5QG22gxu1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfHNNd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfHNNd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:33:26 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E20206C2;
        Wed, 14 Aug 2019 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565789605;
        bh=zlMOkJBdmi2gPUlrd7C9NUTOKbMwTG3hN1hXwIzYsG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWebABrtTutybc0F50w0sWkki47iTK1/wE4Cv9q0a1SkaYz7qNFdogv25dQKDBorx
         ByU+RzvCcwRYMVJwauL36kt1byP5goGenSWlw0WxX+XqnwPVce8hjVewrnFeczxBPV
         AwGe0/9w3MyqW8gu2zUSb5bjhPtFBikSlUEo+Z+o=
Date:   Wed, 14 Aug 2019 15:33:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64
 modelA evaluation board
Message-ID: <20190814133322.dawzv3ityakxtqs4@flea>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
 <20190812094000.ebdmhyxx7xzbevef@flea>
 <20190814131741.GB24324@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pnw3csfbr4joiprs"
Content-Disposition: inline
In-Reply-To: <20190814131741.GB24324@Red>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnw3csfbr4joiprs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 03:17:41PM +0200, Corentin Labbe wrote:
> On Mon, Aug 12, 2019 at 11:40:00AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 08, 2019 at 10:42:53AM +0200, Corentin Labbe wrote:
> > > This patch adds the evaluation variant of the model A of the PineH64.
> > > The model A has the same size of the pine64 and has a PCIE slot.
> > >
> > > The only devicetree difference with current pineH64, is the PHY
> > > regulator.
> > >
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > >  .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
> > >  2 files changed, 27 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > > index f6db0611cb85..9a02166cbf72 100644
> > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > @@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> > > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelA-eval.dtb
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > > new file mode 100644
> > > index 000000000000..d8ff02747efe
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > > @@ -0,0 +1,26 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > +/*
> > > + * Copyright (C) 2019 Corentin Labbe <clabbe.montjoie@gmail.com>
> > > + */
> > > +
> > > +#include "sun50i-h6-pine-h64.dts"
> > > +
> > > +/ {
> > > +	model = "Pine H64 model A evaluation board";
> > > +	compatible = "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h6";
> > > +
> > > +	reg_gmac_3v3: gmac-3v3 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "vcc-gmac-3v3";
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		startup-delay-us = <100000>;
> > > +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
> > > +		enable-active-high;
> > > +	};
> > > +
> > > +};
> > > +
> > > +&emac {
> > > +	phy-supply = <&reg_gmac_3v3>;
> > > +};
> >
> > I might be missing some context here, but I'm pretty sure that the
> > initial intent of the pine h64 DTS was to support the model A all
> > along.
> >
>
> The regulator changed between modelA and B.
> See this old patchset (supporting modelA) https://patchwork.kernel.org/patch/10539149/ for example.

I'm not sure what your point is, but mine is that everything about the
model A should be in sun50i-h6-pine-h64.dts.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pnw3csfbr4joiprs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVQNogAKCRDj7w1vZxhR
xT3OAP4oNFqLOfs3vnBPuOIi+wCdRxEWrgoK0NnCtdFdQ/WijwD/b3IA7ktlzjkW
QWsPV6u/3hNUu1l1GBxa8MRTSnkLbgQ=
=Tdd5
-----END PGP SIGNATURE-----

--pnw3csfbr4joiprs--
