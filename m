Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99665206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbfDROZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:25:06 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46951 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388806AbfDROZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:25:06 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 30EBFE0003;
        Thu, 18 Apr 2019 14:25:01 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:25:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] drm/sun4i: Use DRM_GEM_CMA_VMAP_DRIVER_OPS for GEM
 operations
Message-ID: <20190418142500.brj6aaxdsz4kioyt@flea>
References: <20190418130509.3569-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xrbgbw4dafm4rk7f"
Content-Disposition: inline
In-Reply-To: <20190418130509.3569-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xrbgbw4dafm4rk7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 03:05:09PM +0200, Paul Kocialkowski wrote:
> Our driver makes a typical use of CMA, with GEM object allocated as
> GEM CMA objects. Use DRM_GEM_CMA_VMAP_DRIVER_OPS to describe the ops
> instead of duplicating them.
>
> Because DRM_GEM_CMA_VMAP_DRIVER_OPS implements a gem_create_object op
> which sets per-object funcs (drm_cma_gem_default_funcs), we can also
> get rid of free_object_unlocked and gem_vm_ops, which are superseded
> by the object funcs.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xrbgbw4dafm4rk7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLiIvAAKCRDj7w1vZxhR
xYlCAQDk7oIjARBEqtCsXkkufLbcPp5vGO5ZBynNygS0NWJN+wEAv8877yQ7/6VK
9QGT03OVzf9GhOwr7ajqRerRefM2og4=
=gMt7
-----END PGP SIGNATURE-----

--xrbgbw4dafm4rk7f--
