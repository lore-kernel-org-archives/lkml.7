Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC53C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56093212F5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZHGu9KxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfDYNaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:30:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53079 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfDYNay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:30:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qdNq59gLz9sCJ;
        Thu, 25 Apr 2019 23:30:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556199052;
        bh=V14iJdPhrORl8KMhPieoEv/H4hcKcbgv/4rYY9L4t3U=;
        h=Date:From:To:Cc:Subject:From;
        b=ZHGu9KxWwp57ERgRT3W/j99QOnWQdmKYpP9D4zhW+yn1sVggxpcIC9pdtSYWZ5nWz
         KwSxCzgNzeT+wmJquu39OxSaEL8P0Dwz5N9xoPfkUabHrlvdbPCF7u7+7q9fEjLVu0
         XWg7g1BSZpz8WNebCbldElgZbElJvrPBmT8Q53XMHb+9ueJRSJCetNySyHxYBuJu6B
         sOdZ8t1J35EfM6QE3ibuoGo6JujZ1AaGlec80GeMmgW6ADpIJFOxnEsu0HTFL2lLYm
         5M1XnRmdh5J83t0x2L30vUeA6RoROyIe5hW+fDAFdgg0Elbf/FvfXKDvHdZb8WfaXf
         eoSm9z34QYznQ==
Date:   Thu, 25 Apr 2019 23:30:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the printk tree
Message-ID: <20190425233049.7e2283b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Yyontrw5S2VclYYMUmXe8cu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yyontrw5S2VclYYMUmXe8cu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e43bb4d0feb8 ("vsprintf: Consistent %pK handling for kptr_restrict =3D=3D=
 0")

Fixes tag

  Fixes: commit ef0010a30935de4e0211 ("vsprintf: don't use 'restricted_poin=
ter()' when not restricting")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/Yyontrw5S2VclYYMUmXe8cu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzBtokACgkQAVBC80lX
0GwzZAf+Kdqa0CTbOnVe/SKI3EepZ2UY9VNLICynylv8/TmjgE4Shi4G8jo2+1rm
z/tuNRhW+EluAMupigRBJHqfsgMJ74oSXaAfLudjXQW16dkWCJ8w6d4zqvb58YFL
LL7qvquL3bO2YSgxT9D/Mb42JFtx0RXvsMSzQ8ME81sEEw7nRfrTiAjiYhnH8aQv
R8Oii3VToXX78TuGfZTGbR10tezKlUzNcUhSaTVGzlN0wNzFM2VVt3PNpcf31P6u
nbYNrhZq5hw1XH2cB7te3TbwNm2wqqGyzSi42QJWtnqhkGLVcppo3UF8A4dONTbq
Dgg3LuAXY3EhnTJNgumRNHO0zIdU8Q==
=vlVq
-----END PGP SIGNATURE-----

--Sig_/Yyontrw5S2VclYYMUmXe8cu--
