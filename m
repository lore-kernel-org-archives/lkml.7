Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC953C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A09217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDKJMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:12:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58819 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:12:46 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 207DC60010;
        Thu, 11 Apr 2019 09:12:40 +0000 (UTC)
Date:   Thu, 11 Apr 2019 11:12:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Message-ID: <20190411091240.qzi7266rzhksbxxa@flea>
References: <20190410232543.13297-1-peron.clem@gmail.com>
 <20190410232543.13297-5-peron.clem@gmail.com>
 <20190411072806.yr3z3ei6djjhpo32@flea>
 <CAJiuCcfGO2+rx=91osok3nnqTWBddMVc_1RS3rh0TbVz4ALvrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wt4dw26h24e24tyj"
Content-Disposition: inline
In-Reply-To: <CAJiuCcfGO2+rx=91osok3nnqTWBddMVc_1RS3rh0TbVz4ALvrg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wt4dw26h24e24tyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 09:56:15AM +0200, Cl=E9ment P=E9ron wrote:
> Hi,
>
> On Thu, 11 Apr 2019 at 09:28, Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
> >
> > On Thu, Apr 11, 2019 at 01:25:39AM +0200, Cl=E9ment P=E9ron wrote:
> > > Add the mali gpu node to the H6 device-tree.
> > >
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++=
++
> > >  1 file changed, 80 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h6.dtsi
> > > index e0dc4a05c1ba..152b2128aadf 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -17,6 +17,71 @@
> > >       #address-cells =3D <1>;
> > >       #size-cells =3D <1>;
> > >
> > > +     gpu_opp_table: opp_table1 {
> > > +             compatible =3D "operating-points-v2";
> > > +
> > > +             opp@756000000 {
> > > +                     opp-hz =3D /bits/ 64 <756000000>;
> > > +                     opp-microvolt =3D <1040000>;
> > > +             };
> > > +             opp@624000000 {
> > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > +                     opp-microvolt =3D <950000>;
> > > +             };
> > > +             opp@576000000 {
> > > +                     opp-hz =3D /bits/ 64 <576000000>;
> > > +                     opp-microvolt =3D <930000>;
> > > +             };
> > > +             opp@540000000 {
> > > +                     opp-hz =3D /bits/ 64 <540000000>;
> > > +                     opp-microvolt =3D <910000>;
> > > +             };
> > > +             opp@504000000 {
> > > +                     opp-hz =3D /bits/ 64 <504000000>;
> > > +                     opp-microvolt =3D <890000>;
> > > +             };
> > > +             opp@456000000 {
> > > +                     opp-hz =3D /bits/ 64 <456000000>;
> > > +                     opp-microvolt =3D <870000>;
> > > +             };
> > > +             opp@432000000 {
> > > +                     opp-hz =3D /bits/ 64 <432000000>;
> > > +                     opp-microvolt =3D <860000>;
> > > +             };
> > > +             opp@420000000 {
> > > +                     opp-hz =3D /bits/ 64 <420000000>;
> > > +                     opp-microvolt =3D <850000>;
> > > +             };
> > > +             opp@408000000 {
> > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > +                     opp-microvolt =3D <840000>;
> > > +             };
> > > +             opp@384000000 {
> > > +                     opp-hz =3D /bits/ 64 <384000000>;
> > > +                     opp-microvolt =3D <830000>;
> > > +             };
> > > +             opp@360000000 {
> > > +                     opp-hz =3D /bits/ 64 <360000000>;
> > > +                     opp-microvolt =3D <820000>;
> > > +             };
> > > +             opp@336000000 {
> > > +                     opp-hz =3D /bits/ 64 <336000000>;
> > > +                     opp-microvolt =3D <810000>;
> > > +             };
> > > +             opp@312000000 {
> > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > +                     opp-microvolt =3D <810000>;
> > > +             };
> > > +             opp@264000000 {
> > > +                     opp-hz =3D /bits/ 64 <264000000>;
> > > +                     opp-microvolt =3D <810000>;
> > > +             };
> > > +             opp@216000000 {
> > > +                     opp-hz =3D /bits/ 64 <216000000>;
> > > +                     opp-microvolt =3D <810000>;
> > > +             };
> > > +     };
> > > +
> >
> > How were those OPPs tested?
>
> They are taken from the vendor device tree.
> https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm6=
4/boot/dts/sunxi/sun50iw6p1.dtsi#L2121

Please remove them if you haven't tested them then.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wt4dw26h24e24tyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK8FCAAKCRDj7w1vZxhR
xTKWAQCkcHeJX2zsAy0gS4+huXZb+yrk24lKRns1Ip4dRUB8QgD/Q6ImVqglfwyb
izJof9k7hFc2NMkMbgoiFC/503I0DAs=
=rMsx
-----END PGP SIGNATURE-----

--wt4dw26h24e24tyj--
