Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AC8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E59220851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfEWMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:25:02 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:56764 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbfEWMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:25:02 -0400
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2A7423A2002;
        Thu, 23 May 2019 11:54:06 +0000 (UTC)
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D2CD31C0016;
        Thu, 23 May 2019 11:53:55 +0000 (UTC)
Date:   Thu, 23 May 2019 13:53:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20190523115355.joyeqlmbjkufueyn@flea>
References: <20190521105151.51ffa942@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="22oxjvmo2hvuqeqd"
Content-Disposition: inline
In-Reply-To: <20190521105151.51ffa942@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22oxjvmo2hvuqeqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 10:51:51AM +1000, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the drm-misc tree got a conflict in:
>
>   Documentation/devicetree/bindings/vendor-prefixes.txt
>
> between commit:
>
>   8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
>
> from Linus' tree and commits:
>
>   b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
>   b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S9700RTWV43TR-01B")
>   fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electronics")
>
> from the drm-misc tree.
>
> I fixed it up (I deleted the file and added the patch below) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

I just took your patch and pushed a temp branch there:
https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git/commit/?h=drm-misc-next&id=3832f2cad5307ebcedeead13fbd8d3cf06ba5e90

Rob, Stephen, are you ok with the change? If so, I'll push it.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--22oxjvmo2hvuqeqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOaJzQAKCRDj7w1vZxhR
xcfwAP9V0omTw8jbR0a5wFDMizYxiSE6KvGa0yDpAyucXGBcqAEAgP78Gkggt6vS
4E1Xd5LVpNQXXiwmH7FNbcL6r2C8ggk=
=birf
-----END PGP SIGNATURE-----

--22oxjvmo2hvuqeqd--
