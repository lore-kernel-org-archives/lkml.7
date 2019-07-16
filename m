Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4549DC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4472171F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KVIzKczo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfGPDDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:03:47 -0400
Received: from ozlabs.org ([203.11.71.1]:41093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfGPDDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:03:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nlbM2pCCz9sBt;
        Tue, 16 Jul 2019 13:03:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563246223;
        bh=nq1AUHsJilqahhs7L6s6j+CXLruIVemitVRLJmPFQrc=;
        h=Date:From:To:Cc:Subject:From;
        b=KVIzKczofy1e8meSICHPRwsIYDpibO85SB35gR9q98wuoyDv8JQrdFenrqRHD/G31
         wjpHwHGFaZmfDdSBgJtyyoT+XxVuNpBqH44fK23OzopGRUMsO3IgEfU2hD1DP1zyNE
         RYMcERDk15OlE+1fPHsYYQqbJc6o3x+GnRVw1GZK9TDJkKpioAJqTZ83utki/k4x8Y
         XsDcOcObPyCtH0FjuOMiNxKB8ZnWz9fx43M80x0k6snflkkDFhuqAbSS/FsefVZC1d
         UPeH5/gLbaFu3js33BKqw07ilJ4jHELyMKeytWAuyBid88dGG57SB/nOZbDvNiOJKK
         MRQ+KkxnsTXtw==
Date:   Tue, 16 Jul 2019 13:03:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the ntb tree
Message-ID: <20190716130341.03b02792@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cTsYyZ8h2iTZsMdZQarLg/K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cTsYyZ8h2iTZsMdZQarLg/K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ntb tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: could not open /home/sfr/next/next/drivers/ntb/ntb.c: No such file=
 or directory

The only thing I could see that might be relevant is commit

  56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules=
")

and some others in the kbuild tree. Nothing has changed recently in the
ntb tree ...

drievrs/ntb builds a module called ntb but there is no ntb.c file.

Any ideas?

--=20
Cheers,
Stephen Rothwell

--Sig_/cTsYyZ8h2iTZsMdZQarLg/K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tPo0ACgkQAVBC80lX
0Gzn6gf9HJlCinilJIQsR3fkTgS8aCGXiAw/tla3nTkmnnkGJXG9et4Y+3ARzj1p
7kqiIc2FcGes8uKYU0jn6wG03HTuh4aoYNeVBnPocPFGLjUeuDR5PZUNPBG5RZzs
F1SgIDwi6BK2j03rlhb2vlKAYl121km/ZREt9mUhu2WJWBMw+crNWVGvHK17sWCe
cgRG3F7JFywlYRb7BY16GPQ0dR+Pv5i/lHjHdcLxVyRf7O/jQFudKMfXJQaVZeDv
M8dBcBrkaLuUf46ouwcfZu8K8j9Y/KnlTjld8YAoi+wpmxfppY5zGmMMDr9Wsqdi
Cnfn+9ZmIMLYBJzE3zc6Y37ICC6HCQ==
=EAmG
-----END PGP SIGNATURE-----

--Sig_/cTsYyZ8h2iTZsMdZQarLg/K--
