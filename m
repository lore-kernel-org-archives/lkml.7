Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF804C4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD2D216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bD78ihd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfGEKy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:54:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfGEKy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:54:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gBYY0kwYz9s7T;
        Fri,  5 Jul 2019 20:54:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562324065;
        bh=7PEMhm7NSZ8PvoIzAZZwmzsKh78GMgXvg9y4/fhW+Tc=;
        h=Date:From:To:Cc:Subject:From;
        b=bD78ihd5AksKv3isX7yDX8H/XGiqbR6Jc22dPx14E3bVuXXw7NwW3HeWs8193royp
         +4UT3Jis/oOR8ztbNzhZgr+ZGRjLlgZNWIvEBuQvDbPSSFztb+F5iO6Ha+1gHBAtS+
         3H5cKdtDBYbcBPgvn+/sBk8zbc/QgESIoZ90A2ZOq2oKJZx2Y7EdWdF+XOKkIaLH4I
         Mpepbn1T2LWx32S0h7Te36KAaZMKyf8iUf2EmhanXsQT6/nfIremHT/VUwUQAVs9mC
         vX8IMJtN8ft+6ETeV8CZDzxZGBAIyZl3MDf8dmCxsiaI68mUfI1h6wiDr7qqh1VIXE
         n+MEOoP+EgAKg==
Date:   Fri, 5 Jul 2019 20:54:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: Signed-off-bys missing for commits in the vfs tree
Message-ID: <20190705205421.10846e0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k6RMSFLEVAUy55oaR1OQv0q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k6RMSFLEVAUy55oaR1OQv0q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  408cbe695350 ("vfs: Convert fuse to use the new mount API")
  0733dcbaebbd ("vfs: Convert orangefs to use the new mount API")

are missing a Signed-off-by from their author.

Commits

  023d066a0d0a ("vfs: Kill sget_userns()")
  ea8157ab2ae5 ("zsfold: Convert zsfold to use the new mount API")
  31d6d5ce5340 ("vfs: Provide a mount_pseudo-replacement for the new mount =
API")
  c80fa7c8301c ("vfs: Provide sb->s_iflags settings in fs_context struct")
  7cdfa44227b0 ("vfs: Fix refcounting of filenames in fs_parser")
  96a374a35f82 ("vfs: Convert nfsctl to use the new mount API")
  b9662f310354 ("vfs: Convert rpc_pipefs to use the new mount API")
  1a6e9e76b713 ("device-dax: Drop register_filesystem()")
  7e5f7bb08b8c ("unexport simple_dname()")
  48b48750c3f9 ("zsmalloc: don't bother with dentry_operations")
  985f4044871a ("balloon: don't bother with dentry_operations")
  8b1e058e0f52 ("cxlflash: don't bother with dentry_operations")
  619a6d167b29 ("cxl: don't bother with dentry_operations")
  fb9273f2c10d ("drm: don't bother with super_operations and dentry_operati=
ons")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/k6RMSFLEVAUy55oaR1OQv0q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fLF0ACgkQAVBC80lX
0GyCagf/TzPLv6Xwx85byFLbbNGsvchTr/ojssjlVfZltov0cG56hdkQmERg8emy
icADW4JJYR0tRVAzJ/YCLsxivQHMqfDWneYZNTH5KJdat5xiTPSRMNzuH7phQO6d
p3wER6TwY3mBimEPzUZYYa9MILSCO2VxayBf9mu2SAirHjdXAIrKmONhriMqmYlp
eFlZ+BHrcWWSd0mgHxGUxzQ55RLCBJIMjRcSMlEduElljsUTsX5dE7+E3Cl+krie
qS9t9ngo0xvXUNhdBlLM47PkBg3C3EQIFRt9f53hhrsMn4ujLkWiiI4Md4KRv182
5sgnHFrWCuWnzTciqR/B63ijJJAm0Q==
=UgYS
-----END PGP SIGNATURE-----

--Sig_/k6RMSFLEVAUy55oaR1OQv0q--
