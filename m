Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8BFCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BA821929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502097AbfJYKAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:00:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60329 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501929AbfJYKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:00:12 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47003F62bqz1qql6;
        Fri, 25 Oct 2019 12:00:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47003F4PlJz1qqkV;
        Fri, 25 Oct 2019 12:00:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ovzOP7q8XvP5; Fri, 25 Oct 2019 12:00:08 +0200 (CEST)
X-Auth-Info: YbElbo8Z68PG9NQbk7OPA01W/n0q3PIO9eLcf6q6MeQ=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 25 Oct 2019 12:00:08 +0200 (CEST)
Date:   Fri, 25 Oct 2019 12:00:00 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] dts: Disable DMA support on the BK4 vf610 device's
 fsl_lpuart driver
Message-ID: <20191025120000.5dbb837d@jawa>
In-Reply-To: <20191025085515.GH3208@dragon>
References: <20191010090802.16383-1-lukma@denx.de>
        <20191025085515.GH3208@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/By24V4SN7mPcjm/avn3Dc5F"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/By24V4SN7mPcjm/avn3Dc5F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> On Thu, Oct 10, 2019 at 11:08:02AM +0200, Lukasz Majewski wrote:
> > This change disables the DMA support (RX/TX) on the NXP's fsl_lpuart
> > driver - the PIO mode is used instead. This change is necessary for
> > better robustness of BK4's device use cases with many potentially
> > interrupted short serial transfers.
> >=20
> > Without it the driver hangs when some distortion happens on UART
> > lines.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com> =20
>=20
> Subject prefix should be 'ARM: dts: ...'.  I fixed it up and applied
> the patch.
>=20
> Shawn

Thanks :-)


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/By24V4SN7mPcjm/avn3Dc5F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2yx6AACgkQAR8vZIA0
zr1f0AgA09kZumpnsPlEwl87PkX6natOW7hAKLdpkClGwO/Iwc7eMgFOoVZmRoL9
U5wQZVVhjwr7CVtiwg16KpE5l5gh1+I1hc8GCb7uKByzMFGFbAKT5IIOcIQYLFpt
7WMYRGp9T+hAw3SPKoj8zqNYceFS+b/ZJ9F6PENWrQXmY9L5yMB68dEJknGGf0Hu
ZYi2MIBT2JXSRcgoC+EYZA/8OllXEATMCSZxIcc1aZdcPqWfdS8fE3l2AAafle99
JcIfbjMf1RAn/aLtS73a7Dggmv8Rk+QPKj2qjrrmXnel680QVgwcMINjd0ihbq+4
vdq3ph01H/WlHpjHKKcqjHxAEn4P/w==
=6lWc
-----END PGP SIGNATURE-----

--Sig_/By24V4SN7mPcjm/avn3Dc5F--
