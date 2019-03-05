Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FF420684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfCEP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:59:28 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43027 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfCEP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:59:28 -0500
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4185360013;
        Tue,  5 Mar 2019 15:59:20 +0000 (UTC)
Date:   Tue, 5 Mar 2019 16:59:19 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD
 initial support
Message-ID: <20190305155919.cm3yrve3vqp7jimh@flea>
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com>
 <20190227153346.dwd3stsbsvf7rwly@flea>
 <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com>
 <20190301145724.vhvyoqkkxdflg2g7@flea>
 <CAMty3ZCUSsN71Q5h_nj6de0Smhqht1S5zq0pLKUqpwq=85XqXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iy7ufcb2rlgsdx6i"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCUSsN71Q5h_nj6de0Smhqht1S5zq0pLKUqpwq=85XqXw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iy7ufcb2rlgsdx6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 10:27:14PM +0530, Jagan Teki wrote:
> On Fri, Mar 1, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Wed, Feb 27, 2019 at 09:49:23PM +0530, Jagan Teki wrote:
> > > On Wed, Feb 27, 2019 at 9:03 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Feb 26, 2019 at 11:32:40AM +0530, Jagan Teki wrote:
> > > > > Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
> > > > > designed to mount SoPine SOM.
> > > > >
> > > > > Key features:
> > > > > - Allwinner A64 Cortex-A53
> > > > > - Mali-400MP2 GPU
> > > > > - AXP803 PMIC
> > > > > - 2GB DDR3 RAM
> > > > > - SD Slot
> > > > > - SPI-NOR flash
> > > > > - EMAC, RTL8211E
> > > > > - MCP2515 CAN
> > > > > - MIPI-DSI
> > > > > - Goodix 911 CTP
> > > > > - USB Host
> > > > > - 12V DC power supply
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > > > >  .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++=
++++++
> > > > >  2 files changed, 47 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-ocea=
nic-5inmfd.dts
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/=
boot/dts/allwinner/Makefile
> > > > > index a5fb1eaa8acf..ec39fe856117 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > > > @@ -2,6 +2,7 @@
> > > > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-amarula-relic.dtb
> > > > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-bananapi-m64.dtb sun50i=
-a64-bananapi-m64-icn6211.dtb
> > > > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-nanopi-a64.dtb
> > > > > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-oceanic-5inmfd.dtb
> > > > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-olinuxino.dtb
> > > > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-orangepi-win.dtb
> > > > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pine64-lts.dtb
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5in=
mfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > > new file mode 100644
> > > > > index 000000000000..d73d1f55acb9
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > > @@ -0,0 +1,46 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +/*
> > > > > + * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
> > > > > + * Copyright (C) 2019 Amarula Solutions B.V.
> > > > > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > > > > + */
> > > > > +
> > > > > +/dts-v1/;
> > > > > +
> > > > > +#include "sun50i-a64-sopine.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +     model =3D "Oceanic A64-5inMFD";
> > > > > +     compatible =3D "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
> > > >
> > > > The name of the DT is Oceanic 5inMFD, while you call the board
> > > > A64-5inMFD here, which name is the actual name?
> > >
> > > Yes, this is something that we discussed during "Amarula A64-Relic"
> > > naming convention.
> > >
> > > Since these boards are not famous like teres-i we agreed to add vendor
> > > name after sun50i-a64- followed by real board name.
> > >
> > > Here A64 already covered during sun50i-a64- so the dts name simply the
> > > <vendor_name>-<real_board_name>
> >
> > For the DT name, yeah, we want that pattern.
> >
> > For the compatible and model, we want to use the model name.
>=20
> Entire model name after <vendor_name>, ?
>=20
> model =3D "Oceanic A64-5inMFD";
> compatible =3D "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
>=20
> is this not sufficient?
>=20
> Let me understand with respective few existing stuff.
>=20
> model =3D "Amarula A64-Relic";
> compatible =3D "amarula,a64-relic", "allwinner,sun50i-a64";
>=20
> model =3D "Olimex A64 Teres-I"
> compatible =3D "olimex,a64-teres-i", "allwinner,sun50i-a64";

This one is called the TERES-A64:
https://www.olimex.com/Products/DIY-Laptop/KITS/TERES-A64-WHITE/open-source=
-hardware

The laptop is the Teres-I, it can have an A64

> model =3D "FriendlyARM NanoPi A64";
> compatible =3D "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";

NanoPi A64 is the name of the board: http://nanopi.io/nanopi-a64.html

> model =3D "Olimex A64-Olinuxino";
> compatible =3D "olimex,a64-olinuxino", "allwinner,sun50i-a64"

A64-Olinuxino is the name of the board too:
https://www.olimex.com/Products/OLinuXino/A64/A64-OLinuXino/open-source-har=
dware

> Would you comment, what is the different with respect to my change?

If the name of the product is 5inMFD, then the model should be Oceanic
5inMFD, and its compatible oceanic,5inmfd

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iy7ufcb2rlgsdx6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH6c1wAKCRDj7w1vZxhR
xROYAQC8deU5A9vhREAQQrK6Q7EOCuKH8mkLTmcsFAk0ZXrG7gEA8fUEhN3hVdvx
tEyVxtyE6hiw+XrLTXBDiyaxBl7aPgk=
=tDgf
-----END PGP SIGNATURE-----

--iy7ufcb2rlgsdx6i--
