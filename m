Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF5EC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfFXOAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:00:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFXOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:00:11 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1hfPVs-00064e-Ph; Mon, 24 Jun 2019 16:00:04 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1hfPVq-00043X-LZ; Mon, 24 Jun 2019 16:00:02 +0200
Date:   Mon, 24 Jun 2019 16:00:02 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20190624140002.s3au65gbsx6mtfkf@pengutronix.de>
References: <20190624222359.62e92a15@canb.auug.org.au>
 <20190624132056.GC16146@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y4z6ot536bqzjjir"
Content-Disposition: inline
In-Reply-To: <20190624132056.GC16146@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:59:26 up 37 days, 20:17, 97 users,  load average: 0.17, 0.18,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y4z6ot536bqzjjir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 09:20:57PM +0800, Shawn Guo wrote:
> On Mon, Jun 24, 2019 at 10:23:59PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commit
> >=20
> >   9b5800c21b4d ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC So=
M Support")
> >=20
> > is missing a Signed-off-by from its author.
>=20
> Thanks for spotting it, Stephen.
>=20
> @Michael, would you please give your SoB?  Otherwise, I will have to
> back out the patch.

Sure!

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--y4z6ot536bqzjjir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl0Q11wACgkQC+njFXoe
LGTO+xAAoPqAWT2BExJub9eYcvbVPICjIkbbOJnzN672YZYWo37PratlGciyqv8r
kS/qj27eHHtPytBd0gq77urfn9B/PYA/uDTiGUmPIKiYLyuZsASSadRnvrwjD0ke
exHEOR+MoIkKRarCGr2Ir/mExiq3fb0r/11nJ7B7w2s6ska9ypXk7tL5d+fEa5Qe
iNF5idfqJNoInqcDlRrzgv9fZ0B6aEEBMYIn3IXNBBuqjbziBJuWYi5qAdjCp/d4
dHQTS9Jy5hHqW86D/G5mOuzGfLbf24ks3WK/KbKNWtoblQP1PWMRG5IT08pkqSKH
RaYHjrBtCiae+Q73odZm9BXE/o33lJ+8LdADTKhcWdPG1Ksdm7lw/En64vrFhA8u
m54CHj/s4wFYhTHyM2UOetf22AUeMyfpOEAV2swEFVg5KULaxLXKl96kma2kbvwI
Aj4uqj+2Vh5tEqAfTMJvXC+fsUcQAo84DvCa27YfaEnXrgwx1amrab8TFiO73kV+
5jmU4bhVGlmHBeiUO2Q/FG5M/1yZXO34TKodGbUWY52eJh8YSCudFoh+6i7N9sxC
SP4vUJx4JbuX8+hfBK3SWtHS0XTDpUlLhZZpDnmOlVh/LxrTByoj7fNUyrKdxdD/
RKGapGY/Y//1gZtQe3DpPyXrSYOIGPyRCEctsmxnDD8o6tFNcCQ=
=Lah3
-----END PGP SIGNATURE-----

--y4z6ot536bqzjjir--
