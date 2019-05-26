Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D2C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EC52085A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Qy+4nwkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfEZK64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 06:58:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfEZK6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 06:58:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45BcY86wXTz9s9N;
        Sun, 26 May 2019 20:58:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558868333;
        bh=SQrMuVmoa66E1VrCf9mHRafTDuGQ7fBOzb0ZaH25TPw=;
        h=Date:From:To:Cc:Subject:From;
        b=Qy+4nwkTuFJiQ9mIlV/Qsa7s6ya4oX/LGrLp+vw4scmYfAEZu1CyKKiKuAgrZq9Rp
         8TQNvYuKXTEffhgWi2DuX2gvNeW3Cyme9HMLmnFnYWrInp4/lsvM5bLymZ6+YuyctU
         KShL3HU4RZjzHjdefoWTJm293eMdH9ZMcIvElBKPuvhLGfLSgvvp7lgqNmA85fVxsS
         14R1zBOAqVeQVH9GhXY7wWkzecee93yD6DSjNcUfNQ0bOuth2WLANcx8LMLJie8amg
         aG73ezmU7WpV6Bc0btkQtmjPps3O07SyNeFHqPJeSXwoFYcTJw3I8N0v3J+2QGtETf
         QAWdoj64Ib1SA==
Date:   Sun, 26 May 2019 20:58:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the random tree
Message-ID: <20190526205851.48679169@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9TiOUxuDquE3YUtIei3ko7p"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9TiOUxuDquE3YUtIei3ko7p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ted,

In commit

  58be0106c530 ("random: fix soft lockup when trying to read from an uninit=
ialized blocking pool")

Fixes tag

  Fixes: eb9d1bf079bb: "random: only read from /dev/random after its pool h=
as received 128 bits"

has these problem(s):

  - the ':' after the SHA1 is unexpected
  - the subject is usually surrounded by '("")'
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/9TiOUxuDquE3YUtIei3ko7p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzqcWsACgkQAVBC80lX
0Gy5nAgAhHJswXVcZV94a/e4bTys4MhF6LQsBWvb6AvWAcLBt3ht4btH74KxINjA
0LHdHnQbt9+abudMI0fhoVd20PCwkHvDAoAwjR1al2YYGOoCBNLPyFrNNjPK026F
j12m+iRoyVKtUi4IgyXKp0iWLW9WqZVGkLlxmdoNzsXgKfFOl/0bkMD9O03zkzyf
1qsSl4M0frgNtjW5hJmMkNv1+62yBQJC1Bm1ZLqaKXq1sA6icVqc/VENYiQ9iYCl
gkmwnTap+T0oaJnmb837qwRr+JphpCKUgiQxPaN8pT3CBqpbhfYLM4TYEjovT6SR
Sus6G06+48l/qc2H1TK7L5H2hxXk7Q==
=xa14
-----END PGP SIGNATURE-----

--Sig_/9TiOUxuDquE3YUtIei3ko7p--
