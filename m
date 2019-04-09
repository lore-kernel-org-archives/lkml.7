Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B4620883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="B1bGbMzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDIBeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:34:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfDIBeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:34:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dVFJ17qDz9sRC;
        Tue,  9 Apr 2019 11:34:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554773656;
        bh=7VbFVRSjoZ3yxJA17E521x+1KnBtls59+zeZBU2K0Jo=;
        h=Date:From:To:Cc:Subject:From;
        b=B1bGbMzj+lomGzKB9o02rDw32vbZ8PfcdRgvUU8n+Ov1kZLJM/aLGC3EhDKiKHJsv
         tIrPfWUKabYEiGd8gHjw1UOLKWN9NCsId3ubQ0OB6XyHLJbTcYa9RxczpaQlVLYC8L
         53oglBW6V0fGH9DWjAIUxApyCH9hyHjM01auKpqHa8rcbDPa1wWJ9oSR93RTsdJU17
         J+NZD9LTxTvmsl080li5LOgVwj8G6+5H8dmsr7iD7VHhY/6TWy65riBbyRrk+DwaqG
         mMFmyFSwOkzLErupDxij4UY5y3OTlpY4sdfi1EmkDQGf3Nhk4lHpjaxOeWr/R7V77p
         JVNC8FbM/yRKw==
Date:   Tue, 9 Apr 2019 11:34:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190409113410.3d2a8afc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TrW1RSpeAuZFW0sWw8mGVis"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TrW1RSpeAuZFW0sWw8mGVis
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got conflicts in:

  drivers/gpu/drm/cirrus/cirrus_drv.h
  drivers/gpu/drm/cirrus/cirrus_ttm.c

between commits:

  aa8e2435b3d4 ("drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant")
  7d1500f9fbfc ("drm/ttm: Remove file_page_offset parameter from ttm_bo_dev=
ice_init()")
  bed2dd84212e ("drm/ttm: Quick-test mmap offset in ttm_bo_mmap()")

from the drm tree and commit:

  ab3e023b1b4c ("drm/cirrus: rewrite and modernize driver.")

from the drm-misc tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/TrW1RSpeAuZFW0sWw8mGVis
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyr9pIACgkQAVBC80lX
0Gx8OAf+P9Ywia+FIV6m/bOqBgRyK5oUg4qTRQW89r0wv8sOHU1ThW1w7ZDn5CJx
WvhZNV4K7nzvt3RIzR0dJBDO4dF5KeK384AZI3KwNQlWhPXB8I+pnH0d6g8i/PlY
af9JaTvJ2nopcQ8zc/6TqkUcIMMb6GDgHeta7PfbZok3UaaSy0x/wGTWZR4UBSZh
2mFZ8o7dtiYGBHR0uUFlVl5/C2HQvti6Unsosk/IaEZ5r5CMJ2Wq7hGsb9cd9PBd
7/ym6BzYSTgb1nqR6rFJSGQ0zyUlUIi6kZVym9MS2xbfkmjPEJr/1DkEC1oQL3/U
oaebP3oVAdSiYj6lGEdNc3Xxzoymqg==
=iCRq
-----END PGP SIGNATURE-----

--Sig_/TrW1RSpeAuZFW0sWw8mGVis--
