Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07157217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DmdfFs6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJGFsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:48:33 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:37016 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGFsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bdmc7qlre0F9bijOKxKuJpK+kMSATS4KheYRbfPzDyc=; b=DmdfFs6LU4Zux5OdUIPjlANlw
        PdSaaPJa2dkoZ3b2e8hLK7opFIxhWMWGYOjvAz3UGZSzbDHFElFQBhjjmEDg03gOiJ366O6vRYmnc
        R1PeIa2DIz1lbvCILj43pBonyNX3ArRmkC11QBVR0UZIA3UDkiyQIClnN+kHTupI6dicE=;
Received: from [77.247.85.102] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iHLsc-0000Jc-T5; Mon, 07 Oct 2019 07:48:23 +0200
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iHLsa-0008CK-P4; Mon, 07 Oct 2019 07:48:20 +0200
Date:   Mon, 7 Oct 2019 07:48:13 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191007074813.235869db@kemnade.info>
In-Reply-To: <20191006223848.GE19803@latitude>
References: <20190930194332.12246-1-andreas@kemnade.info>
        <20190930194332.12246-3-andreas@kemnade.info>
        <20191006223848.GE19803@latitude>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aB.pTc2IuOjACzyPfRof4hD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aB.pTc2IuOjACzyPfRof4hD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 7 Oct 2019 00:38:48 +0200
Jonathan Neusch=E4fer <j.neuschaefer@gmx.net> wrote:

> Thanks for CCing me on this patchset. Nice to see more e-book reader
> related work!
>=20
> A few comments and questions below.
>=20
> On Mon, Sep 30, 2019 at 09:43:31PM +0200, Andreas Kemnade wrote:
> > The Netronix board E60K02 can be found some several Ebook-Readers,
> > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > is equipped with different SoCs requiring different pinmuxes. =20
>=20
> Do I understand it correctly that i.MX6SL and i.MX6SLL are pin-
> compatible so we can use the same pin numbers and GPIO handles in the
> DT?
>=20
Yes, for that purpose yes, The i.MX6SL has more functions than the i.MX6SLL,
which you will of course not find on the SLL pins.

> > +	leds {
> > +		compatible =3D "gpio-leds";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_led>;
> > +
> > +		GLED { =20
>=20
> What does "GLED" mean? It's not obvious to me.
> What user-visible purpose does this LED have, or where is it on the
> board?
>=20
It is on the power key. So probably we could have "power" in its name.
GLED is just the name in vendors uboot and kernel.

I use that led also as an output in uboot to have multiboot between
vendor system, vendor kernel +debian system and patched mainline + debian s=
ystem.

> > +			gpios =3D <&gpio5 7 GPIO_ACTIVE_LOW>;
> > +			linux,default-trigger =3D "timer";
> > +		};
> > +	};
> > +
> > +	memory {
> > +		reg =3D <0x80000000 0x80000000>; =20
>=20
> 2 GiB of memory?
>=20
Well, 512MByte. Seems that uboot overwrites that. But we should use the cor=
rect
value here.

> > +			/* Core3_3V3 */ =20
>=20
> What are these labels (Core3_3V3, Core4_1V2, etc.)?
>
I have taken then from the tolino board file. Probably they are netnames
of the pcb but not the names of the regulators in the pmic.
=20
> > +			dcdc2_reg: DCDC2 {
> > +				regulator-name =3D "DCDC2";
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-max-microvolt =3D <3300000>;
> > +					regulator-suspend-min-microvolt =3D <3300000>;
> > +				};
> > +			}; =20
>=20
Regards,
Andreas

--Sig_/aB.pTc2IuOjACzyPfRof4hD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl2a0Z0ACgkQl4jFM1s/
ye9dKA//aQgaIGzJry4yT7el+FH8/B/V78b24pRmCx3wnBuRsc9CBxYsAEpYGJTo
iBXpJUHUpy3J28ZQxSjk6docvx918lE0R1l9VQlqzP3mw1uFGQmtIYG7W6kbZkom
dXSb9g/Tql+r7zTuEKodK99mz4xPupf3Ay36sLecNKddfGTgXQy96blU3x+Degrb
MMIKEKZFi+E5e3Q+FLkwNhRMVbAbpVVtqQrmZqN5ImbhD72pFKgbQt+CIPAQZYp7
b+0CdDnnvHOMvh6QT+Ij4Od3NGfGhqa/+qHqSmztx6X3XZFK57z5RKe83EIw2vBg
aBYwzfQL5kTE8FKAWXURk2a/NbJk4WWT3BBQZt8HzTmkdgfHsgCimjzQNKgBw7AN
2d1FrGgNk9EuwZjbrtJmLoSTQ9tieUk67jLhsgj1S8gRrrV4YPoYE8RrXKmYGEGe
FUJPpcrd7fPDUpPvchZI1jVlPzL+S2W0L3U/KSwhWGey119FgktRVX4ljjquX+iP
3zxaFIGO9K5vIG/pzxFCDZ9R6gCWBdryPU3q/+a0wZWNLclZROAQd939ekFBY4lD
ZEta6trdhOkVRkgHU27BdikvJRgzFrZBnm6YUomelezQM3XjT0yeK9OT60EOWNx5
upg8mHnodGcUdxzUtnzzV3tVvtunAYFGpw/zuwff5B0p16nJKqU=
=8lWk
-----END PGP SIGNATURE-----

--Sig_/aB.pTc2IuOjACzyPfRof4hD--
