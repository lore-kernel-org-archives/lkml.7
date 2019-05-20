Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13BC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAC5206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfETHYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:24:55 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35407 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfETHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:24:54 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 846DB1BF218;
        Mon, 20 May 2019 07:24:48 +0000 (UTC)
Date:   Mon, 20 May 2019 09:24:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Message-ID: <20190520072447.snt4phx57b5rfjv4@flea>
References: <20190516161039.18534-1-jernej.skrabec@siol.net>
 <20190517073048.y6mzgbhhryfmuckl@flea>
 <36237813.UWQAqNRFN9@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctmlzvhrt42rr7y5"
Content-Disposition: inline
In-Reply-To: <36237813.UWQAqNRFN9@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctmlzvhrt42rr7y5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2019 at 05:07:11PM +0200, Jernej =C5=A0krabec wrote:
> Dne petek, 17. maj 2019 ob 09:30:48 CEST je Maxime Ripard napisal(a):
> > Hi,
> >
> > On Thu, May 16, 2019 at 06:10:39PM +0200, Jernej Skrabec wrote:
> > > mmc1 node where wifi module is connected doesn't have properly defined
> > > power supplies so wifi module is never powered up. Fix that by
> > > specifying additional power supplies.
> > >
> > > Additionally, this STB may have either Realtek or Broadcom based wifi
> > > module. One based on Broadcom module also needs external clock to work
> > > properly. Fix that by adding clock property to wifi_pwrseq node.
> > >
> > > Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 =
STB")
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts index
> > > 6277f13f3eb3..6a0ac85b4616 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > @@ -89,7 +89,10 @@
> > >
> > >  	wifi_pwrseq: wifi_pwrseq {
> > >
> > >  		compatible =3D "mmc-pwrseq-simple";
> > >
> > > +		pinctrl-names =3D "default";
> >
> > pinctrl-names only make sense with another pinctrl-[0-255]
> > property. Did you forgot something here?
>
> No, I just took BananaPi M2+ as a example, which has pinctrl-names proper=
ty
> too and no "pinctrl-*". But digging through history of this DT, it seems =
that
> this is just leftover which somebody forgot to remove.
>
> I'll send v2.

This should be fixed in 5.2 thanks to the commit 75f9a058838b

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ctmlzvhrt42rr7y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOJWPwAKCRDj7w1vZxhR
xYE+AP9QhFtjiygFXgICwzp6Lq1kpc5kHMNcjkJ+93Xus3Y9QwD+Kfwc+m/R0CkH
brzk6h/WxMESpp9HioHOUA0ql3LAWAk=
=go8o
-----END PGP SIGNATURE-----

--ctmlzvhrt42rr7y5--
