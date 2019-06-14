Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D26C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3DB2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TmdQYMTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfFNLTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:19:35 -0400
Received: from ozlabs.org ([203.11.71.1]:32973 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfFNLTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:19:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45QJ6D0Sp4z9s5c;
        Fri, 14 Jun 2019 21:19:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560511172;
        bh=uZ3RAGOHsQDifx+zrw9Js8DEAlD50ILUiOwesbXlfpE=;
        h=Date:From:To:Cc:Subject:From;
        b=TmdQYMTv23JCFVjh0jBk8o7zQeyAb8qWAMVIwS7ul2voArQ4EECmF1Xp0fN8U+zp3
         fQkApzx5aVYlEPJ36NLx/r+ueuVYGujRY2LiQzXpFCwN8hc1mGVAnB9mJlaO7N14cd
         i1zIROvVTgH1g88S/QDIrYg+BdjrwJKxnlUR0A34D9DGxA2mJ39hzwEJYamDuvvADH
         r8QFO7BZTngsa6XRmhoFiM64RAlIp8lOd9pKHzqK+zoYdY1PUvP07u7YT6HG8mJ96H
         L0gRKWH+KZUt1/XEXyndfltRrOjPhEYZsaLMdGJ0wySbYD/wmqvSy1t57PdNW6satn
         nuI0HwD3v3qGA==
Date:   Fri, 14 Jun 2019 21:19:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the thunderbolt-fixes tree
Message-ID: <20190614211933.25c1b792@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z.bdmrdMD1yR5mO_Q8AvQhX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z.bdmrdMD1yR5mO_Q8AvQhX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mika,

In commit

  e00367a43c56 ("thunderbolt: Implement CIO reset correctly for Titan Ridge=
")

Fixes tag

  Fixes: 4630d6ae6e3 ("thunderbolt: Start firmware on Titan Ridge Apple sys=
tems")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: c4630d6ae6e3 ("thunderbolt: Start firmware on Titan Ridge Apple syst=
ems")

--=20
Cheers,
Stephen Rothwell

--Sig_/Z.bdmrdMD1yR5mO_Q8AvQhX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0DgsUACgkQAVBC80lX
0Gx+9Af/ek1HD2otkBRS6n9j/qNHooKsOpWbzV1fsNAemXkhHRWD1fBYUdOfDQBU
a86EF+ugdGhN1Mbx0Z5Dua0qaEaWeOGugCjhNr4a5QiAp77vFt6I7yq5ejPApcAs
HiuXpPpT7alZ/CP6nKgC+HN7pQG5z7FoPO0d2ag1N3zTmRdPRI3PFFgNG4cVz59g
ictQDPPd10QozObuOWhG74Cihj+4WHZYDjlJB+iBCx3TWcrSWe52qbC2qxr+cnUQ
638U63d0lISzImj9jFNGUuewDLG/3DUer6at8M0GY08a8+t+uEp6Ems8pZmxvLaq
05Qdw3J8njtjlEnKVoTdRjszmPT7vA==
=mVJ1
-----END PGP SIGNATURE-----

--Sig_/Z.bdmrdMD1yR5mO_Q8AvQhX--
