Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A75C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8992077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDKP17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:27:59 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42401 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:27:58 -0400
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5609C100009;
        Thu, 11 Apr 2019 15:27:53 +0000 (UTC)
Date:   Thu, 11 Apr 2019 17:27:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for
 H6
Message-ID: <20190411152752.qlabx7heh74dy2ao@flea>
References: <20190411105720.32357-1-peron.clem@gmail.com>
 <2957024.jOddxINRMN@jernej-laptop>
 <CAJiuCcdo_WAP1_rOcqOcoNkt7rdGb3H_GVMN2DiZnvo_4c=7DA@mail.gmail.com>
 <2797515.ZAugZ1JPiN@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fif5jmfw3lbbiwm7"
Content-Disposition: inline
In-Reply-To: <2797515.ZAugZ1JPiN@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fif5jmfw3lbbiwm7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 05:23:25PM +0200, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 11. april 2019 ob 17:20:04 CEST je Cl=C3=A9ment P=C3=A9=
ron napisal(a):
> > Hi,
> >
> > On Thu, 11 Apr 2019 at 17:05, Jernej =C5=A0krabec <jernej.skrabec@siol.=
net>
> wrote:
> > > Dne =C4=8Detrtek, 11. april 2019 ob 12:57:16 CEST je Cl=C3=A9ment P=
=C3=A9ron napisal(a):
> > > > Add the mali gpu node to the H6 device-tree.
> > > >
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> > > > e0dc4a05c1ba..196753110434 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > @@ -157,6 +157,20 @@
> > > >
> > > >                       allwinner,sram =3D <&ve_sram 1>;
> > > >
> > > >               };
> > > >
> > > > +             gpu: gpu@1800000 {
> > > > +                     compatible =3D "allwinner,sun50i-h6-mali",
> > > > +                                  "arm,mali-t720";
> > > > +                     reg =3D <0x01800000 0x4000>;
> > > > +                     interrupts =3D <GIC_SPI 84
> > >
> > > IRQ_TYPE_LEVEL_HIGH>,
> > >
> > > > +                                  <GIC_SPI 85
> > >
> > > IRQ_TYPE_LEVEL_HIGH>,
> > >
> > > > +                                  <GIC_SPI 83
> > >
> > > IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > > +                     interrupt-names =3D "job", "mmu", "gpu";
> > > > +                     clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> > > > +                     clock-names =3D "core", "bus";
> > > > +                     resets =3D <&ccu RST_BUS_GPU>;
> > > > +                     status =3D "disabled";
> > >
> > > Usually self sufficient peripherals are enabled by default in DTSI.
> >
> > I follow the other Mali Midgard (rk3399, rk3288) syntax.
> > But I think you're right here, will go for an update I think.
>
> I quickly checked A64 and H5 DTSI and both have GPU enabled by default (s=
tatus
> property is not set).

I asked myself the same question, but the H6 seems to have a supply
wired to the GPU, while the H3 and H5 do not. So I'm not sure we want
to enable it on all the boards, even though some might have left out
the GPU supply which will result in a non-working GPU (I assume?)

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fif5jmfw3lbbiwm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK9c+AAKCRDj7w1vZxhR
xbnqAP9Fea7hvFgQtbH751uRaJa3DMnClBVLo69G8zipCrWZ1QD/evi37AfeavWu
FrgvyLIPaSeqbmzh/A9/COc65LFHUQA=
=OM01
-----END PGP SIGNATURE-----

--fif5jmfw3lbbiwm7--
