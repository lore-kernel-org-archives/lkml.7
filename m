Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A27C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479D521852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KqQnIs8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfGCVoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:44:01 -0400
Received: from ozlabs.org ([203.11.71.1]:58149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfGCVoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:44:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fF3y2p5sz9sBp;
        Thu,  4 Jul 2019 07:43:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562190238;
        bh=Ta/mVq55yYgD8k96u5P7ESQsk0sEgaqQnXZMCcskANw=;
        h=Date:From:To:Cc:Subject:From;
        b=KqQnIs8MZSmiIczpAGFiPCT7scPa7cBLa+37s+NC/rXz1zU6d2dIA/JZBHxLsz7dx
         gubhrS6DOByf9e0mR6L2QiqukcjMHKDQXmQQeNHR9qE77ZtFKMhKrU6XIsmKWk/RKO
         b3an3+cwbXlSecOiTdpsX48FgyeAnC66zP/DEvSidbOh9hVFtggvvJKwyF4agzP2FN
         DLrx3EacuxBf1Veh7iPel/I3BR+KJG9gSksMld+YT7Ul2JOttg2EqdrubFzB3rPZIa
         5cKdfNCXBLQy/RbL+PPexb7JwwtY/UuK8jKpN0auvhWvPIA6/1kNbApOPs6GnYz79Z
         S6zfeuIjJuCcA==
Date:   Thu, 4 Jul 2019 07:43:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20190704074357.5dc09442@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MW.9nop8aAmhk0S2wC2=atR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MW.9nop8aAmhk0S2wC2=atR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  841e58962647 ("drm/amdgpu/psp: add psp support for navi14")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/MW.9nop8aAmhk0S2wC2=atR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dIZ0ACgkQAVBC80lX
0GxUVQf/fzP7U+28zPbMEJMks9RAQLAkXGOA5iuESXk1txhfJUCO9wyTzI6lu68u
TEnYJNvmm4v4Cqh5LZkBpR1MEBRg8KDXZctzUmPPHraLLVRSjWjYVNCmY4Cb5ZGS
S7OA2B64EmWb7Lem8cJXYYVB0vAhueRTnPUfi+jjjLCMZtn4a1FzLlYNIAwLWmeg
DH2uxUNNGTClGZTD5U4XUsVr5DJ2jSKvzOu8JvAEAJEKc/gYXjQnGs0eLOtRO5iG
8tWBEGRqD7D5O6qDxN/p5d1/x9F6VAwER1PP4JCKTTfLajtY1j9fLoh/N366lyRd
SVmYWulk6WHDLKvV3iO/ytRCVBF49Q==
=EH5v
-----END PGP SIGNATURE-----

--Sig_/MW.9nop8aAmhk0S2wC2=atR--
