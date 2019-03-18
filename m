Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6020835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCRHTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:19:06 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52136 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfCRHTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:19:05 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 55BBE15FE96;
        Mon, 18 Mar 2019 07:18:59 +0000 (UTC)
Message-ID: <8e1cf9c7111a423ce7cc32a6759d16e4197b87d9.camel@aosc.xyz>
Subject: Re: [PATCH 0/7] Timer & SPI support for Allwinner suniv F1C100s
From:   Icenowy Zheng <icenowy@aosc.xyz>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Mar 2019 15:18:56 +0800
In-Reply-To: <177e2598-3491-03af-8638-c60e77cc4a34@linaro.org>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
         <2485e6c52810df376a0df6eb7f749f35b7b19044.camel@aosc.xyz>
         <177e2598-3491-03af-8638-c60e77cc4a34@linaro.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-03-17日的 21:52 +0100，Daniel Lezcano写道：
> On 17/03/2019 18:39, Icenowy Zheng wrote:
> > 在 2019-02-11一的 12:21 +0300，Mesih Kilinc写道：
> > > This is followup series for F1C100s initial support patchset. 
> > > All patches merged except patch 1 ~ 2 which is related to timer.
> > > I am resending those since they are already have Acked tags.
> > 
> > Ping.
> > 
> > Could you please merge these timer-related patches?
> 
> Hi,
> 
> I acked the timer-related patches. If you resend the patches with my
> acked-by I will consider them to go through the allwinner tree.
> 
> Do you want me to take 1 and 2 through my tree?

Please. They also have the ACK from Allwinner/sunXi maintainer.

> 
> 
> 
> > > Our dt-bindings for F1C100s are merged, we can now use them at
> > > our 
> > > device tree source - patch 3.
> > > 
> > > Also this series add spi support and enables spi flash at Lichee-
> > > pi
> > > Nano
> > > in patch 4 ~ 7. This patches are based on Icenowy's work.
> > > 
> > > Thanks!
> > > 
> > > Mesih Kilinc (7):
> > >   dt-bindings: timer: Add Allwinner suniv timer
> > >   clocksource: sun4i: add a compatible for suniv
> > >   ARM: dts: suniv: Add dt-binding headers for F1C100s
> > >   dt-bindings: spi: Add Support for Allwinner F1C100s
> > >   ARM: dts: suniv: Add SPI device-tree nodes
> > >   ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
> > >   ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano
> > > 
> > >  .../devicetree/bindings/spi/spi-sun6i.txt          |  5 +-
> > >  .../bindings/timer/allwinner,sun4i-timer.txt       |  4 +-
> > >  arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  | 13 ++++++
> > >  arch/arm/boot/dts/suniv-f1c100s.dtsi               | 53
> > > +++++++++++++++++++---
> > >  drivers/clocksource/timer-sun4i.c                  |  5 +-
> > >  5 files changed, 70 insertions(+), 10 deletions(-)
> > > 
> 
> 

