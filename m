Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D586C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DE620730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ROxUo7Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKOXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:21:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35973 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfKOXVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:21:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47FDqt6wtYz9sPF;
        Sat, 16 Nov 2019 10:21:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573860076;
        bh=ZkAxY0i7tYEwLhuyfD/vlJjX37mGy/T4xfjDRbRWyfA=;
        h=Date:From:To:Cc:Subject:From;
        b=ROxUo7AbfzwcQR9q4sZDDoo2jp8E8FNqfo38NDzuwWuJ918MoYe9zH87RUbf045yE
         WPj5HqydDbb31nlg1tAFCg2LCGVNVJ+Cq3o33E6PENyc8tEzxIm/OPD4sikv6tdASW
         Gfv6XgF2xJ6nIbnw8SQqEmIDo/JgUNDcChtbiIUxsatojUcJNn+J87B/xNHnoeAFKL
         dscl75Glt9Bs5866LERGvmpMKvSNMh07+bc759eJSMuXMRIU3swZNV+vPVtJLVz2JX
         1aYVCLveok+FjhnlWGlN9wWksrThZJNtU/1r6N9qlp4syKYi5FqynPV7TxJPuonNTA
         mC8276u1ybWpw==
Date:   Sat, 16 Nov 2019 10:21:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20191116102113.649ba462@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qg0m8ljvQ5sgTdqX+66aLqC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qg0m8ljvQ5sgTdqX+66aLqC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b4011644b03c ("drm/vmwgfx: remove set but not used variable 'srf'")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Qg0m8ljvQ5sgTdqX+66aLqC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3PMukACgkQAVBC80lX
0GyxBAf+JTVRHzDkKWzpb51GjiIEajYJ0phjbsYp+qlmC5EnLupUNF3/4ssRCUNI
5wkNoC7z41tCuogkrn7k2b8oRPo9hIpCveKlEU5KoVxYYcRkOa451FNFYTHVdhhj
QzvlRb4Cn09hc8c77gJbOpOg8Qx7SuIMPOoc7igVNQ0ljoKb/amC7+Xu56hrCoIz
RaXubIRH+AufJD2zXOEhNJ0Mj5qjwz7YN1wVKPyZUb9icAIOjdzddzIOtiv8QGZt
HkVxBN4E3G0L4D4dVcAPu+Q9EQshSRWUATWg0Zftz29Hi63g0KU6UmARGrhyTeOF
NNTs1+UgdKQ3ACqFQAZadwJa0ZT63w==
=AWwR
-----END PGP SIGNATURE-----

--Sig_/Qg0m8ljvQ5sgTdqX+66aLqC--
