Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC04C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5EE2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H7CRyOQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfDQVrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:47:05 -0400
Received: from ozlabs.org ([203.11.71.1]:37259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQVrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:47:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kwn04CzFz9s3Z;
        Thu, 18 Apr 2019 07:47:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555537621;
        bh=OJaecB3jUo/kGVNYHwnFI7et7SAbUrdJ87EpVGg1QsA=;
        h=Date:From:To:Cc:Subject:From;
        b=H7CRyOQ8qNK8Yey0VTE1C+eT0hVx0wm9qV7q/7L/mWRpfZeyKlccTLur82mqmPEuU
         tjhdZjV7qY+GktkQWN99v/2JeeV6kNDzuidSxwqw/BLXzBEtkHqYukrden8Pt8laGz
         qRrWfNkh5TIfo4fkHuZGiXMQo2kdE95thsidlCDDIIBqEqYK8xGgD26zi1wQ8wi8o0
         TAgMV7X3i2++jG9vej49T5s9e96RcQpfjWRYZKPz+2cC0CxHDs5UaQlGUWEmDxhN7J
         yOP8i8lBd3jX5R1cdoBwX1zp338N6nnMJRSBDbMBKnrjotUIzR32m2vpyuSjAsi1rP
         HSHxZOjRVG6Dg==
Date:   Thu, 18 Apr 2019 07:46:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20190418074658.541fcfd7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XLXTcL=ylQN8SHPoU=W3Ai+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XLXTcL=ylQN8SHPoU=W3Ai+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  453393369dc9 ("drm/ttm: fix incrementing the page pointer for huge pages")

Fixes tag

  Fixes: e16858a7e6e7 drm/ttm: fix start page for huge page check in ttm_pu=
t_pages()

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: ac1e516d5a4c ("drm/ttm: fix start page for huge page check in ttm_pu=
t_pages()")

--=20
Cheers,
Stephen Rothwell

--Sig_/XLXTcL=ylQN8SHPoU=W3Ai+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly3ntIACgkQAVBC80lX
0GwJFgf+L1fNt2DVdQGwvFYD1E2YdRwApLXSPHx5y4mAeuf96WDsDcwTEnSBucBe
DLMF2YxsjfLBp/P/y6ZVm8mx7MdzGlUTapfrsh92tK5WjQsl1R6EiTGDN+2Wc3Fw
Ykv42awjZmUPB8jZoAeAW5BLpdU+0nv0z0ru4r4yYlQboU5Hc6R3EAVTRpiGFcfO
h/8TmuALnW0M3qBFjXfHeHMJLW9e6+4Yyc+kllo7/0mdXYkLDAPc1RZyjRArQd1y
z0QfhifzC16rcFCugT1olN4B2QMBMECwSLfoa0T7Xey/ktyINbzA7Afu1u90UwQ8
jqw82NLoVGUmSCLjazQJccDsdVwF7w==
=ETlg
-----END PGP SIGNATURE-----

--Sig_/XLXTcL=ylQN8SHPoU=W3Ai+--
