Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E65C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A205924670
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n8bogj3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgAFEsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 23:48:09 -0500
Received: from ozlabs.org ([203.11.71.1]:55961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgAFEsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 23:48:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47rjgV1ntYz9sPK;
        Mon,  6 Jan 2020 15:48:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578286086;
        bh=Xz5962zHc/xBsOIWAA9DOZF+DW37QgRJTdYhDW1DbQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=n8bogj3YMrr78z59eSX373xUtzKrFiTrvW9HHGbkptQ6cpDrZr9F2HTZsXhtZcsKh
         eqsi0ZfbHWlcTVCgjwhHz0ab7ZkEaYUSdEdvlb6LHsCnAMApngGGl7MqPHQstdiJAK
         LNXTb+NQJemuVQUNKT/bFTMfHC1YJNzyRxb2pSDmhwQvjLTpPvJngVemjtyAhz0pfE
         EfAW2y0HwRMytIRgtgMzMEAA1VEcr7guGdu2YVtTIznCrLUwZ9dneRfR3PdW/KqWcx
         vH1G5vghyQdiNhFg3Ixtm7DPbyP1pST3c6Mwl5Cn0N7nxMWoLDm9FIn1lvZqbpKR7F
         7K9WxrreyGnDg==
Date:   Mon, 6 Jan 2020 15:48:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Subject: linux-next: manual merge of the kspp tree with Linus' tree
Message-ID: <20200106154805.40c26d2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JNKVTg7rL1OwXzOQY8iTEX6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JNKVTg7rL1OwXzOQY8iTEX6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  tools/testing/selftests/seccomp/seccomp_bpf.c

between commit:

  e4ab5ccc357b ("selftests/seccomp: Catch garbage on SECCOMP_IOCTL_NOTIF_RE=
CV")

from Linus' tree and commit:

  589f6c054d7a ("selftests/seccomp: Catch garbage on SECCOMP_IOCTL_NOTIF_RE=
CV")

from the kspp tree.

I fixed it up (I just used the version from Linus' tree as that seems
to have been committed later) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/JNKVTg7rL1OwXzOQY8iTEX6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4SvAUACgkQAVBC80lX
0Gyu9wgAjWredaofrvxwFD982fzNyEhorZ+flFCibK5PvjCGDIIb3X8/NdGGCR35
VG25JBOJHx4w8dCGtgRLJjjFU4GpoM96NDDB2HNlsHGiuVqNp07YPtEKAbfYKftF
oRCcDLLn/wmiNMhXgysu8FwlGytKkdV/CHrb84yyK9SUphIC4Hpahl3VOEFWZv1T
fCeA5oFNTP+LmSMAOdobW1TgjxAZ0/WcerY6HsjQysvZdEJLiIbm80tlrcWRciqp
s7sTZMUeEkuEM5UvALY3GfuwX+GknowZZeogR1zYKZnx11BXbnHGvChEbQboeGMp
qQV/UraRU30pu8puiRTQO3hA1+OrLg==
=MTH9
-----END PGP SIGNATURE-----

--Sig_/JNKVTg7rL1OwXzOQY8iTEX6--
