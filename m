Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E313C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C220C01
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfECOlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:41:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43311 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfECOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:41:45 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1E3876000F;
        Fri,  3 May 2019 14:41:42 +0000 (UTC)
Date:   Fri, 3 May 2019 16:41:42 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add PIO VCC bank supplies
 for Pine H64
Message-ID: <20190503144142.a5yvqghyqjm26g5u@flea>
References: <20190503094720.21502-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="siexvtguxgppryms"
Content-Disposition: inline
In-Reply-To: <20190503094720.21502-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--siexvtguxgppryms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 05:47:20PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC features tweakable VCC for PC, PD, PG, PL and PM
> banks.
>
> This patch adds supplies for these banks except PL bank. PL bank is
> where PMIC is attached, and currently if a PMIC regulator is added
> for it a dependency loop will happen.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied for 5.3, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--siexvtguxgppryms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMxTJgAKCRDj7w1vZxhR
xZBGAQD0GZcPeUDGu0W80Ry+o9dByn1an5WGaUI4LMHMNEg93wEAtjSHUwhmYqnG
VtpI36Q9pGIIS/I5jYzM1FjDnV49UwE=
=KYOT
-----END PGP SIGNATURE-----

--siexvtguxgppryms--
