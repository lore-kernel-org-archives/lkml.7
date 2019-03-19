Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A048C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249F920828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCSMhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:37:10 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57413 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:37:10 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 53663240003;
        Tue, 19 Mar 2019 12:37:03 +0000 (UTC)
Date:   Tue, 19 Mar 2019 13:37:02 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/30] IIO-based thermal sensor driver for Allwinner
 H3 and A83T SoC
Message-ID: <20190319123702.om4uh32noys4nwxv@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <yw1xzhpryrku.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gcgv6druw6g6ewb2"
Content-Disposition: inline
In-Reply-To: <yw1xzhpryrku.fsf@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gcgv6druw6g6ewb2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 12:30:25PM +0000, M=E5ns Rullg=E5rd wrote:
> Philipp Rossak <embed3d@gmail.com> writes:
>
> > Allwiner H3 and A83T SoCs have a thermal sensor, which is a large refac=
tored
> > version of the old Allwinner "GPADC" (although it have already only
> > thermal part left in A33).
> >
> > This patch tried to add support for the sensor in H3 and A83T based on
> >
> > This Patchtseries was in the beginning based on Icenowy Zengs v4 patchs=
eries [1]. Since we decided to merge the mfd driver into the GPADC this cha=
nged. So only one patch could be reused.
> >
> > Patches that adds support for H5, A64, A80 and H6 SoCs are allready pre=
pared,
> > and will be upstreamed if this patchseries is applied and the testing i=
s done.
> >
> > Sorry for delaying this.
> >
> > Regards,
> > Philipp
> >
> > changes since v2:
> > 	* mfd driver is now merged into the gpadc driver
> > 	* complete rework
> >
> > changes since v1:
> > 	* collecting all acks
> > 	* rewording commits/fix typos
> > 	* move code in place where it is used
> > 	* fix naming conventions of defines
> > 	* clarify commits
> > 	* update documentation to cover the new nvmem calibraion
> > 	* change nvmem calibration
> >
> > Icenowy Zheng (1):
> >   iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
> >     A33
> >
> > Philipp Rossak (29):
> >   mfd: Makefile: Remove build option for MFD:sun4i-gpadc
> >   mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
> >   iio: adc: Remove ID table
> >   iio: adc: Kconfig: Update Kconfig to new build options
> >   iio: adc: move SUN4I_GPADC_CHANNEL define to header file
> >   iio: adc: remove ofnode options
> >   iio: adc: remove mfd_probe & sunwi_irq_init function
> >   iio: adc: remove hwmon structure
> >   iio: adc: Threat A33 as thermal sensor and remove non thermal sun4i
> >     channel
> >   iio: adc: rework irq and adc_channel handling
> >   iio: adc: add new compatibles
> >   mfd: Remove old mfd driver & Move sun4i-gpadc.h to iio/adc/
> >   arm: config: Enable SUN4I_GPADC in defconfig
> >   dt-bindings: update the Allwinner GPADC device tree binding for H3 &
> >     A83T
> >   iio: adc: sun4i-gpadc-iio: rework: readout temp_data
> >   iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
> >   iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
> >   iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
> >   iio: adc: sun4i-gpadc-iio: rework: device specific suspend & resume
> >   iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
> >   iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
> >   ARM: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
> >   ARM: dts: sun8i: h3: add support for the thermal sensor in H3
> >   ARM: dts: sun8i: h3: add thermal zone to H3
> >   ARM: dts: sun8i: h3: enable H3 sid controller
> >   ARM: dts: sun8i: h3: use calibration for ths
> >   ARM: dts: sun8i: a83t: add support for the thermal sensor in A83T
> >   ARM: dts: sun8i: a83t: add thermal zone to A83T
> >   ARM: sun8i: a83t: full range OPP tables and CPUfreq
> >
> >  .../devicetree/bindings/iio/adc/sun4i-gpadc.txt    |  41 +-
> >  arch/arm/boot/dts/sun8i-a83t.dtsi                  | 143 +++++
> >  arch/arm/boot/dts/sun8i-h3.dtsi                    |  52 ++
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  10 +
> >  arch/arm/configs/sunxi_defconfig                   |   1 +
> >  drivers/iio/adc/Kconfig                            |  11 +-
> >  drivers/iio/adc/sun4i-gpadc-iio.c                  | 617 +++++++++++++=
--------
> >  drivers/mfd/Kconfig                                |  17 -
> >  drivers/mfd/Makefile                               |   1 -
> >  drivers/mfd/sun4i-gpadc.c                          | 181 ------
> >  include/linux/{mfd =3D> iio/adc}/sun4i-gpadc.h       |  47 +-
> >  11 files changed, 681 insertions(+), 440 deletions(-)
> >  delete mode 100644 drivers/mfd/sun4i-gpadc.c
> >  rename include/linux/{mfd =3D> iio/adc}/sun4i-gpadc.h (72%)
>
> What became of these patches?  I can't seem to find any follow-ups.  Was
> the approach abandoned in favour of something else?

It didn't, I don't think we ever got any follow-up to that series so
that's the main reason it's been held back.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gcgv6druw6g6ewb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJDibgAKCRDj7w1vZxhR
xRFxAP47IAHJtijOx3jGPvMAuz0BDBCkuoVSLPJG66txr9x1aAD49LZbowh5lJEs
1iqVdhU6VYAfwYkwNsuzFySBPfs4CA==
=knWg
-----END PGP SIGNATURE-----

--gcgv6druw6g6ewb2--
