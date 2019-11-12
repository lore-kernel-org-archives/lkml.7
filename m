Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB936C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F4C21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573560300;
	bh=8CyrwQqWuWtGzFOGNOd9CaCBPI1ujJWiRZuhD4hF3RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CTyjcfZG726lYRYZmEfDbkNgHIwJ7LPng2kRasdwYk4+t6D1Mkxk3uQNKFnlamxsy
	 VbJTfL3QXmMhEh28ECKlHpBn+php2rTrGCdkhIFNM7baH1FZyg+ZW88AKpwZdLTezA
	 i/QSEXP65/4bPmh3GsNgnZXBlgQQiz2EBKcr/V1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:04:59 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09BD206BB;
        Tue, 12 Nov 2019 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573560298;
        bh=8CyrwQqWuWtGzFOGNOd9CaCBPI1ujJWiRZuhD4hF3RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xowkB0eogD9EPaWr1+/4AS9/UT33jJFdwPD+Sr+t4LeR5XQv3/YjNpa69e9Mv115t
         WWTqSnJHBd3pKI62UE0lr6aq29CLVUbnOEhlhoD9LiBKC5SoM6LgYSTPNs24DCApPn
         UR2H9XB8BrZDPsxlGIKP8kSCJCM8sE/yuOhleG0Y=
Date:   Tue, 12 Nov 2019 13:04:55 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/2] ARM64: dts: allwinner: add pineh64 model B
Message-ID: <20191112120455.GY4345@gilmour.lan>
References: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
 <1573316433-40669-3-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nbjgUHX6eyHhY7pW"
Content-Disposition: inline
In-Reply-To: <1573316433-40669-3-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nbjgUHX6eyHhY7pW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 09, 2019 at 04:20:33PM +0000, Corentin Labbe wrote:
> This patch adds the model B of the PineH64.
> The model B is smaller than the pine64 model A and has no PCIE slot.
>
> The only devicetree difference with the pineH64 model A, is the PHY
> regulator and the HDMI connector node.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |  5 +++++
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../allwinner/sun50i-h6-pine-h64-modelB.dts   | 21 +++++++++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index b8ec616c2538..227217bf28df 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -604,6 +604,11 @@ properties:
>            - const: pine64,pine-h64-modelA
>            - const: allwinner,sun50i-h6
>
> +      - description: Pine64 PineH64 model B
> +        items:
> +          - const: pine64,pine-h64-modelB
> +          - const: allwinner,sun50i-h6
> +
>        - description: Pine64 LTS
>          items:
>            - const: pine64,pine64-lts
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index d2418021768b..bda89b9ccb4a 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelB.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts
> new file mode 100644
> index 000000000000..063a85223faa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019 Corentin LABBE <clabbe@baylibre.com>
> + */
> +
> +#include "sun50i-h6-pine-h64.dts"
> +
> +/ {
> +	model = "Pine H64 model B";
> +	compatible = "pine64,pine-h64-modelB", "allwinner,sun50i-h6";

compatibles are usually lowercase, what about pine64,pine-h64-model-b?

Maxime

--nbjgUHX6eyHhY7pW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcqf5wAKCRDj7w1vZxhR
xdIeAQCeSktgU0WsEK7fUaiXepU4KkkNODgAAs3FAXtPNVNcEwD9HtsCpDRw2/qL
Yzl0aKt3LmMY77sWGMydllvddxcgdg4=
=2aPf
-----END PGP SIGNATURE-----

--nbjgUHX6eyHhY7pW--
