Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F521C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5FE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCKOEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:04:07 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55385 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfCKOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:04:06 -0400
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D4FEF1BF218;
        Mon, 11 Mar 2019 14:04:02 +0000 (UTC)
Date:   Mon, 11 Mar 2019 15:04:02 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v9 3/5] drm/sun4i: sun6i_mipi_dsi: Support vblk timing
 for 4-lane devices
Message-ID: <20190311140402.ie7abxda6pizrybj@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-4-jagan@amarulasolutions.com>
 <20190304154911.s6rcx6bzal5slcjk@flea>
 <CAMty3ZBVh_PTYB-HmLCUuRsH+4NU=CaeXdKtNYqEDHHZuRGCvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mqq4mfoclpdqed4k"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBVh_PTYB-HmLCUuRsH+4NU=CaeXdKtNYqEDHHZuRGCvw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mqq4mfoclpdqed4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 09:33:38PM +0530, Jagan Teki wrote:
> On Mon, Mar 4, 2019 at 9:19 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sun, Mar 03, 2019 at 11:05:25PM +0530, Jagan Teki wrote:
> > > Like other dsi setup timings, or hblk for that matter vblk would
> > > also require compute the timings based payload equation along with
> > > packet overhead.
> > >
> > > But, on the other hand vblk computation is also depends on device
> > > lane number.
> > > - for 4 lane devices, it is computed based on vtotal, packet overhead
> > >   along with hblk value.
> > > - for others devices, it is simply 0
> > >
> > > BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
> > > (from linux-sunxi
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > tmp =3D (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
> > > dsi_vblk =3D (lane-tmp%lane);
> > >
> > > So, update the vblk timing calculation to support all type of
> > > devices.
> > >
> > > Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
> >
> > You should be explaining which issue you faced, in which setup, what
> > were its symptoms and how that solution is fixing it.
>=20
> No, it is not a fix, didn't specify either. it is vblk timings support
> like others dsi timings.

So it's not fixing anything, and this isn't a new feature
either. What's the point then?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mqq4mfoclpdqed4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIZqzQAKCRDj7w1vZxhR
xUl8AQDzpIsbwiyzkZ+aez3Ix0wICtijzP4KTpfNcIYEUUirFwEArgbMtnpsg02j
EKB2JBz7nYOOkaycbCvOS/Je1lNDPw0=
=rN6W
-----END PGP SIGNATURE-----

--mqq4mfoclpdqed4k--
