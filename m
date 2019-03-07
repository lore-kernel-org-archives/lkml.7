Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E3DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F219520835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfCGM03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:26:29 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47027 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:26:29 -0500
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id ABC0C1BF204;
        Thu,  7 Mar 2019 12:26:19 +0000 (UTC)
Date:   Thu, 7 Mar 2019 13:26:19 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 2/2] arm64: allwinner: a64: Add Oceanic 5205 5inMFD
 initial support
Message-ID: <20190307122619.hqy5xtkke2jt4ols@flea>
References: <20190306170110.27342-1-jagan@amarulasolutions.com>
 <20190306170110.27342-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zcmq6d7fi4rbuei5"
Content-Disposition: inline
In-Reply-To: <20190306170110.27342-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zcmq6d7fi4rbuei5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 10:31:10PM +0530, Jagan Teki wrote:
> Oceanic 5205 5inMFD is a 5 inch Multi function display baseboard
> designed to mount SoPine SOM.
>=20
> Key features:
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 2GB DDR3 RAM
> - SD Slot
> - SPI-NOR flash
> - EMAC, RTL8211E
> - MCP2515 CAN
> - 4-lane, MIPI-DSI panel
> - Goodix 911 CTP
> - USB Host
> - 12V DC power supply
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zcmq6d7fi4rbuei5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIEN6wAKCRDj7w1vZxhR
xRxVAQCL+BCbz/FdRPdNdlr5deYAIbFCNy+0sGPAtLvqUlcGugEA6seFhgqCq9ZZ
tcU4rtVKuTor4zzHs6KxFmp8U93V5gw=
=uvoJ
-----END PGP SIGNATURE-----

--zcmq6d7fi4rbuei5--
