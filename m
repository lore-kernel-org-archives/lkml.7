Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C965AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A548320857
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCQRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 13:47:59 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51214 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfCQRr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 13:47:59 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Mar 2019 13:47:58 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id E76DDA542E;
        Sun, 17 Mar 2019 17:39:49 +0000 (UTC)
Message-ID: <2485e6c52810df376a0df6eb7f749f35b7b19044.camel@aosc.xyz>
Subject: Re: [PATCH 0/7] Timer & SPI support for Allwinner suniv F1C100s
From:   Icenowy Zheng <icenowy@aosc.xyz>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Mar 2019 01:39:44 +0800
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-02-11一的 12:21 +0300，Mesih Kilinc写道：
> This is followup series for F1C100s initial support patchset. 
> All patches merged except patch 1 ~ 2 which is related to timer.
> I am resending those since they are already have Acked tags.

Ping.

Could you please merge these timer-related patches?

Thanks!
Icenowy

> 
> Our dt-bindings for F1C100s are merged, we can now use them at our 
> device tree source - patch 3.
> 
> Also this series add spi support and enables spi flash at Lichee-pi
> Nano
> in patch 4 ~ 7. This patches are based on Icenowy's work.
> 
> Thanks!
> 
> Mesih Kilinc (7):
>   dt-bindings: timer: Add Allwinner suniv timer
>   clocksource: sun4i: add a compatible for suniv
>   ARM: dts: suniv: Add dt-binding headers for F1C100s
>   dt-bindings: spi: Add Support for Allwinner F1C100s
>   ARM: dts: suniv: Add SPI device-tree nodes
>   ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
>   ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano
> 
>  .../devicetree/bindings/spi/spi-sun6i.txt          |  5 +-
>  .../bindings/timer/allwinner,sun4i-timer.txt       |  4 +-
>  arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  | 13 ++++++
>  arch/arm/boot/dts/suniv-f1c100s.dtsi               | 53
> +++++++++++++++++++---
>  drivers/clocksource/timer-sun4i.c                  |  5 +-
>  5 files changed, 70 insertions(+), 10 deletions(-)
> 

