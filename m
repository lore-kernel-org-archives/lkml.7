Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC8EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E7D2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p0q2a5Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCSVYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:24:07 -0400
Received: from ozlabs.org ([203.11.71.1]:38475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCSVYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:24:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44P5dv744Rz9s47;
        Wed, 20 Mar 2019 08:24:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553030644;
        bh=hI3BoP2da3uLkkrhAANQQJUWI1Nceb6fy4c6gXF2p+A=;
        h=Date:From:To:Cc:Subject:From;
        b=p0q2a5Lzvl68EetzZUds7fe0yYqV2UXuKt7UFq/mrY5gV4laMrYFdhKRKDjJJtAOk
         o85WGp+5iHGPuPTtt+kiuWJufyPvtbsmbMUrBC89MFivePSdpqh2EY5xr/3SVelqtk
         YeOW5CUZ0fJKLKOEzNAD/8gwRbK8J68FzxKULiQ2gzfVVFLElf1Wy8+/Gx9kEOm82T
         wBc8Nuuvc4nl7oiL4cC0G4PLUK6axZrrDn5VuozmCaa8zJVP5UCI2Xajw6CIHoIUkY
         3duQ2pL8eAdDKoYT39w0SJNyxtsXtBTodFbF0mNVWc+mTgvkoankh78TQAtj8ed1Yq
         V0lSQ2pj1n2xQ==
Date:   Wed, 20 Mar 2019 08:24:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: Fixes tag needs some work in the gfs2 tree
Message-ID: <20190320082402.5af7812e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dJcu8/ISlMk0rINfVKju5Rq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dJcu8/ISlMk0rINfVKju5Rq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  31b13f0abfa6 ("gfs2: Fix loop in gfs2_rbm_find (v2)")

Fixes tag

  Fixes: e579ed4f44 ("GFS2: Introduce rbm field bii")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/dJcu8/ISlMk0rINfVKju5Rq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRXfIACgkQAVBC80lX
0GzccQgAlFsa8NGGfgojG2MKSN3pjdgxlNyww8zmdJDQ5mkJwmBOJaVJ/UxZKGLL
3zpMF63AfU9Ynp3zlaCh6J5C/2f/E+LfBv5SxPWMvpMneF22HVmHCFI70VI2FMVm
wBvduapkUAPtmHsV0C9sDSKSV4CaDsD1SjAAuDj8E0QSMi9R08YzObd/JAHhXg+B
QRWndVx1yxHaEtA6CPuelK/WjkD5OpnxTnTAI/PhEocYbhKhqHyeKyQq5QqRggtB
YOBUsLZgMuzhHyWN/JquqqldRAEyHZ2Gr7BnwkMZoILrezRTzaozMeHQhnjONG8K
mKPQP4rOWzTSDIKMV+lLEG65+zO3Bg==
=DKaH
-----END PGP SIGNATURE-----

--Sig_/dJcu8/ISlMk0rINfVKju5Rq--
