Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592FF20675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Ojaeizz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbfEXIfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:35:41 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:37286 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389514AbfEXIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:35:41 -0400
Received: from g550jk.localnet (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6D2B1C1D14;
        Fri, 24 May 2019 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1558686937; bh=8QxbOGfJLKmBY8BnGjqJHLbP9D2w96jkIDyZThAA41g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ojaeizz5pLdCcF0xdLCfW2ni1k4DaVA/6/5fp3iYD4hTrR7fARGyYCfz5XnQRDoHI
         7h/ZuL2OpPXI3J+LHDxh1JlHJgpGe2DJBb1PlzoBfqK8WFhvQ3wa5it0XQv1AD4S2X
         FKdfKRnUKtB9iNVgwby3tNXv0SssAzJNxWfoQYqE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Date:   Fri, 24 May 2019 10:35:36 +0200
Message-ID: <4343071.IDWclfcoxo@g550jk>
In-Reply-To: <20190521142544.ma2xfu77bamk4hvc@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz> <EF411F71-D257-41FC-9248-B0E3F686B6B9@z3ntu.xyz> <20190521142544.ma2xfu77bamk4hvc@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 21. Mai 2019 16:25:44 CEST Maxime Ripard wrote:
> On Tue, May 21, 2019 at 03:52:47PM +0200, luca@z3ntu.xyz wrote:
> > On May 21, 2019 3:09:55 PM GMT+02:00, Maxime Ripard 
<maxime.ripard@bootlin.com> wrote:
> > >On Tue, May 21, 2019 at 08:43:45AM +0200, luca@z3ntu.xyz wrote:
> > >> On May 20, 2019 1:07:42 PM GMT+02:00, Maxime Ripard
> > >
> > ><maxime.ripard@bootlin.com> wrote:
> > >> >On Sat, May 18, 2019 at 07:09:30PM +0200, Luca Weiss wrote:
> > >> >> Add a node describing the KEYADC on the A64.
> > >> >> 
> > >> >> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > >> >> ---
> > >> >> 
> > >> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 +++++++
> > >> >>  1 file changed, 7 insertions(+)
> > >> >> 
> > >> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > >> >
> > >> >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > >> >
> > >> >> index 7734f70e1057..dc1bf8c1afb5 100644
> > >> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > >> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > >> >> @@ -704,6 +704,13 @@
> > >> >> 
> > >> >>  			status = "disabled";
> > >> >>  		
> > >> >>  		};
> > >> >> 
> > >> >> +		lradc: lradc@1c21800 {
> > >> >> +			compatible = "allwinner,sun4i-a10-lradc-
keys";
> > >> >> +			reg = <0x01c21800 0x100>;
> > >> >> +			interrupts = <GIC_SPI 30 
IRQ_TYPE_LEVEL_HIGH>;
> > >> >> +			status = "disabled";
> > >> >> +		};
> > >> >> +
> > >> >
> > >> >The controller is pretty different on the A64 compared to the A10.
> > >
> > >The
> > >
> > >> >A10 has two channels for example, while the A64 has only one.
> > >> >
> > >> >It looks like the one in the A83t though, so you can use that
> > >> >compatible instead.
> > >> 
> > >> Looking at the patch for the A83t, the only difference is that it
> > >> uses a 3/4 instead of a 2/3 voltage divider, nothing is changed with
> > >> the channels.
> > >
> > >I guess you can reuse the A83t compatible here then, and a more
> > >specific a64 compatible in case we ever need to fix this.
> > >
> > >> But I'm also not sure which one (or a different one)
> > >> is used from looking at the "A64 User Manual".
> > >
> > >I'm sorry, what are you referring to with "one" in that sentence?
> > 
> > Sorry, I meant I didn't find anything in the A64 user manual whether
> > a 3/4 or a 2/3 voltage divider (or one with different values) is
> > used on the A64.
> 
> Ok :)
> 
> I guess you can just reuse the A83t compatible then, together with the
> A64's.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Hi Maxime,
I'd submit a v2 with these changes to v1 then:
                lradc: lradc@1c21800 {
-                       compatible = "allwinner,sun4i-a10-lradc-keys";
-                       reg = <0x01c21800 0x100>;
+                       compatible = "allwinner,sun50i-a64-lradc-keys",
+                                    "allwinner,sun8i-a83t-r-lradc";
+                       reg = <0x01c21800 0x400>;
                        interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
                        status = "disabled";
                };
Does that look okay?
The reg change is due to me not spotting the address being 0x01C2 
1800---0x01C2 1BFF, so the size should be 0x400 and not 0x100.

Thanks for the feedback,
Luca


