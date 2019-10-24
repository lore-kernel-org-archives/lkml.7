Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FEFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BYZNZJ2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfJXUOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:14:06 -0400
Received: from ozlabs.org ([203.11.71.1]:52295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfJXUOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46zdk05jJXz9sQw;
        Fri, 25 Oct 2019 07:14:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571948041;
        bh=UUYetV0LKgI0RE0l7j/6nNzdo1gpldudIgqEPAgXFqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=BYZNZJ2qKuk+b4s+dH/9kTDl1xZ51tQ1FDwlrOz02RLg0wv58muAOe90TFQ0QGO6g
         40cvxlMshesgleRySd/4T5j6/ksE/9dTr4qHfQMpo8bS7E4VN+8H8L4e70uQYbExsQ
         7rVHouWr67opuxCy5TdybdedV4NsYT/DkZh7pjzVGKr+LWJiZ9fsEaDOVeU71up4J2
         byHK+GTTK2irRRQOEw6u5Mdg+vOZF/EMwzy7j35STiXWp4J+9XMu6LA7EwsjzG7Heh
         LrcUbDcU5p/7VGMB54+EXX9y/CZgTbf5vIZ5hecigHjt/IrWc2pg6C9fuJyuZm8eOP
         hzaeNfvbqvo+w==
Date:   Fri, 25 Oct 2019 07:13:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: linux-next: Fixes tag needs some work in the cgroup tree
Message-ID: <20191025071359.60a90ede@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ncflRXnOG3rcQKJG+7ciuk2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ncflRXnOG3rcQKJG+7ciuk2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a713af394cf3 ("cgroup: pids: use atomic64_t for pids->limit")

Fixes tag

  Fixes: commit 49b786ea146f ("cgroup: implement the PIDs subsystem")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/ncflRXnOG3rcQKJG+7ciuk2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2yBgcACgkQAVBC80lX
0GzVAAf+MQwQgOI4z9UkbnwQ6pCwK05ylGEgwpChILEMK2IQuhlw4JbhQrNJUyOc
BF6yAogphR6LzUp1e+YOM74s0ut5vAKYg0syb3yZrCxQeOb9u1rumbtYn5dKR9+5
FNQMWkojl4e/OysJlc5Bb1Uz5TGF3jZEl+A7SM8vmO+/RPxB2mZkoard1KKpc4T0
2bG9OaflOiLA4f0wbqHw4H1y2uJ/0fpOgIoJl9071lBZNapkN26ottUafc+TGP5q
cI040GGP6AGmoKsF9eFBfcz+Hmpj06DawFq/5VnfaXL2SX8xzkiVlVtn7+vHTAQq
kchboAOJBfhHNeLhpydYldPk33X8FQ==
=70FK
-----END PGP SIGNATURE-----

--Sig_/ncflRXnOG3rcQKJG+7ciuk2--
