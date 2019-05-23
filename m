Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66999C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354F721019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bIEO04C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfEWJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:34:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50567 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfEWJeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:34:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458kqV1y1Qz9s9T;
        Thu, 23 May 2019 19:34:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558604087;
        bh=w6loxVXiUPCui8tllc+juimOSwqBjbTphljski1VjmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bIEO04C0QrgzXApoXOW/gC+6BD/B2SzTlGzHnAnVBmXNHLrK6bUXriS0HkRpzLRCJ
         h51yRP5j5xzH1qb2jtDllIMxCfOYM1PtfRhz+AaDQ3fhrZ/CsTtyrPkY2NvoSAtbfo
         sYulquD1yJEvJ7AHN8XeX/jeLGQwfVQT6E0sT9K+SidRsrvszw/afyUZr6gFXdp5y3
         goUmbh6xLa11urwI7BO7kyQyZwD+bkpSQLsKRdga6mGgT+zfPMueBjNLp4xnVEgiFB
         cDImQYmkEIYR/ZmhgGcMUGwpfXFS1gildaKUoYf73eyYuX9csS7Pq8uwvWAr2906CP
         RMFqwntzCuZaQ==
Date:   Thu, 23 May 2019 19:34:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20190523193402.60dc0812@canb.auug.org.au>
In-Reply-To: <20190523081022.cbirvf2vucbyc34r@flea>
References: <20190521105151.51ffa942@canb.auug.org.au>
        <20190523081022.cbirvf2vucbyc34r@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M4TugNSXYXC94YDxNnBwkzN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M4TugNSXYXC94YDxNnBwkzN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, 23 May 2019 10:10:22 +0200 Maxime Ripard <maxime.ripard@bootlin.com=
> wrote:
>
> Hi Stephen,
>=20
> On Tue, May 21, 2019 at 10:51:51AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the drm-misc tree got a conflict in:
> >
> >   Documentation/devicetree/bindings/vendor-prefixes.txt
> >
> > between commit:
> >
> >   8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> >
> > from Linus' tree and commits:
> >
> >   b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
> >   b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S9=
700RTWV43TR-01B")
> >   fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electron=
ics")
> >
> > from the drm-misc tree.
> >
> > I fixed it up (I deleted the file and added the patch below) and can
> > carry the fix as necessary. This is now fixed as far as linux-next is
> > concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 21 May 2019 10:48:36 +1000
> > Subject: [PATCH] dt-bindings: fix up for vendor prefixes file conversion
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 83ca4816a78b..749e3c3843d0 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -287,6 +287,8 @@ patternProperties:
> >      description: Everest Semiconductor Co. Ltd.
> >    "^everspin,.*":
> >      description: Everspin Technologies, Inc.
> > +  "^evervision,.*":
> > +    description: Evervision Electronics Co. Ltd.
> >    "^exar,.*":
> >      description: Exar Corporation
> >    "^excito,.*":
> > @@ -851,6 +853,8 @@ patternProperties:
> >      description: Shenzhen Techstar Electronics Co., Ltd.
> >    "^terasic,.*":
> >      description: Terasic Inc.
> > +  "^tfc,.*":
> > +    description: Three Five Corp
> >    "^thine,.*":
> >      description: THine Electronics, Inc.
> >    "^ti,.*":
> > @@ -925,6 +929,8 @@ patternProperties:
> >      description: Voipac Technologies s.r.o.
> >    "^vot,.*":
> >      description: Vision Optical Technology Co., Ltd.
> > +  "^vxt,.*"
> > +    description: VXT Ltd =20
>=20
> I'm not sure whether or not you can change it, but this breaks the
> users of that file.
>=20
> What you want is:
>=20
> - "^vxt,.*"
> + "^vxt,.*:"

I have fixed my version (but I put the ':' after the '"' like the
others).

Thanks for letting me know.
--=20
Cheers,
Stephen Rothwell

--Sig_/M4TugNSXYXC94YDxNnBwkzN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzmaQoACgkQAVBC80lX
0GxmJQf/SjSWc6s/V4yp7MSJOXV7fj4rbcZvA9A6yD2j8kZMDC2DF2xv1yZ/9fKL
RDOBP4djWQOeFqd7HGliFFrlL899cNsOHHuhfaAa2cBSnHu1RfQAchRMtMsIv2yW
YtZ3P3TYohfBbOYS2kjKIkE+ITQEA7C8ZNhZCh6XoJ6iLmz7z83IyqACDHdTbxqW
nU0YcUtSnVf1b2WE3W/WVG+Z0ZKdGqmZ6lXXvtYX7A69YTFrjmU/3AYaQjLEq48y
AjSxJGWWkkysxsz+zSz0221MsakKDIYBcbuBA9Wh31XAqeedRVoTxN+kxQg4IIJ0
kzVUroPXneQc88gr0PFJ9YqltgTxUA==
=HfDy
-----END PGP SIGNATURE-----

--Sig_/M4TugNSXYXC94YDxNnBwkzN--
