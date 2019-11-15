Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19290C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56192072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:28:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38195 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKOI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:28:31 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iVWxx-00035K-1e; Fri, 15 Nov 2019 09:28:29 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1iVWxw-0005Il-Io; Fri, 15 Nov 2019 09:28:28 +0100
Date:   Fri, 15 Nov 2019 09:28:28 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx25: fix usbhost1 node
Message-ID: <20191115082828.tc3dbjnv7bojgrg4@pengutronix.de>
References: <20191111114655.9583-1-m.grzeschik@pengutronix.de>
 <20191114211708.77d6bttkyj426yqy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="prnwotkb3gjhqohe"
Content-Disposition: inline
In-Reply-To: <20191114211708.77d6bttkyj426yqy@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:27:20 up 130 days, 14:37, 121 users,  load average: 0.17, 0.16,
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


--prnwotkb3gjhqohe
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 10:17:08PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Nov 11, 2019 at 12:46:56PM +0100, Michael Grzeschik wrote:
> > The usb port represented by &usbhost1 uses an USB phy internal to the
> > SoC. We add the phy_type to the base dtsi so the board dts only have to
> > overwrite it if they use a different configuration. While at it we also
> > pin the usbhost port to host mode.
> >=20
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for the ACK.

I just figured out that we also can add the limitation
to maximum-speed =3D "full-speed" into to dts. Since the
internal phy maximum speed is limited to that.

I will send an v2.

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--prnwotkb3gjhqohe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl3OYakACgkQC+njFXoe
LGQPhRAAwwmh0pLFGDajFYvnBK59/qcOgTpCWpRj3DRglHJp8Eu7aI9tTLrfGed1
MWpJPtrvFKFWdc4HjC7XEcSo/KwIzpI9d92oiXB7LwfiLoCrVmDvwTCxICqe3aLM
XgU9otlF2k8cK9s7IRb0UEo2wj06B1FUVGlBpd6YbxhI/mLtgvQGRb/RXacbEJC1
fvc7YtgjeA1piiVadonjrS2WuxMdz7aPxgHGDuC9pO5/O04xSBIZ1w96oxnbyxtp
dFH+Cf5lNIbUcAn+V6HIyc54ZOWgdc7ZdlBbnXrBHM2eqsF/+VDJuEynCr/rVTcs
l29Iwq/jcN6vP1mFeoBAPkLtBFQ3ReszjK7kaiDsK6NG7oNSMDWyMf6L4DDpO5kr
MScLAqZHU9/7lXg+CmtBw2EJGQW5/cSLWQuIUqWrtDJkRD0yjvVS+mQyHrx+hkFI
y6SxaHpj7y98uBActiB/8CBJZJ+g8w1hsB0ttlN7qOUr2zq9cf0qzRgvG+6k9zlp
SN5AG5zWoUF6JFfyd9u5GZWfpwmHiiOfqmXpy3X/riXW5YsVEYUiXtmlLydCPt/x
+SyehRxLa0DA79vFju5ykeNj4GmwR3DaYKuYTJDie2m7olt9TQY2Y6Erk+aHDVkD
90ji6y4LTivFUPo364/rTliM7mO80sRb4/Nw1Fu7MfMnuHmQq+w=
=oazr
-----END PGP SIGNATURE-----

--prnwotkb3gjhqohe--
