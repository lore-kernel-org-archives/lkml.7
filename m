Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830592168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403787AbfEXNGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:06:33 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34061 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391193AbfEXNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:06:32 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C20A420000F;
        Fri, 24 May 2019 13:06:23 +0000 (UTC)
Date:   Fri, 24 May 2019 15:06:23 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a64: enable ANX6345 bridge on
 Teres-I
Message-ID: <20190524130623.dpkg5z5rdyc2bno4@flea>
References: <20190523065013.2719D68B05@newverein.lst.de>
 <20190523065404.BB60F68B20@newverein.lst.de>
 <CA+E=qVdh-=C5zOYWYj95jLN51EaXFS6B+CQ101-f64q5QmgN3g@mail.gmail.com>
 <20190524121359.GE15685@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fsxi6i2r62yvgbvk"
Content-Disposition: inline
In-Reply-To: <20190524121359.GE15685@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fsxi6i2r62yvgbvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2019 at 02:13:59PM +0200, Torsten Duwe wrote:
> On Thu, May 23, 2019 at 07:48:03AM -0700, Vasily Khoruzhick wrote:
> > On Wed, May 22, 2019 at 11:54 PM Torsten Duwe <duwe@lst.de> wrote:
> > >
> > >
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > @@ -65,6 +65,21 @@
> > >                 };
> > >         };
> > >
> > > +       panel: panel {
> > > +               compatible ="innolux,n116bge", "simple-panel";
> >
> > IIRC Rob wanted it to be edp-connector, not simple-panel. Also you
> > need to introduce edp-connector binding.
>
> This line is identically found in
> arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi and
> arch/arm64/boot/dts/nvidia/tegra132-norrin.dts

That's not really an argument though. These are using rather old
bindings, and realising that they are flawed and fixing these flaws is
a natural process.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fsxi6i2r62yvgbvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOfsTwAKCRDj7w1vZxhR
xRybAP9iKNkCqyhXQ6xIsRZgZ0sNXT+q0aHuuuRwgIKZaEJwkwEAqakTF1EIu2Pr
7DcRHe8aaX/5zfuRYUOdKKZ/wNaOdQ0=
=Mlxd
-----END PGP SIGNATURE-----

--fsxi6i2r62yvgbvk--
