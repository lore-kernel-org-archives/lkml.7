Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AECC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A5020657
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfFEMCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:02:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51057 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:02:50 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3E9841C0014;
        Wed,  5 Jun 2019 12:02:38 +0000 (UTC)
Date:   Wed, 5 Jun 2019 14:02:37 +0200
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
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190605120237.ekmytfxcwbjaqy3x@flea>
References: <20190604122150.29D6468B05@newverein.lst.de>
 <20190604122308.98D4868B20@newverein.lst.de>
 <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
 <20190605101317.GA9345@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qiya5ip3hgidvmzq"
Content-Disposition: inline
In-Reply-To: <20190605101317.GA9345@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qiya5ip3hgidvmzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2019 at 12:13:17PM +0200, Torsten Duwe wrote:
> On Tue, Jun 04, 2019 at 08:08:40AM -0700, Vasily Khoruzhick wrote:
> > On Tue, Jun 4, 2019 at 5:23 AM Torsten Duwe <duwe@lst.de> wrote:
> > >
> > > Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
> > > the I2C controlling signals are connected to I2C0 bus. eDP output goes
> > > to an Innolux N116BGE panel.
> > >
> > > Enable it in the device tree.
> > >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > ---
> > >  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 65 ++++++++++++++++++++--
> > >  1 file changed, 61 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > index 0ec46b969a75..a0ad438b037f 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > @@ -65,6 +65,21 @@
> > >                 };
> > >         };
> > >
> > > +       panel: panel {
> > > +               compatible ="innolux,n116bge", "simple-panel";
> >
> > It's still "simple-panel". I believe I already mentioned that Rob
> > asked it to be edp-connector.
>
> For which there are neither bindings nor drivers.
>
> Is anybody seriously proposing to hold back support for existing
> (open source!) hardware in favour of an *imaginable* *possibly*
> better solution? Especially when this exact line is already used in
> some other places?  (there's a space missing btw...)

It's non-existent and imaginable only because you've been ignoring
everyone that said that you should do it. So it's self-inflicted,
really.

And the DT is considered an ABI, so yeah, we will witheld everything
that doesn't fit what we would like. Your point of view is that it's
more work and for no particular benefit, ours is that it's a
short-term pain for a long-term gain, and the benefits will be in the
maintainance cost.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qiya5ip3hgidvmzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPevXQAKCRDj7w1vZxhR
xRaUAP4rsNSfzJsmzwtJIlX1UQvArevsqZjEbly5zQoUU26FyAEAsSQVhJt3Xdhr
y/w4nPyt47sTpjL2pjXHbkTaW+M7hw0=
=y5GR
-----END PGP SIGNATURE-----

--qiya5ip3hgidvmzq--
