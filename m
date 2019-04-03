Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B992084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCUr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:47:59 -0400
Received: from sauhun.de ([88.99.104.3]:51544 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDCUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:47:58 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id 9DC1E2C282F;
        Wed,  3 Apr 2019 22:47:56 +0200 (CEST)
Date:   Wed, 3 Apr 2019 22:47:56 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     laurentiu.tudor@nxp.com
Cc:     u.kleine-koenig@pengutronix.de, mojha@codeaurora.org,
        linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com
Subject: Re: [PATCH v2] i2c: imx: don't leak the i2c adapter on error
Message-ID: <20190403204756.mbc7zc5klfd5zydg@ninjato>
References: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5bv5jrwovk4okep"
Content-Disposition: inline
In-Reply-To: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5bv5jrwovk4okep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 01:14:37PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> Make sure to free the i2c adapter on the error exit path.
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Reviewed-by: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
> Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_dma=
_request()")

Applied to for-current, thanks!


--e5bv5jrwovk4okep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlylG/sACgkQFA3kzBSg
KbY7NA/+OYTlxmIrzeQ96oMeThGobNltt9M5/8SMQzFO/sx9hUKRDFH2whp2ZVHB
UOFKvbfGUQUd1M24eRxqsrvqAQDxjfrOHRzZgxiCzCbGYdcgHeIr+IJjb9O7xxAm
ImAFZaTfsVxr0r6pwRLxmo/e7ID9rvq4uRDyu5k3u/CW0RZ1iT09/NbuiUFWV2Lr
yJYHNpHKz+kr1dAkxMGTOMUpdxSmQpHaNa89mPnPzgP6O8vdanJod+7kun6NGDTU
hAFO0HosTwbnVR2WySVLPITryXSpwg69oaaGyKkntjBwxbsulvP3olkk/+2d4+8N
GDkjOmEtfoTXMYdOEmzX5Il5ATjs1BSwoEKDjSBM2+VwzKWgioOQlwfh2xdKHZpp
oQp5Ug9Xt4bPsXJkZA13/BCBkR79JzdTJZZwAB+GoYIYAiPBtmg4vNcEIwjTqCSS
RhowyLiadlKtBBFl4/x6Bre4XS4m77mzl+U9RV5mqqFIqYnWjgRCzKxg6c5IsHTZ
9VU1w9Q2FGFqktNqMyRKJkj82RRI+xhaOI5J62GlNsnKJZ03lrzma9fUSkrZHV0d
FTOjWjIktcP+oBW0v1jRBahuDhTOfdEq2pqIIbHTi7Sa0eN8q1/8yuNRc9+yLEXq
GgH6i7jlC/V7rbi+vOxp7G/vIeo0b+AfUJAtC9r4jq3rZjW9Pj8=
=Oe0l
-----END PGP SIGNATURE-----

--e5bv5jrwovk4okep--
