Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA4C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2C421741
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfCKPix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:38:53 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40993 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:38:52 -0400
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5EA28FF80A;
        Mon, 11 Mar 2019 15:38:48 +0000 (UTC)
Date:   Mon, 11 Mar 2019 16:38:47 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v8 02/15] drm/sun4i: tcon: Compute DCLK dividers based on
 format, lanes
Message-ID: <20190311153847.oz6ruqmptaq2befn@flea>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="unl66vzthkbzxsc5"
Content-Disposition: inline
In-Reply-To: <20190311133637.18334-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unl66vzthkbzxsc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
> pll-video =3D> pll-mipi =3D> tcon0 =3D> tcon0-pixel-clock is the typical
> MIPI clock topology in Allwinner DSI controller.
>=20
> TCON dotclock driver is computing the desired DCLK divider based on
> panel pixel clock along with input DCLK min, max divider values from
> tcon driver and that would eventually set the pll-mipi clock rate.
>=20
> The current code allows the TCON clock divider to have a default 4
> for min, max ranges that would fail to compute the desired pll-mipi
> rate while supporting new panels.
>=20
> So, add the computation logic 'format/lanes' to dclk min and max dividers
> and instead of default 4. This computation logic align with Allwinner A64
> BSP, hoping that would work even for A33.

Last time we discussed this, we found out that this wasn't the case,
even in the BSP.

What compelling evidence have you found that makes you say otherwise?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--unl66vzthkbzxsc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIaBBwAKCRDj7w1vZxhR
xQmDAP0fEPwWNXxHnuOzc2Hp56CvHmpJBy1gADfKKVXjLURIdwD+Mwmlmq8ey7vM
b5JlVu2kucnFP5+EM9iGeaCILBsREw0=
=4Bo1
-----END PGP SIGNATURE-----

--unl66vzthkbzxsc5--
