Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3C820657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCDPXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:23:52 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:39233 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:23:51 -0500
Received: from localhost (unknown [185.94.189.188])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9690120000D;
        Mon,  4 Mar 2019 15:23:48 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:23:48 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64-amarula-relic: Add STLM75
 sensor
Message-ID: <20190304152348.ye3xuk4ru6dpo6g7@flea>
References: <20190301171051.6964-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sj34vhhorsyvtgc6"
Content-Disposition: inline
In-Reply-To: <20190301171051.6964-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sj34vhhorsyvtgc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 10:40:51PM +0530, Jagan Teki wrote:
> Amarula A64 Relic has STLM75 sensor for digital temperature
> and thermal watchdog.
>=20
> Add support for it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sj34vhhorsyvtgc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH1DAwAKCRDj7w1vZxhR
xZMyAQD5e2kCKNeGtxZkX6lLAkVQXCc4JXnnr/Vkl6Vklg3LyAD/XRgdea0Ni5+v
FpPItoJMYadVDXnFXw9wPFfoiRwCAAA=
=ckXI
-----END PGP SIGNATURE-----

--sj34vhhorsyvtgc6--
