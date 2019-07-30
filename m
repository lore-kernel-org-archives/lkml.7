Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916BAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8BE20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfG3QFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:05:01 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43852 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfG3QFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:05:01 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45yhGL5v2qz1rfcq;
        Tue, 30 Jul 2019 18:04:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45yhGL51J8z1qqkM;
        Tue, 30 Jul 2019 18:04:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id sEBAZfL2s-uz; Tue, 30 Jul 2019 18:04:56 +0200 (CEST)
X-Auth-Info: NMGXziR/PhuMc/va7X2TT6X0tYpuv4qbHHDlc7BiilA=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 30 Jul 2019 18:04:56 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:04:51 +0200
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
Message-ID: <20190730180451.38cad018@jawa>
In-Reply-To: <CAOMZO5AoSCDCMRKpkWQ=0PwiFG-O9doGaA31FRhDCGmNr7Xefg@mail.gmail.com>
References: <20190730150552.24927-1-lukma@denx.de>
        <CAOMZO5AxPHHobQQhq30fjLVeSroLdvdT0+GqCWi8it1ejhDONA@mail.gmail.com>
        <20190730175336.382d833c@jawa>
        <CAOMZO5AoSCDCMRKpkWQ=0PwiFG-O9doGaA31FRhDCGmNr7Xefg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FFYaC=52dh2nz5Y2tmjEFGz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FFYaC=52dh2nz5Y2tmjEFGz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Tue, Jul 30, 2019 at 12:53 PM Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > Shall I refer to the original commit (which added this DTS)? Or the
> > original issue posted to linux-mtd [1] ? =20
>=20
> You can add a Fixes tag like this:
>=20
> Fixes: a67d2c52a82f ("ARM: dts: Add support for Liebherr's BK4 device
> (vf610 based)")

Yes, the above is correct (as indicated [1]), but I was not sure if I
should also refer to the original post to linux-mtd ML.

Now it is clear - thanks :-)

Note:

[1] -
https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#revie=
wer-s-statement-of-oversight

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/FFYaC=52dh2nz5Y2tmjEFGz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl1AaqMACgkQAR8vZIA0
zr1ITwf+P4+TW29l+wXSF2r4SKuAIoARSdCU3NSfGUpLW7gBQbK3x4RXlNnYW2y5
pLsjYgE4yPWa6xv+Eo0oZz23EgmQdXCEmflVB85+CxRJpOPTfL0f1oRNmYXm0Nfq
uQBko26IzNP+LMzSHDqJnaViHdWqP8URYGpMKHxL4lEUbZRfMzpieYt1IgHbCcB0
/H0cx/EFFO3P+txZw7OQwaZSvYhSrwqO9hc645rXXIqqzO+nJ/RtWw5FAgVZHK6g
tGTZ8rMYvWfhh/RuZwZzM7QktcV5NPxlVBagXFLujay/OSs/ENNO7MyWSTjL4g9B
F0ZoHf+Mp8liTvpd9aet/8v1UMB3BQ==
=LT7H
-----END PGP SIGNATURE-----

--Sig_/FFYaC=52dh2nz5Y2tmjEFGz--
