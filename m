Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881C721773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfEUOZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:25:51 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38571 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfEUOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:25:50 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6AEC61BF207;
        Tue, 21 May 2019 14:25:45 +0000 (UTC)
Date:   Tue, 21 May 2019 16:25:44 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     luca@z3ntu.xyz
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Message-ID: <20190521142544.ma2xfu77bamk4hvc@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz>
 <20190520110742.ykgxwaabzzwovgpl@flea>
 <9B2B83DF-2C91-4DDA-B707-664A792A8BCF@z3ntu.xyz>
 <20190521130955.3omqwpx3i7njsb3t@flea>
 <EF411F71-D257-41FC-9248-B0E3F686B6B9@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eeqdxbq7qtv325ow"
Content-Disposition: inline
In-Reply-To: <EF411F71-D257-41FC-9248-B0E3F686B6B9@z3ntu.xyz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eeqdxbq7qtv325ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 03:52:47PM +0200, luca@z3ntu.xyz wrote:
> On May 21, 2019 3:09:55 PM GMT+02:00, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >On Tue, May 21, 2019 at 08:43:45AM +0200, luca@z3ntu.xyz wrote:
> >> On May 20, 2019 1:07:42 PM GMT+02:00, Maxime Ripard
> ><maxime.ripard@bootlin.com> wrote:
> >> >On Sat, May 18, 2019 at 07:09:30PM +0200, Luca Weiss wrote:
> >> >> Add a node describing the KEYADC on the A64.
> >> >>
> >> >> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >> >> ---
> >> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 +++++++
> >> >>  1 file changed, 7 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> >> index 7734f70e1057..dc1bf8c1afb5 100644
> >> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> >> @@ -704,6 +704,13 @@
> >> >>  			status = "disabled";
> >> >>  		};
> >> >>
> >> >> +		lradc: lradc@1c21800 {
> >> >> +			compatible = "allwinner,sun4i-a10-lradc-keys";
> >> >> +			reg = <0x01c21800 0x100>;
> >> >> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> >> >> +			status = "disabled";
> >> >> +		};
> >> >> +
> >> >
> >> >The controller is pretty different on the A64 compared to the A10.
> >The
> >> >A10 has two channels for example, while the A64 has only one.
> >> >
> >> >It looks like the one in the A83t though, so you can use that
> >> >compatible instead.
> >>
> >> Looking at the patch for the A83t, the only difference is that it
> >> uses a 3/4 instead of a 2/3 voltage divider, nothing is changed with
> >> the channels.
> >
> >I guess you can reuse the A83t compatible here then, and a more
> >specific a64 compatible in case we ever need to fix this.
> >
> >> But I'm also not sure which one (or a different one)
> >> is used from looking at the "A64 User Manual".
> >
> >I'm sorry, what are you referring to with "one" in that sentence?
>
> Sorry, I meant I didn't find anything in the A64 user manual whether
> a 3/4 or a 2/3 voltage divider (or one with different values) is
> used on the A64.

Ok :)

I guess you can just reuse the A83t compatible then, together with the
A64's.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--eeqdxbq7qtv325ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOQKZAAKCRDj7w1vZxhR
xYxPAP0RFrmcAu/HPaXx9NqfF09TS+z60yL3d1lDXfuclCegcgD+NfHTU6LGqLtM
AhoJHl0w0tcNUUIyMxL3GKzynwT7bgY=
=OQh4
-----END PGP SIGNATURE-----

--eeqdxbq7qtv325ow--
