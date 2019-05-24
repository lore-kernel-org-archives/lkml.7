Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EAFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078520856
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NIIGNOJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbfEXKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:16:24 -0400
Received: from ozlabs.org ([203.11.71.1]:60383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389776AbfEXKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:16:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 459Mhz2bNDz9s6w;
        Fri, 24 May 2019 20:16:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558692980;
        bh=0rbLBe4DdXQuMQ0keJlprRSqPbxjvidcL65fCqgV3II=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NIIGNOJk3RwLRRRKCgyIiwXb0cNwpe5QczHWAsRHYPgdA+O5KXtVkxEucoYJN05kI
         zz9xVO1WmQ+2cE65XbVhQrlb/aYHBZs+Xi9Xv23HwLyK8Oo50WRKjR4xBlvTNc6nAR
         N4zo+koEd+4V2p/oCIxaneet5aNtlqZw2L6dnahMp877VWZZ8YxbJYtGvMq/GCuIcB
         04y0wkAUEizF3VxxY4woUoV3lRXh/GXRYX3qDedd36dqfCLFddGDXBRJ48b8fovpRD
         DQ7DgYKpZOnrq+6/TC1NSKPtWyHOuCvWMlWrNB4U+r7PU3vFti/TbM2wNDPNxtsIHz
         MWQZzliC2nHag==
Date:   Fri, 24 May 2019 20:15:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: linux-next: build failure after merge of the drm-fixes tree
Message-ID: <20190524201548.2e8594a2@canb.auug.org.au>
In-Reply-To: <CAKMK7uGSfOev71DKF+ygRjU0rMWcrW3rL7-=Xhbwdm9STUWntQ@mail.gmail.com>
References: <20190524082926.6e1a7d8f@canb.auug.org.au>
        <CAKMK7uGSfOev71DKF+ygRjU0rMWcrW3rL7-=Xhbwdm9STUWntQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rSQC7uUY/cTRnE+r_IeEC2W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rSQC7uUY/cTRnE+r_IeEC2W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, 24 May 2019 10:09:28 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, May 24, 2019 at 12:29 AM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > After merging the drm-fixes tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In functio=
n 'load_dmcu_fw':
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:667:7: erro=
r: implicit declaration of function 'ASICREV_IS_PICASSO'; did you mean 'ASI=
CREV_IS_VEGA12_P'? [-Werror=3Dimplicit-function-declaration]
> >    if (ASICREV_IS_PICASSO(adev->external_rev_id))
> >        ^~~~~~~~~~~~~~~~~~
> >        ASICREV_IS_VEGA12_P
> >
> > Caused by commit
> >
> >   55143dc23ca4 ("drm/amd/display: Don't load DMCU for Raven 1")
> >
> > I have reverted that commit for today. =20
>=20
> Seems to compile fine here, and Dave just sent out the pull so I guess
> works for him too. What's your .config?

See above "x86_64 allmodconfig"

Looking at it closely now, I can't see how that error comes about.

Ah, in the drm-fixes tree, the definition of  is protected by

  #if defined(CONFIG_DRM_AMD_DC_DCN1_01)

which gets removed in the amdgpu tree (merged later).  So I can only
presume that CONFIG_DRM_AMD_DC_DCN1_01 was not set for the build I did.

config DRM_AMD_DC
        bool "AMD DC - Enable new display engine"
        default y
        select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_EN=
ABLE_
COMPARISONS)KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS
        select DRM_AMD_DC_DCN1_01 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_E=
NABLE_COMPARISONS)

So maybe KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS are set for
allmodconfig.  I no longer have the actual .config file any more, sorry.
--=20
Cheers,
Stephen Rothwell

--Sig_/rSQC7uUY/cTRnE+r_IeEC2W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznxFQACgkQAVBC80lX
0Gypwgf/STyYQBgEHIh//OujCBOU8bO67LU4z2tVmUbYrxl9cEokB6gPMzl8RtLv
frnLT2kR5tQQ3qgB4uXALZixuW0cttJE/RSagDVnSMApTsORyTYAQyAhlKUg+QNx
w8AQe5BvPCEEWwwuhFJBNo0Fm+ETu1AzgeAyrfEZtPA5/PElaBz/kA+BTIP1ABeU
hxHFc+q/Zyu2eyVIxQRBrpg+A8SzyIC5iZDaASjz/K9M++HQvVROmel0mUeiVlam
yfyjAd7aONCgmZNtbf02QVomIb9tHTdTre3tMIjiGfwsDkEGFoCDvMGX7aAZtfl3
0obMRQylr3KYFRTQ78iR9tPibMfNVA==
=rRUW
-----END PGP SIGNATURE-----

--Sig_/rSQC7uUY/cTRnE+r_IeEC2W--
