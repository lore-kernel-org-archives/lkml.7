Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9550920830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tlyQcChI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCDAyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:54:11 -0500
Received: from ozlabs.org ([203.11.71.1]:46593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfCDAyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:54:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CM3b3gH2z9s6w;
        Mon,  4 Mar 2019 11:54:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551660847;
        bh=HjZKMoscNCwlCCpNo0TsoaW+rNGU5NMaf/Ven5KNgaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tlyQcChIZHCjHyDt2A/vUXXPzx0Ns9EZadP74wR3/CGJ7gly3yt1L6So3tqD7b2qq
         N00czX5ZtdKspJKfJGRLxOQOma4UToMELh3V+BPymKE/fVkL2JuHIr1obHqhRuF256
         p32Wrmk5A4q+18eh97jByN4AGd+TzYvABLfGQ1BKwKKf0SDAHyT21rk5odxUC/0lN/
         IkCj2gDO8cMhY7UTARssQTImtbJmsjD31x8t7/8+e0o7ORBLl0OzgksSyr942cvdAv
         NzM7wfIiV0tPqFRc9vONMRVCBdCGhuIIAheacYB6hvY7GIBh1tGk2APABv1BjFMsyF
         1BaxOPyi0cW9w==
Date:   Mon, 4 Mar 2019 11:54:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Francis <David.Francis@amd.com>
Subject: Re: linux-next: manual merge of the drm tree with the drm-fixes
 tree
Message-ID: <20190304115402.223de52e@canb.auug.org.au>
In-Reply-To: <CADnq5_PXqjcQeH1vh9ftpPfoCzD5SfdcXQSqAh2BPgrs1V28LQ@mail.gmail.com>
References: <20190301132351.6f4e815f@canb.auug.org.au>
        <CADnq5_PXqjcQeH1vh9ftpPfoCzD5SfdcXQSqAh2BPgrs1V28LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/r0Rs+tqKiKCUzr2xOLRXqYn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r0Rs+tqKiKCUzr2xOLRXqYn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Fri, 1 Mar 2019 18:29:58 -0500 Alex Deucher <alexdeucher@gmail.com> wrot=
e:
>
> On Thu, Feb 28, 2019 at 9:24 PM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > Today's linux-next merge of the drm tree got a conflict in:
> >
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >
> > between commit:
> >
> >   d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling =
in DC.")
> >
> > from the drm-fixes tree and commits:
> >
> >   8a48b44cd00f ("drm/amd/display: Call into DC once per multiplane flip=
")
> >   bc7f670ee04c ("drm/amd/display: Perform plane updates only when neede=
d")
> >
> > from the drm tree.
> >
> > I had no idea how to resolve this, so I just effectively reverted the
> > drm-fixes commit.
> >
> > I fixed it up (see above) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts. =20
>=20
> d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling
> in DC.") should be reverted and this should be applied instead for
> drm-next:
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5.2-wip&id=
=3D5d5f43c235d02e4d8e9d50d012f3b21f380486eb

Maybe you should merge the drm-fixes tree into the drm tree and apply
the above ...=20
--=20
Cheers,
Stephen Rothwell

--Sig_/r0Rs+tqKiKCUzr2xOLRXqYn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx8dyoACgkQAVBC80lX
0GwHKgf+MMoxME+moZkFUbI6XP7TWtwxqL646v3cBIvIP2NtYzdKEQgeP8QrFO0s
S0iQFKeDWGydbOrehG8nxkkN411MlsRQO6K9Uq5OCoUQhU+MnutgQ2GlsM4YW59z
C8gSRaMguBOD5Ppc0AWxnIpQXNJH4cPixA6kfDElADObpyMDie5UYVKDfi6rsu4u
E2fObc2x6MrWbURyXqGoPZ9nr841Su3ZeIsYL2M6uz4b8dOM0hyJRAG/fPIhAhuz
5D89TprjNXQgdPpE/VF5ULejd1Q8mTAgp580NKn/TLvtxAlJSHqEzHNvBmWiMxEY
xQbmuU9nlduR0AMpc4kFrKtkZ0RpIA==
=+dEB
-----END PGP SIGNATURE-----

--Sig_/r0Rs+tqKiKCUzr2xOLRXqYn--
