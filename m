Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916A4C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE22080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfDURYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:24:41 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55767 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:24:40 -0400
X-Originating-IP: 93.23.249.69
Received: from localhost (69.249.23.93.rev.sfr.net [93.23.249.69])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 60319240010;
        Sun, 21 Apr 2019 17:24:36 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jason@lakedaemon.net, andrew@lunn.ch, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: armada-38x: add interrupts for watchdog
In-Reply-To: <20190305201924.14853-2-chris.packham@alliedtelesis.co.nz>
References: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz> <20190305201924.14853-2-chris.packham@alliedtelesis.co.nz>
Date:   Sun, 21 Apr 2019 19:24:35 +0200
Message-ID: <874l6r8e5o.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> The first interrupt is for the regular watchdog timeout. Normally the
> RSTOUT line will trigger a reset before this interrupt fires but on
> systems with a non-standard reset it may still trigger.
>
> The second interrupt is for a timer1 which is used as a pre-timeout for
> the watchdog.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - new, split out from "watchdog: orion_wdt: use timer1 as a pretimeout"
>
>  arch/arm/boot/dts/armada-38x.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>

Applied on mvebu/dt

Thanks,

Gregory


> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 929459c42760..fc550c640ca8 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -376,6 +376,8 @@
>  				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
>  				clocks = <&coreclk 2>, <&refclk>;
>  				clock-names = "nbclk", "fixed";
> +				interrupts-extended = <&gic GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&gic GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
>  			cpurst: cpurst@20800 {
> -- 
> 2.21.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
