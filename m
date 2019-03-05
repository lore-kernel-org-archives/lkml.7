Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D4F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfCEIoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:44:16 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55711 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfCEIoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:44:16 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AB3F920018;
        Tue,  5 Mar 2019 08:44:13 +0000 (UTC)
Date:   Tue, 5 Mar 2019 09:44:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: allwinner: allow compile testing
Message-ID: <20190305084413.hthto7doaafwb2xy@flea>
References: <20190304202406.1716350-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5fkhtwgzlyzgrweh"
Content-Disposition: inline
In-Reply-To: <20190304202406.1716350-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fkhtwgzlyzgrweh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 09:23:56PM +0100, Arnd Bergmann wrote:
> Some allwinner specific drivers can be built for testing purposes
> on non-sunxi configurations, which then results in a harmless
> warning:
>=20
> WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY
>   Depends on [n]: ARCH_SUNXI [=3Dn] && HAS_IOMEM [=3Dy] && OF [=3Dy] && R=
ESET_CONTROLLER [=3Dy]
>   Selected by [y]:
>   - DRM_SUN6I_DSI [=3Dy] && HAS_IOMEM [=3Dy] && DRM_SUN4I [=3Dy]
>=20
> Allow compile-test here as well to avoid the warning, and improve
> overall build coverage.
>=20
> Fixes: 5d134abf9530 ("phy: Move Allwinner A31 D-PHY driver to drivers/phy=
/")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5fkhtwgzlyzgrweh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH423QAKCRDj7w1vZxhR
xc97AP0bPZcAC2urOyp0po9XTB6JSTOwcZ7+GW1s/1Uyool3XAEA7BE14/8tuZsF
/O0vGi2OBt5jcFC6D6QW8pGHHNXM8AY=
=ZYKd
-----END PGP SIGNATURE-----

--5fkhtwgzlyzgrweh--
