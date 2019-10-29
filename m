Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A2CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B7420656
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfJ2T1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:27:31 -0400
Received: from mailoutvs40.siol.net ([185.57.226.231]:53266 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbfJ2T1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:27:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id A4D1F5217E6;
        Tue, 29 Oct 2019 20:27:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id erKjFXoge42C; Tue, 29 Oct 2019 20:27:28 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 4259D521829;
        Tue, 29 Oct 2019 20:27:28 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id BDD29520F9A;
        Tue, 29 Oct 2019 20:27:24 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/2] ARM64: dts: allwinner: add pineh64 model A
Date:   Tue, 29 Oct 2019 20:27:24 +0100
Message-ID: <2429102.hHRkGMXE12@jernej-laptop>
In-Reply-To: <1572376663-22023-3-git-send-email-clabbe@baylibre.com>
References: <1572376663-22023-1-git-send-email-clabbe@baylibre.com> <1572376663-22023-3-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 29. oktober 2019 ob 20:17:43 CET je Corentin Labbe napisal(a):
> This patch adds the model A of the PineH64.
> The model A has the same size of the pine64 and has a PCIE slot.
> 
> The only devicetree difference with the pineH64 model B, is the PHY
> regulator.
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |  5 ++++
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../allwinner/sun50i-h6-pine-h64-modelA.dts   | 26 +++++++++++++++++++
>  3 files changed, 32 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> b/Documentation/devicetree/bindings/arm/sunxi.yaml index
> 9a1e4992b9e9..0059925a3395 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -594,6 +594,11 @@ properties:
>            - const: pine64,pine64-plus
>            - const: allwinner,sun50i-a64
> 
> +      - description: Pine64 PineH64 model A
> +        items:
> +          - const: pine64,pine-h64-modelA
> +          - const: allwinner,sun50i-h6
> +
>        - description: Pine64 PineH64 model B
>          items:
>            - const: pine64,pine-h64-modelB
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile index d2418021768b..6bda5d9961c8
> 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelA.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA.dts new file mode
> 100644
> index 000000000000..fef47687c85e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019 Corentin LABBE <clabbe@baylibre.com>
> + */
> +
> +#include "sun50i-h6-pine-h64.dts"
> +
> +/ {
> +	model = "Pine H64 model A";
> +	compatible = "pine64,pine-h64-modelA", "allwinner,sun50i-h6";
> +
> +	reg_gmac_3v3: gmac-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-gmac-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <100000>;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +};
> +
> +&emac {
> +	phy-supply = <&reg_gmac_3v3>;
> +};

You forgot to include node mentioned here:
https://lkml.org/lkml/2019/8/16/309

Best regards,
Jernej



