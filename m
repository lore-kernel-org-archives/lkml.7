Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEB1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE54320820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="jmd7zXS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDIWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:00:44 -0400
Received: from vps.xff.cz ([195.181.215.36]:47896 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfDIWAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 18:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554847240; bh=qcNC0APQkwtDIo5GDKLxptbVItoD4PQj7iG6Im1qrow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmd7zXS4FWc5lI0dCbmS4VlBYIFxdlaHfMwXmxwQY5vMMvqkQkxJY5dkAMlGp2hSB
         BazKByhSOfnjFlIoGHqTYwdoShSML3JHNmbvW7d84GqKundQuvnZQe/n7MC9zAhCMK
         euNUfdev97vxhVgF6yKpG0yvPBLCYlNgwNcOxfDY=
Date:   Wed, 10 Apr 2019 00:00:40 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH 4/6] ARM: dts: sun8i: a83t: Add device node for CSI
 (Camera Sensor Interface)
Message-ID: <20190409220040.3sx456gefmjq3t3g@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20190408165744.11672-1-wens@kernel.org>
 <20190408165744.11672-5-wens@kernel.org>
 <20190409075804.4zrwjil7ie2gjigu@flea>
 <CAGb2v64CYV68Q0a7x5p-XabS74vaQWP3paPopodmqQPTOrq2gQ@mail.gmail.com>
 <20190409082818.z33mq2qrxethldzf@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409082818.z33mq2qrxethldzf@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:28:18AM +0200, Maxime Ripard wrote:
> On Tue, Apr 09, 2019 at 04:07:34PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 9, 2019 at 3:58 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > On Tue, Apr 09, 2019 at 12:57:42AM +0800, Chen-Yu Tsai wrote:
> > > > From: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > The A83T SoC has a camera sensor interface (known as CSI in Allwinner
> > > > lingo), which is similar to the one found on the A64 and H3. The only
> > > > difference seems to be that support of MIPI CSI through a connected
> > > > MIPI CSI-2 bridge.
> > > >
> > > > Add a device node for it, and pinctrl nodes for the commonly used MCLK
> > > > and 8-bit parallel interface. The property /omit-if-no-ref/ is added to
> > > > the pinctrl nodes to keep the device tree blob size down if they are
> > > > unused.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-a83t.dtsi | 31 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > index f739b88efb53..0c52f945fd5f 100644
> > > > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > @@ -682,6 +682,20 @@
> > > >                       #interrupt-cells = <3>;
> > > >                       #gpio-cells = <3>;
> > > >
> > > > +                     /omit-if-no-ref/
> > > > +                     csi_8bit_parallel_pins: csi-8bit-parallel-pins {
> > > > +                             pins = "PE0", "PE2", "PE3", "PE6", "PE7",
> > > > +                                    "PE8", "PE9", "PE10", "PE11",
> > > > +                                    "PE12", "PE13";
> > > > +                             function = "csi";
> > > > +                     };
> > > > +
> > > > +                     /omit-if-no-ref/
> > > > +                     csi_mclk_pin: csi-mclk-pin {
> > > > +                             pins = "PE1";
> > > > +                             function = "csi";
> > > > +                     };
> > > > +
> > > >                       emac_rgmii_pins: emac-rgmii-pins {
> > > >                               pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > > >                                      "PD11", "PD12", "PD13", "PD14", "PD18",
> > > > @@ -994,6 +1008,23 @@
> > > >                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> > > >               };
> > > >
> > > > +             csi: camera@1cb0000 {
> > > > +                     compatible = "allwinner,sun8i-a83t-csi";
> > > > +                     reg = <0x01cb0000 0x1000>;
> > > > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                     clocks = <&ccu CLK_BUS_CSI>,
> > > > +                              <&ccu CLK_CSI_SCLK>,
> > > > +                              <&ccu CLK_DRAM_CSI>;
> > > > +                     clock-names = "bus", "mod", "ram";
> > > > +                     resets = <&ccu RST_BUS_CSI>;
> > > > +                     status = "disabled";
> > > > +
> > > > +                     csi_in: port {
> > > > +                             #address-cells = <1>;
> > > > +                             #size-cells = <0>;
> > >
> > > If we expect a single enpoint, then we don't need the address-cells
> > > and size-cells properties.
> >
> > I wouldn't bet on anything. The way the Q8 tablets did front/back cameras
> > is kind of genius if not very hacky. They have two "identical" sensors
> > on the same I2C bus and CSI bus, with shared reset line but separate
> > shutdown lines. Since they are identical, they also have the same I2C
> > address. I haven't figured out how to model this in the device tree.
> >
> > The point is, it's perfectly possible to have two or more sensors use
> > the same controller, provided only one be active at a time.
> 
> Right, but I guess the common case would be to have a single sensor,
> where that wouldn't be needed.
> 
> In odd cases, we can always specify it in the DTS, and if it becomes
> common enough, we can move it to the DTSI.

I'm planning on having two sensors there, in a less arcane setup,
though - no shared resets, and different I2C addresses.

Anyway, I can confirm that CSI driver works fine on A83T with just
a DTSI patch, even without the clock patch in this series. I've been
running it for quite a while that way without any issues (different
camera chip than the ones being used by wens).

regards,
	o.

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

