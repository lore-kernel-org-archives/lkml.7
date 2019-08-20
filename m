Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ECF22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CdZvnBfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfHTBp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:45:58 -0400
Received: from ozlabs.org ([203.11.71.1]:48315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfHTBp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:45:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46CDCQ6ZJyz9sDQ;
        Tue, 20 Aug 2019 11:45:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566265555;
        bh=VQwMdlxVKDS5vPjUh0+7GkwL7+DW7Sa5iJnqk75Apgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CdZvnBfBBMv5XrzCT/7etg8QOWlnnhPYgSsbK35TOJaYBcqqkrsh8+E2jxnNPih9z
         DC9AL0xvSj9BHGO0Dlb1t9I1l9RJquUmxkBJ3Qh5UVGtTn4QSrQGmFL/lzReRj0Ami
         GANwPVYkqoJXKT3C7odVpzPZFoLI3ly1JTmA+FjGOSoAqIdxYWvYaGHQzK85vpJirR
         iGXQVL9nKrrhyY8LrehvJ97MIErZHNu/Yt4csiC7dwp7zGfFiP3WhrnU5se/ZsDwNb
         fo0k6wkcI2DLsor8stmfvv94AzwMmHzNFcRQImQOUZAs+jNbwWIlLIT/lIikrMojQd
         VKPHnFOsZ+6UA==
Date:   Tue, 20 Aug 2019 11:45:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: Tree for Aug 19 (amdgpu)
Message-ID: <20190820114554.0e522651@canb.auug.org.au>
In-Reply-To: <ba3cde82-6163-12e5-2e77-36834454113a@infradead.org>
References: <20190819191832.03f1a579@canb.auug.org.au>
        <ba3cde82-6163-12e5-2e77-36834454113a@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ST4OoFXdpAP+5=cX8fhr9hW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ST4OoFXdpAP+5=cX8fhr9hW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 19 Aug 2019 18:34:41 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 8/19/19 2:18 AM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20190816:
> >  =20
>=20
> on x86_64:
>=20
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: In function =E2=80=98amdgpu_e=
xit=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1471:2: error: implicit declar=
ation of function =E2=80=98mmu_notifier_synchronize=E2=80=99; did you mean =
=E2=80=98__sync_synchronize=E2=80=99? [-Werror=3Dimplicit-function-declarat=
ion]
>   mmu_notifier_synchronize();
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   __sync_synchronize
>=20
>=20
> Full randconfig file is attached.

Caused by commit

  6832c9dc8358 ("hmm: use mmu_notifier_get/put for 'struct hmm'")

from the hmm tree.

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c need to include linux/mmu_notifier.h
--=20
Cheers,
Stephen Rothwell

--Sig_/ST4OoFXdpAP+5=cX8fhr9hW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1bUNIACgkQAVBC80lX
0GxdzAf/dKMAj82tHRTzFb6SoJlnbnbHSbq1KtBSskLed0d9JATgMuYVT21kYmhx
uCbRHbfdCHWJrnNqX8+tjhLpWLoj2csw9XwdUz3mU2t0KHFDJmjuu1uA4QO2+MIi
Lmis+ayt5TNsMd/O40ihMr7k+0fY2EQBIS2VR+KPkPvCSRiAUquEt7OWzAKUSckF
dA5q9F1vO2emerssEYLN3IFlNCVzwj6pPFaoh5S3Mx3dMt9VuWZD0ERVmdfDHpB9
KVsSJ43+zI5lA+MgC0ly3XHz9Iud5TIz6o9Lg4EnpzCbqJKmksUMxN4D0vzW8uB+
9mDrLAJAgyhNcEsfSNG+DcEJspx6cA==
=Xru4
-----END PGP SIGNATURE-----

--Sig_/ST4OoFXdpAP+5=cX8fhr9hW--
