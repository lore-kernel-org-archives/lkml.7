Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0032C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6522343A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RbnI8lhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfIAVjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 17:39:13 -0400
Received: from ozlabs.org ([203.11.71.1]:55427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbfIAVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:39:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46M66k2S9Sz9s4Y;
        Mon,  2 Sep 2019 07:39:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567373951;
        bh=yMQW3qUmXepccfDxCBertD88tyqdGjUJGx5OSU+KL4c=;
        h=Date:From:To:Cc:Subject:From;
        b=RbnI8lhu/qbIQOOTFGAoHeo/N1pocbzlTRuMA9O+g55AXwiEZsqSeqb0bUmWOJyWt
         N8VLJjoRTHnlyuRr5gxBzhJQxvy6o2yrQY2dHi6cGfxzW9Zx069Oqk26XLW//J7MUc
         YhS7zWDZdMBiRFXhwkJipwZZzn6TNIJHv6e6ol/MRQFW4IsoCYkL4lB7EsdhpAIzCk
         FxTVDEMNz8KW8ceuembRj/8+E0wXFyicvU43Nrrdha7Wn/CtOOD82DxuWmk0UN7ssm
         8OOnjFhVpYfS1JPUnvtgwVx5QQL83itRr4BN/LTiuR/lWTRDw5+4hDyZUuxPnfwfGp
         vhMQ+0FRuMtTg==
Date:   Mon, 2 Sep 2019 07:39:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>
Subject: linux-next: Fixes tag needs some work in the kselftest tree
Message-ID: <20190902073909.7fc3fe5e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lQuXVG845SLzv5YTftfRu/Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lQuXVG845SLzv5YTftfRu/Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c321d43b8da1 ("selftests/seccomp: fix build on older kernels")

Fixes tag

  Fixes: Commit 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")

has these problem(s):

  - leading word 'Commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/lQuXVG845SLzv5YTftfRu/Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1sOn0ACgkQAVBC80lX
0GzO1Af8C6MuqWMq3qv3Nyko8iwjoWqVqJigFt/sGL5mbco6xXi7dBCfvaO/ZSNd
s7PQVUMIXAskdQDQNd6Bj6gqsOybF8+neJW9m40BWy9NefvRlAkFP2+tBkJkVyh2
XxaVhLDzrLmHY5oGR4CbWZpw0n2vUfn23iYPpuFtzn+83Dc1hnigoR/bsujZcvWB
9jRBZ26z2b7GHi7AUfWkc/j3NTzH/O0NfCf5kUZg5m/3BA+jaIkilOUviMK6dADB
K7T2H4a6irMpg/2z8TStp9BL6hWl/7RcatRSuK8zmj497CDaxPCBZxSaKpNKeGr0
r6EZ85hh88b0jjzOyvJtb6XBTbFD5g==
=pm2Y
-----END PGP SIGNATURE-----

--Sig_/lQuXVG845SLzv5YTftfRu/Y--
