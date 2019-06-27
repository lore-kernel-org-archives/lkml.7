Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED627C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09A9216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EeD6/xHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfF0Dfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:35:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfF0Dfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:35:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z5Bm0NqQz9s8m;
        Thu, 27 Jun 2019 13:35:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561606529;
        bh=GAQm3RdC1t9aLF0AiSMCPwSBzZp7uYJTumCcohah058=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EeD6/xHYFP4eehDtw6zMjdAhTBhU/u2+d1hDlxUjrzRFIyEASRngC08WsFlUo6VfY
         zVIZ+sN/Hk0LHeFmG45yD1fCCyh+3rU98ythZFMzJ/4nUrIN+IwvcQlYltOYyocLMi
         Z7X1+p0sqR5sWz6f13jrS/Rc7LWp2VSz4bvKNyZ5NNB7kPxJ7ibhYkf0P6MPRPApAn
         ohH9eQLZTju1ZO5HRsrJ/WahVNyGma87a7diEr+W/SYfP5DC2tJS71A7L4XThc7hhP
         z49G0MAefDfZeCRwl3Bj+c2FPJHbTx7PdClV9iQJkxUoF7Myz+e2zq2uDHfFauBxw1
         KOvrGSyffvf+w==
Date:   Thu, 27 Jun 2019 13:35:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20190627133527.391ed0a1@canb.auug.org.au>
In-Reply-To: <20190626212212.25b41df4@canb.auug.org.au>
References: <20190626212212.25b41df4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//MP+Z9Llcv8VHsmmv4T4QEi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//MP+Z9Llcv8VHsmmv4T4QEi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 26 Jun 2019 21:22:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Alex,
>=20
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> In file included from drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:25:
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: In function 'gfx_v10_0_cp_gfx_res=
ume':
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: error: 'CP_RB1_CNTL__BUF_=
SWAP_MASK' undeclared (first use in this function); did you mean 'CP_RB_CNT=
L__BUF_SWAP_MASK'?
>   tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
>                            ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1067:36: note: in definition of macro=
 'REG_FIELD_MASK'
>  #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
>                                     ^~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macr=
o 'REG_SET_FIELD'
>   tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
>         ^~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: note: each undeclared ide=
ntifier is reported only once for each function it appears in
>   tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
>                            ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1067:36: note: in definition of macro=
 'REG_FIELD_MASK'
>  #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
>                                     ^~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macr=
o 'REG_SET_FIELD'
>   tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
>         ^~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: error: 'CP_RB1_CNTL__BUF_=
SWAP__SHIFT' undeclared (first use in this function); did you mean 'CP_RB0_=
CNTL__BUF_SWAP__SHIFT'?
>   tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
>                            ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1066:37: note: in definition of macro=
 'REG_FIELD_SHIFT'
>  #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
>                                      ^~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macr=
o 'REG_SET_FIELD'
>   tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
>         ^~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
>=20
> I have disabled that driver for today.  Please let me know when it is
> fixed so that I can enable it again.

I assume that this has now been inherited by the drm tree (since there
has been no fix).  So the AMD_GPU driver will still be disabled in
linux-next today as of the drm tree merge.

--=20
Cheers,
Stephen Rothwell

--Sig_//MP+Z9Llcv8VHsmmv4T4QEi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UOX8ACgkQAVBC80lX
0Gw+Ogf/Xu+akNc/wMNACdscrFniFALvWRPZZpd1TNGFkbzX6BglbzbQeKxTS6Qt
sJg6CSPEwwlUezmoXyb4wOOFY+idiSEXdQC3B3MeUYOpirvAvM5kGKi2i267OKuB
QQ9y1oLFKpX7frtF8tGDl+FRp/rPOcFluosrA2lxTxTwLf7WyUbswunEA223adOh
Bbhfbw1EBNWyExV6UN/DJQ1sF4hYkqx5v8GK0f+a5fae/Q3CQH4oKFuO+LMPhNkl
mt6OhpG33e4MjZ5Cht1IJZpWTgk9LbmExxS/30LI/IYs2vECmvJ4yj0e3A3fng4r
HJOWz0oRx4eWTmz5yYOrMdxTbeA5jQ==
=2p2Q
-----END PGP SIGNATURE-----

--Sig_//MP+Z9Llcv8VHsmmv4T4QEi--
