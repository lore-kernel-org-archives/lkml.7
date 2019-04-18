Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D983EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbfDRO1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:27:12 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50075 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388902AbfDRO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:27:12 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 20ABEFF802;
        Thu, 18 Apr 2019 14:27:08 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:27:08 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/3] sun4i/drm: Fixes for removing and re-probing the
 driver
Message-ID: <20190418142708.4k7ccmxxbx74ve3a@flea>
References: <20190418132727.5128-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tmcln3h4d4q22lew"
Content-Disposition: inline
In-Reply-To: <20190418132727.5128-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tmcln3h4d4q22lew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 03:27:24PM +0200, Paul Kocialkowski wrote:
> This series brings-in some fixes that are necessary to be able to
> remove the driver at run-time (when built as a module) and properly
> re-probe it afterwards.

Applied all three, thanks
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tmcln3h4d4q22lew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLiJPAAKCRDj7w1vZxhR
xRpvAQCvHjhy+l+pRLBIeXF3tYyjR2pk9UwwIIAT0uITqpIu+QD/YGAARueloVQC
2pdYbuKUIWuFHQS+cCBCF1ULpGHfyAo=
=OMj+
-----END PGP SIGNATURE-----

--tmcln3h4d4q22lew--
