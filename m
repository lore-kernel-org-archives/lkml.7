Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E320811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCNPqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:46:32 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39803 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCNPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:46:31 -0400
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 922E024000B;
        Thu, 14 Mar 2019 15:46:28 +0000 (UTC)
Date:   Thu, 14 Mar 2019 16:46:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi-ng: f1c100s: fix USB PHY gate bit offset
Message-ID: <20190314154627.7f322sd2sd7asnnc@flea>
References: <20190314112108.6150-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gh35n5sikmol5ate"
Content-Disposition: inline
In-Reply-To: <20190314112108.6150-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gh35n5sikmol5ate
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2019 at 07:21:08PM +0800, Icenowy Zheng wrote:
> The bit offset of the USB PHY clock gate on F1C100s should be 1, not 8.
>=20
> Fix this problem.
>=20
> Fixes: 0380126eb9af ("clk: sunxi-ng: add support for suniv F1C100s SoC")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gh35n5sikmol5ate
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIp3UwAKCRDj7w1vZxhR
xRr8AP9bvlecZCePreW1bagtRGj1Af3H1AzN+Y/tMKYY0foVVgEAq3HsIWN5LtV8
8XTCZGzDSbZOhPmHqKUJF7spt1sbEg0=
=DKGA
-----END PGP SIGNATURE-----

--gh35n5sikmol5ate--
