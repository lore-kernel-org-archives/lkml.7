Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43449C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEF820693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfG3Pxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:53:48 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56511 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfG3Pxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:53:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45yh1N0nPyz1rTYf;
        Tue, 30 Jul 2019 17:53:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45yh1M6Zhqz1qqkK;
        Tue, 30 Jul 2019 17:53:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2NMNNE217Hy2; Tue, 30 Jul 2019 17:53:42 +0200 (CEST)
X-Auth-Info: TJA1EiAuhI/vHNhcnsilPqlOm1nG0ETqlS47Wvo9Jc0=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 30 Jul 2019 17:53:42 +0200 (CEST)
Date:   Tue, 30 Jul 2019 17:53:36 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: DTS: vybrid: Update qspi node description for
 VF610 BK4 board
Message-ID: <20190730175336.382d833c@jawa>
In-Reply-To: <CAOMZO5AxPHHobQQhq30fjLVeSroLdvdT0+GqCWi8it1ejhDONA@mail.gmail.com>
References: <20190730150552.24927-1-lukma@denx.de>
        <CAOMZO5AxPHHobQQhq30fjLVeSroLdvdT0+GqCWi8it1ejhDONA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hls2KDiiZhS_2XwqOwjo/0W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hls2KDiiZhS_2XwqOwjo/0W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> Subject line could be improved:
>=20
> ARM: dts: vf610-bk4: Fix qspi node description
>=20
> On Tue, Jul 30, 2019 at 12:06 PM Lukasz Majewski <lukma@denx.de>
> wrote:
> >
> > Before this change the device tree description of qspi node for
> > second memory on BK4 board was wrong (applicable to old, in-house
> > tunned fsl-quadspi.c driver).
> >
> > As a result this memory was not recognized correctly when used
> > with the new spi-fsl-qspi.c driver.
> >
> > From the dt-bindings:
> >
> > "Required SPI slave node properties:
> >   - reg: There are two buses (A and B) with two chip selects each.
> > This encodes to which bus and CS the flash is connected:
> > <0>: Bus A, CS 0
> > <1>: Bus A, CS 1
> > <2>: Bus B, CS 0
> > <3>: Bus B, CS 1"
> >
> > According to above with new driver the second SPI-NOR memory shall
> > have reg=3D<2> as it is connected to Bus B, CS 0. =20
>=20
> I am glad you got it working!
>=20
> This looks very familiar with the suggestion I sent yesterday:
> http://lists.infradead.org/pipermail/linux-mtd/2019-July/090655.html
>=20

Yes, indeed. Deepest apologizes for not adding credits. I will fix it
in v2.

> It is a good practice to give some credit to someone who has helped in
> finding the solution of your problem.
>=20
> Adding a Suggested-by: Fabio Estevam <festevam@gmail.com> would be
> nice here.
>=20
> This also needs a Fixes tag.

Shall I refer to the original commit (which added this DTS)? Or the
original issue posted to linux-mtd [1] ?

Note:

[1] - https://www.spinics.net/lists/linux-mtd/msg08114.html

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Hls2KDiiZhS_2XwqOwjo/0W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl1AaAAACgkQAR8vZIA0
zr36MQgA4Oorheiqhn9obaiAQFJhr++QNaJEtm0Bs+T2h6ZblLVgYbPqys8+6biN
oLxpS3COrCwo3B8xFK4MxWze3qqyDYKPuse2NqFEW02qIIPPjPKfMNiEY8YIy+p7
5Yas3dvZar13iUmiyVuoTRk2kC7zFHRzv39YM0RHfYbIx+V+IcQTDnAbwkBj4iT/
oSDBq54OR5R7q+CvR1xncl7HzfXP1QwYw8MhEEWsOhhMWQ6sEJp56oz1gnNW5KF/
2Tah7fpuzhsUw+ysmqB3V7lXwvc3BQYIzQhtHWFFYLWjunrqN6kyUH+VXfv5cswV
M5vvDYesZAOADYr1KfN/DCX7JwdLmg==
=WzwS
-----END PGP SIGNATURE-----

--Sig_/Hls2KDiiZhS_2XwqOwjo/0W--
