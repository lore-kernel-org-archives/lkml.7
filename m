Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17971C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86621479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfEGHGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:06:49 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38203 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEGHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:06:49 -0400
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1420C100012;
        Tue,  7 May 2019 07:06:41 +0000 (UTC)
Date:   Tue, 7 May 2019 09:06:41 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: h6:
 orangepi-one-plus: Add Ethernet support
Message-ID: <20190507070641.7whs4ckiqupaah35@flea>
References: <20190503115928.27662-1-jagan@amarulasolutions.com>
 <20190503144651.ttqfha656dykqjzo@flea>
 <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
 <20190506133101.c3twwwydy5mez3db@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t252ai7obnvmcokm"
Content-Disposition: inline
In-Reply-To: <20190506133101.c3twwwydy5mez3db@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t252ai7obnvmcokm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 03:31:01PM +0200, Ond=C5=99ej Jirman wrote:
> > > > ---
> > > > Changes for v2:
> > > > - emac changes on top of https://patchwork.kernel.org/cover/1089952=
9/
> > > >   series
> > > >
> > > >  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  8 ++++
> > > >  .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 42 +++++++++++++++=
++++
> > > >  2 files changed, 50 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-p=
lus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > > index 12e17567ab56..9e8ed1053715 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > > @@ -9,4 +9,12 @@
> > > >  / {
> > > >       model =3D "OrangePi One Plus";
> > > >       compatible =3D "xunlong,orangepi-one-plus", "allwinner,sun50i=
-h6";
> > > > +
> > > > +     aliases {
> > > > +             ethernet0 =3D &emac;
> > > > +     };
> > > > +};
> > > > +
> > > > +&emac {
> > > > +     status =3D "okay";
> > > >  };
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi =
b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > > index 62e27948a3fa..c48e24acaf8a 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > > @@ -45,6 +45,48 @@
> > > >               regulator-max-microvolt =3D <5000000>;
> > > >               regulator-always-on;
> > > >       };
> > > > +
> > > > +     /*
> > > > +      * The board uses 2.5V RGMII signalling. Power sequence to en=
able
> > > > +      * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power ra=
ils
> > > > +      * at the same time and to wait 100ms.
> > > > +      */
> > > > +     reg_gmac_2v5: gmac-2v5 {
> > > > +             compatible =3D "regulator-fixed";
> > > > +             regulator-name =3D "gmac-2v5";
> > > > +             regulator-min-microvolt =3D <2500000>;
> > > > +             regulator-max-microvolt =3D <2500000>;
> > > > +             startup-delay-us =3D <100000>;
> > > > +             enable-active-high;
> > > > +             gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* GMAC_EN: PD6=
 */
> > > > +
> > > > +             /* The real parent of gmac-2v5 is reg_vcc5v, but we n=
eed to
> > > > +              * enable two regulators to power the phy. This is on=
e way
> > > > +              * to achieve that.
> > > > +              */
> > > > +             vin-supply =3D <&reg_aldo2>; /* VCC3V3-MAC: GMAC-3V */
> > > > +     };
> > > > +};
> > > > +
> > > > +&emac {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&ext_rgmii_pins>;
> > > > +     phy-mode =3D "rgmii";
> > > > +     phy-handle =3D <&ext_rgmii_phy>;
> > > > +     phy-supply =3D <&reg_gmac_2v5>;
> > > > +     allwinner,rx-delay-ps =3D <1500>;
> > > > +     allwinner,tx-delay-ps =3D <700>;
> > > > +};
> > > > +
> > > > +&mdio {
> > > > +     ext_rgmii_phy: ethernet-phy@1 {
> > > > +             compatible =3D "ethernet-phy-ieee802.3-c22";
> > > > +             reg =3D <1>;
> > > > +
> > > > +             reset-gpios =3D <&pio 3 14 GPIO_ACTIVE_LOW>; /* RGMII=
-RESET: PD14 */
> > > > +             reset-assert-us =3D <15000>;
> > > > +             reset-deassert-us =3D <40000>;
> > > > +     };
> > > >  };
> > >
> > > ... however, at no point in time you explain why you made that switch,
> > > and while most of the definition of the EMAC nodes is in the DTSI, you
> > > only enable it in one DTS.
> >
> > The dtsi is shared b/w 1+ and lite2 and 1+ has emac, so I enabled the
> > status directly on dts and keeping the relevant nodes on dtsi just
> > like SoC dtsi does. do I need to mention this in commit log?
>
> Lite 2 doesn't have reg_gmac_2v5 and it also doesn't have the external ph=
y.
> But with this patch, reg_gmac_2v5 will also show up in the Lite 2's final
> DTB.
>
> Comapred to SoC dtsi, the SoC always has things that are in the dtsi, they
> are just not enabled/used by the board, but they are present on the chip.
>
> So this comes down to what the meaning of board-level dtsi should be. I
> doubt we want it to mean "a collection of stuff that may or may not be
> present on the boards that depend on it".

Agreed.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--t252ai7obnvmcokm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNEugQAKCRDj7w1vZxhR
xSqpAP9+c1gUKZN/ouCvKfloPe7AajE+A0yKbWtfWhHElWT14QEAzjJAuWb8Rv+a
FfdAW6X7qq2yr9sNkluAa/DRkDrm+Q8=
=30DV
-----END PGP SIGNATURE-----

--t252ai7obnvmcokm--
