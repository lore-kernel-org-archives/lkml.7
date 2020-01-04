Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60039C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B624649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578132268;
	bh=8ORiMUsf8HPUPHXHjmv0CeVHaE2c1S3iTzR4ERsLPJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yKvurfXl04glU68Yw1gqOWzLAQRQptZZKiOMvLGkF8MDIrLRRjjsZzvCyrdhCOg2s
	 XOo6luR10lzNZ3JhwROWlJ4Pb8U5wkfW4p1ZtQGOKg/l6Uqk3foR7Dv5jPJTUhKXMG
	 loiW5aYBw/Cpxc3UY+pxbf+3nLyqPtAqh/55Z1lQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgADKE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgADKE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 05:04:26 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA819217F4;
        Sat,  4 Jan 2020 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578132265;
        bh=8ORiMUsf8HPUPHXHjmv0CeVHaE2c1S3iTzR4ERsLPJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKxTnbXLBiTiMylifCY51BpPtkg0N21NxA0RMjtm+SrmWmtuoXEedHVmB4dMoTmeW
         qqAFFo/QEqrfFRrQn/BJVAj9zMWsq0JDDU3HDX6UNi4V24ZwgvRGkFzQYzNaxqJNrE
         LTIQybaIgnPB1jNcSb9idB+1o22OYr47hSRVPW4o=
Date:   Sat, 4 Jan 2020 11:04:22 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200104100422.z7iz4jiyj7kdvbtw@gilmour.lan>
References: <20200102012657.9278-1-andre.przywara@arm.com>
 <20200102012657.9278-4-andre.przywara@arm.com>
 <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan>
 <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z45qt7a72x26lxtu"
Content-Disposition: inline
In-Reply-To: <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z45qt7a72x26lxtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2020 at 10:41:58AM +0000, Andre Przywara wrote:
> On Thu, 2 Jan 2020 10:57:11 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
> > On Thu, Jan 02, 2020 at 01:26:57AM +0000, Andre Przywara wrote:
> > > The Allwinner R40 SoC contains four SPI controllers, using the newer
> > > sun6i design (but at the legacy addresses).
> > > The controller seems to be fully compatible to the A64 one, so no driver
> > > changes are necessary.
> > > The first three controller can be used on two sets of pins, but SPI3 is
> > > only routed to one set on Port A.
> > >
> > > Tested by connecting a SPI flash to a Bananapi M2 Berry on the SPI0
> > > PortC header pins.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > index 8dcbc4465fbb..af437391dcf4 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -418,6 +418,41 @@
> > >  				bias-pull-up;
> > >  			};
> > >
> > > +			spi0_pc_pins: spi0-pc-pins {
> > > +				pins = "PC0", "PC1", "PC2", "PC23";
> > > +				function = "spi0";
> > > +			};
> > > +
> > > +			spi0_pi_pins: spi0-pi-pins {
> > > +				pins = "PI10", "PI11", "PI12", "PI13", "PI14";
> > > +				function = "spi0";
> > > +			};
> >
> > This split doesn't really work though :/
> >
> > The PC pins group has MOSI, MISO, CLK and CS0, while the PI pins group
> > has CS0, CLK, MOSI, MISO and CS1.
> >
> > Meaning that if a board uses a GPIO CS pin, we can't really express
> > that
>
> Does that actually work? I dimly remember checking our sunxi driver
> a while ago and I wasn't sure that would be functional there.

It's something generic that should be handled by the core iirc. We
might be missing the few things to enable it though, but that's
irrelevant to the DT itself.

> > and any board using the PI pins for its SPI bus will try to
> > claim CS0 and CS1, no matter how many devices are connected on the bus
> > (and if there's one, there might be something else connected to PI14).
>
> True.
>
> > And you can't have a board using CS1 with the PC signals either.
> >
> > You should split away the CS pins into separate groups, like we're
> > doing with the A20 for example.
>
> Ah, yeah, makes sense, thanks for the pointer.
>
> > And please add /omit-if-no-ref/ to those groups.
>
> I was a bit reluctant to do this:
>
> First there does not seem to be any good documentation about it,
> neither in the official DT spec nor in dtc, even though I think I
> understand what it does ;-)

If a node doesn't have a phandle pointing to it, it will be ignored at
compilation time.

> Second it seems to break in U-Boot atm. Looks like applying your dtc
> patch fixes that, though. Do you know if U-Boot allows
> cherry-picking dtc patches? If yes, I could post your patch.

I know I did it for libfdt at some point, so I guess dtc would work
too, but I'm not really sure. Rockchip is also using it iirc, so
there's interest in supporting it in U-Boot anyway.

> But more importantly: what are the guidelines for using this tag? I
> understand the desire to provide every possible pin description on
> one hand, but wanting to avoid having *all of them* in *each* .dtb
> on the other.

Pin groups will take a lot of space in the dtb, and the DT parsing
will take some measurable time, so if we can get rid of the unused pin
groups, that's great :)

> But how does this play along with overlays? Shouldn't at least those
> interface pins that are exposed on headers stay in each .dtb? Can we
> actually make this decision in the SoC .dtsi file?

If the DT is compiled with overlays, that property is ignored iirc and
the node will be output in the compiled DT, because while if you don't
have overlays support you can tell if something points to that node,
you can't with overlays since those references might be stored
elsewhere.

> And should there be a dtc command line option to ignore those tags,
> or even to apply this tag (virtually) to every node?

Most of the nodes are (reference) leaves in a DT though. Pretty much
all the device nodes have no references pointing to them, just like
most of the buses, the CPU nodes, etc. And I'm pretty sure you want to
keep them :)

Maxime

--z45qt7a72x26lxtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhBjJgAKCRDj7w1vZxhR
xU72AP4xtkPQVt9OS3WVfWffyz44w6FE8OJCvqGcr003sRMimgEA8HlBp4HPgl+N
Q5GJcJWtJxT0rqcXFOOm+3WY0bDe7AE=
=AltN
-----END PGP SIGNATURE-----

--z45qt7a72x26lxtu--
