Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725FC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C21F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MTixeUtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfEWA1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:27:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfEWA1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:27:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458Vh94p6bz9s3l;
        Thu, 23 May 2019 10:27:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558571259;
        bh=iQ7sW0KdL7UBztWiX8uTor0AuMLUrSOVbdabGR04EWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTixeUtxvFXsc3rytzhERcOoj91aFOJuZJTCDa/O2Ce1cK+inN03nd3HudSx3H8du
         VzKXn2jzDWPJlRntgJh2ABgYRFXyKGdWrMWO+jjK+XEhfQstQGpL+aCuKw/fdRFIqR
         0vZKHgp0fg8Onnfhz8NndoJ9N5Mm4D8WjFqrVgJ0WHpX81mvi9XAZY3vHugNSVe1SU
         ZzMt6mPfEtcXfckQtjz/epSE7CDqnL5Xw94g6szLKcTxIWgoR4+8CO1HMubpiRZYgz
         1KCEO6K3hlKweIcWP+oBvAg/JbtmGdmSQ4s6372w6UdevnWgf+CEqzbgdG1JYi5Ibm
         tneKQLRew5CMg==
Date:   Thu, 23 May 2019 10:27:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20190523102736.4845a80b@canb.auug.org.au>
In-Reply-To: <20190521105151.51ffa942@canb.auug.org.au>
References: <20190521105151.51ffa942@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0WxK/Zy6Cs5iCL1+uPRs7QG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0WxK/Zy6Cs5iCL1+uPRs7QG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Tue, 21 May 2019 10:51:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the drm-misc tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/vendor-prefixes.txt
>=20
> between commit:
>=20
>   8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
>=20
> from Linus' tree and commits:
>=20
>   b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
>   b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S970=
0RTWV43TR-01B")
>   fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electronic=
s")
>=20
> from the drm-misc tree.
>=20
> I fixed it up (I deleted the file and added the patch below) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 21 May 2019 10:48:36 +1000
> Subject: [PATCH] dt-bindings: fix up for vendor prefixes file conversion
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 83ca4816a78b..749e3c3843d0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -287,6 +287,8 @@ patternProperties:
>      description: Everest Semiconductor Co. Ltd.
>    "^everspin,.*":
>      description: Everspin Technologies, Inc.
> +  "^evervision,.*":
> +    description: Evervision Electronics Co. Ltd.
>    "^exar,.*":
>      description: Exar Corporation
>    "^excito,.*":
> @@ -851,6 +853,8 @@ patternProperties:
>      description: Shenzhen Techstar Electronics Co., Ltd.
>    "^terasic,.*":
>      description: Terasic Inc.
> +  "^tfc,.*":
> +    description: Three Five Corp
>    "^thine,.*":
>      description: THine Electronics, Inc.
>    "^ti,.*":
> @@ -925,6 +929,8 @@ patternProperties:
>      description: Voipac Technologies s.r.o.
>    "^vot,.*":
>      description: Vision Optical Technology Co., Ltd.
> +  "^vxt,.*"
> +    description: VXT Ltd
>    "^wd,.*":
>      description: Western Digital Corp.
>    "^wetek,.*":
> --=20
> 2.20.1

In doing a back merge of Linus' tree into the drm-misc tree, you seem
to have missed the above merge fixup and so lost some of the changes
from the above commits.

--=20
Cheers,
Stephen Rothwell

--Sig_/0WxK/Zy6Cs5iCL1+uPRs7QG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzl6PgACgkQAVBC80lX
0Gzo8ggAnX6lqBzN0XJKHIrMGP1dj1RyPS+AJu3T9HxPBag2M6JYPaW57qYtd9g2
laMr4Bwp7PDFVC3UmEJkmVZ05NDEHGvOrzecYrib596tF8FpjK6WciJjYKyMO1+7
cHwbU7kCcLGeVtIkvIzKtyn1wnZafScYwCNZxKiXlyZFOLYI0fqcL2rXyVIXGUeS
7T1x559NFyNJT3vDqlajTmavzQPTYQiHTjhol8EI0GCY8qZYE+9xR7CxTDS0ZbDI
MU11OdnFzxQASyCoqjOve46O3yDO6vh5d8L141MtRkr4bMQhh4Z1YilcEbM1WMC1
QWTuS2pny6GTDcJgvj0+ABKQUkH33w==
=tAtR
-----END PGP SIGNATURE-----

--Sig_/0WxK/Zy6Cs5iCL1+uPRs7QG--
