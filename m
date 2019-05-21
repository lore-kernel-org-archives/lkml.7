Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B49C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A5020856
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfEUNKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:10:00 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56543 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEUNJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:09:59 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2E4871C000A;
        Tue, 21 May 2019 13:09:55 +0000 (UTC)
Date:   Tue, 21 May 2019 15:09:55 +0200
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
Message-ID: <20190521130955.3omqwpx3i7njsb3t@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz>
 <20190520110742.ykgxwaabzzwovgpl@flea>
 <9B2B83DF-2C91-4DDA-B707-664A792A8BCF@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o4dueejzfmmapbjw"
Content-Disposition: inline
In-Reply-To: <9B2B83DF-2C91-4DDA-B707-664A792A8BCF@z3ntu.xyz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4dueejzfmmapbjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 08:43:45AM +0200, luca@z3ntu.xyz wrote:
> On May 20, 2019 1:07:42 PM GMT+02:00, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >On Sat, May 18, 2019 at 07:09:30PM +0200, Luca Weiss wrote:
> >> Add a node describing the KEYADC on the A64.
> >>
> >> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index 7734f70e1057..dc1bf8c1afb5 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -704,6 +704,13 @@
> >>  			status = "disabled";
> >>  		};
> >>
> >> +		lradc: lradc@1c21800 {
> >> +			compatible = "allwinner,sun4i-a10-lradc-keys";
> >> +			reg = <0x01c21800 0x100>;
> >> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> >> +			status = "disabled";
> >> +		};
> >> +
> >
> >The controller is pretty different on the A64 compared to the A10. The
> >A10 has two channels for example, while the A64 has only one.
> >
> >It looks like the one in the A83t though, so you can use that
> >compatible instead.
>
> Looking at the patch for the A83t, the only difference is that it
> uses a 3/4 instead of a 2/3 voltage divider, nothing is changed with
> the channels.

I guess you can reuse the A83t compatible here then, and a more
specific a64 compatible in case we ever need to fix this.

> But I'm also not sure which one (or a different one)
> is used from looking at the "A64 User Manual".

I'm sorry, what are you referring to with "one" in that sentence?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o4dueejzfmmapbjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOP4owAKCRDj7w1vZxhR
xZkvAQCd5wzD/xjw3laO9nxjD2QxKl1qIHQW5BZeiCHbM1DA5wD/VtDKwN19wKfS
efcYJj1jUOQM495DpaIysQG3XvYg3AA=
=08Dd
-----END PGP SIGNATURE-----

--o4dueejzfmmapbjw--
