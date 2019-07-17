Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2EA2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfGQIRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:17:11 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48249 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:17:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45pVVW2Qxkz1rK4w;
        Wed, 17 Jul 2019 10:17:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45pVVW1bdKz1qqkk;
        Wed, 17 Jul 2019 10:17:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id xkHrL21nNJg8; Wed, 17 Jul 2019 10:17:05 +0200 (CEST)
X-Auth-Info: dpSTQWSDAzf4wgslH74+b3etluAaZEKtmtRkVTiYpFY=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 17 Jul 2019 10:17:05 +0200 (CEST)
Date:   Wed, 17 Jul 2019 10:17:04 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 3/3] input: touchscreen mc13xxx: Add mc34708 support
Message-ID: <20190717101704.2ff4d877@jawa>
In-Reply-To: <20190717033655.GC621@penguin>
References: <20190716221929.3782-1-lukma@denx.de>
        <20190716221929.3782-4-lukma@denx.de>
        <20190717033655.GC621@penguin>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bfopTdlYpTmTI0/.0Uf3PCA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bfopTdlYpTmTI0/.0Uf3PCA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> On Wed, Jul 17, 2019 at 12:19:29AM +0200, Lukasz Majewski wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > The mc34708 has a different bit to enable pen detection. This
> > adds the driver data and devtype necessary to probe the device
> > and to distinguish between the mc13783 and the mc34708.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v3:
> > - Replace forward declaration of mc13xxx_driver_data with
> >   structure definition
> > - Rename mc13xxx_driver_data with mc13xxx_chip
> > - Move static struct mc13xxx_chip mc13783_chip and mc34708_chip
> >   closer to ID table
> > - Do not check mc13xxx device type =20
>=20
> You do not even need to define or store the type. Once it is dropped
> please feel free to add

Ok. I will remove the type definition.

>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> and merge with the other 2 patches.
>=20

Ok. I will squash those three patches into a single one, add your
Acked-by and wait for Lee to pull this single patch to his MFD tree.

Thanks for review and help :-).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/bfopTdlYpTmTI0/.0Uf3PCA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl0u2YEACgkQAR8vZIA0
zr1Gagf+P8RQt3O4pwxt7GUd1HpRpMLyELslWExzBG5Oqs0Mb7ZyhW/Wk5uHIyDg
0YFoYvyIe9kjVjgfxZAOAipIDCLQNFv+hUIDp/+VDcLPDdvZdokJHNzEPqb1LPGz
5+ZkKHm8UlzqiAu8+QzzXQ5vDHA31Y0IBtBiAtet+zPqrre2F1OAkSXRfnN7vXou
vguchQf/NASbsG9DvUDfhFUZKQ2PdNJxpDCg7nXbcDHTU45dutxpDmm8JNlnxeu8
dt03SQaqASiIBSFcI0l7pHl+e8pFpgXSdjdwlI1LbE0DIj884M3HuErzvpInX0Ua
jcrZ90ATOX0zUObbIlPiVOozngzCGw==
=ji12
-----END PGP SIGNATURE-----

--Sig_/bfopTdlYpTmTI0/.0Uf3PCA--
