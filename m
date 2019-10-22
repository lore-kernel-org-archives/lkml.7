Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA666214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbfJVQFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:05:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41087 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfJVQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:05:03 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iMweW-0007t2-Bf; Tue, 22 Oct 2019 18:04:59 +0200
Message-ID: <1ef138bcb511bdfeff798edf93b9aa8bd06d6e22.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] ARM: dts: imx6qdl-zii-rdu2: Fix accelerometer
 interrupt-names
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 22 Oct 2019 18:04:25 +0200
In-Reply-To: <20191022040500.18548-2-andrew.smirnov@gmail.com>
References: <20191022040500.18548-1-andrew.smirnov@gmail.com>
         <20191022040500.18548-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 21.10.2019, 21:04 -0700 schrieb Andrey Smirnov:
> According to Documentation/devicetree/bindings/iio/accel/mma8452.txt,
> the correct interrupt-names are "INT1" and "INT2", so fix them
> accordingly.
> 
> While at it, modify the node to only specify "INT2" since providing
> two interrupts is not necessary or useful (the driver will only use
> one).
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> [andrew.smirnov@gmail.com modified the patch to drop INT1]
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org,
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> Original patch from Fabio can be seen here:
> 
> https://lore.kernel.org/linux-arm-kernel/20191010125300.2822-1-festevam@gmail.com/
> 
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 8d46f7b2722b..a8c86e621b49 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -358,8 +358,8 @@
>  		compatible = "fsl,mma8451";
>  		reg = <0x1c>;
>  		interrupt-parent = <&gpio1>;
> -		interrupt-names = "int1", "int2";
> -		interrupts = <18 IRQ_TYPE_LEVEL_LOW>, <20 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "INT2";
> +		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
>  	};
>  
>  	hpa2: amp@60 {
> @@ -849,7 +849,6 @@
>  &iomuxc {
>  	pinctrl_accel: accelgrp {
>  		fsl,pins = <
> -			MX6QDL_PAD_SD1_CMD__GPIO1_IO18		0x4001b000
>  			MX6QDL_PAD_SD1_CLK__GPIO1_IO20		0x4001b000
>  		>;
>  	};

