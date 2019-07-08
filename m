Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC1BC606B0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32262082A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qN1ubgHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfGHXzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:55:32 -0400
Received: from ozlabs.org ([203.11.71.1]:51019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGHXzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:55:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMlN26mWz9s7T;
        Tue,  9 Jul 2019 09:55:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630129;
        bh=Ym/EKIz5+mGt0NSG1eoSDd4Mz2GAB/KfhmkvnjZb7sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qN1ubgHHJ6+n51Yf/AmKngEf4pkDeQV5YH/6hhgU5oBBd3/x7Oo0S+YJbpcspIz+Z
         /DJW9PrFULQsgrUNJ5tpTIibDVuYimm6VWt/OcoNl+39eW5n8gIxU1iC4dKccXFdRN
         syRoAi/12QsyW9HYSAKhWz5Aeby71k0/XpKcRHoe08QrT2qkvMojO86jdIF0+XW0eA
         QvNAf5D7t1hR0MS2TJlmy3vscd7nsPpQJ5xsib9ESMi+5554KAdkdJG6111btvyy8D
         EsYLNT/+OmTWRXu1NsXodpFdQAnZdNdZYVJ6DbXQsdmiBqCv98+CWitEP/dFt6GPC5
         vPORr1u5tKdng==
Date:   Tue, 9 Jul 2019 09:55:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     DRI <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the drm-intel tree with the pci
 tree
Message-ID: <20190709095527.6c5118c4@canb.auug.org.au>
In-Reply-To: <20190624135352.18b7dd23@canb.auug.org.au>
References: <20190617132027.3e34597d@canb.auug.org.au>
        <20190624135352.18b7dd23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D1G4KJeDENqWWOoBEugAETS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D1G4KJeDENqWWOoBEugAETS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 24 Jun 2019 13:53:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 17 Jun 2019 13:20:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the drm-intel tree got a conflict in:
> >=20
> >   drivers/gpu/drm/i915/i915_drv.h
> >=20
> > between commit:
> >=20
> >   151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
> >=20
> > from the pci tree and commit:
> >=20
> >   1bf676cc2dba ("drm/i915: move and rename i915_runtime_pm")
> >=20
> > from the drm-intel tree.
> >=20
> > I fixed it up (I just removed the struct definition from this files as
> > the latter did - its comment will need to be fixed up in its new file)
> > and can carry the fix as necessary. This is now fixed as far as linux-n=
ext
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts. =20
>=20
> This is now a conflict between the drm and pci trees.

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/D1G4KJeDENqWWOoBEugAETS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j1+8ACgkQAVBC80lX
0GyJTgf/cBbLXDHFPdz3+Zmf+6DPtIEhbm4KguM5dpbf8q2ytStyp4y5gYf72eNt
P0enaV0V3uLxcUtPIp8EtFrdHBHKmtuUfXs0ZhcnJ2UFJNevDRtcm47gi6UQ97bb
LV3Z/hj3ioUV2T/rq7FnBWU05wjMd3fyoJxb3qUsejOkIKenthyjueVVnOHBgKiW
u5JIIwPcfYN3ykYPhQAbc4KZJH4GIezgAOwmhkP+aWco+Pj/Y3VOzXosK49WjWyj
Ag4nvuxUsi+d0O2KuqXFxdGw68UqFQ8pexjbbHCCKmkCUm/muYJmR244DHXle2aX
HFNyj0Ui07q0a3mcfxBbh7qX1wS6kg==
=6X62
-----END PGP SIGNATURE-----

--Sig_/D1G4KJeDENqWWOoBEugAETS--
