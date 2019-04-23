Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC7120811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfDWQFs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:05:48 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57891 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:05:48 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D06DBFF811;
        Tue, 23 Apr 2019 16:05:45 +0000 (UTC)
Date:   Tue, 23 Apr 2019 18:05:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: h6: add r_watchog node
Message-ID: <20190423160545.muolantrdppz35rz@flea>
References: <20190411154534.25563-1-peron.clem@gmail.com>
 <20190411154534.25563-3-peron.clem@gmail.com>
 <CAJiuCcc2CrEBQEoon9p=pitrjqoy6tzOSjhjBY3=oXNCHdiZ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJiuCcc2CrEBQEoon9p=pitrjqoy6tzOSjhjBY3=oXNCHdiZ5A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:00:42PM +0200, Clément Péron wrote:
> Hi,
>
> On Thu, 11 Apr 2019 at 17:34, Clément Péron <peron.clem@gmail.com> wrote:
> >
> > Allwinner H6 has a r_watchdog similar to A64.
> >
> > Declare it in the device-tree.
> >
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index 5c2f5451227b..66dc684a378e 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -622,6 +622,13 @@
> >                         #reset-cells = <1>;
> >                 };
> >
> > +               r_watchdog: watchdog@7020400 {
> > +                       compatible = "allwinner,sun50i-a64-wdt",
> > +                                    "allwinner,sun6i-a31-wdt";
> > +                       reg = <0x07020400 0x20>;
> > +                       interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > +               };
>
> I have set the same compatible as A64 because regarding the User
> Manual they have exactly the same memory mapping.
> However we don't know really if it's the same IP version, maybe there
> will be an errata one day.
> So I would like to know if it's better to define the h6-wdt also
>   compatible =  "allwinner,sun50i-h6-wdt", "allwinner,sun50i-a64-wdt",
>                                  "allwinner,sun6i-a31-wdt";
>
> I would say Yes, but with this logic we would have to had a new
> compatible each time there is a  new SoC.

Why not just having the A31 compatible?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
