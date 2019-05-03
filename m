Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F245C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FC22075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nJlpj1sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfECI73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:59:29 -0400
Received: from ozlabs.org ([203.11.71.1]:42401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfECI72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:59:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wQzx5SLrz9s9N;
        Fri,  3 May 2019 18:59:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556873966;
        bh=qkMJzzMTC/jMe7vLUzf2DibHNWHnxCWWsVr+bhNj4YI=;
        h=Date:From:To:Cc:Subject:From;
        b=nJlpj1sr5GfUlSYUQU6RBBxkCGvTsf0kw0Wu3H9/j7KBeme1ZgPKGBv9Hh4jxdeWs
         ej4HZMZPTdzMei9cX767tD9akvpUpK5/5JGuU/PzkAPeGFpMsAqu4vwVumTaEADZar
         PerDbS8QmIuWUpAX0OP18d6lDYe8dmO5fh/VISgy+wUxB0jF+6kE6rmwaBU/7hMLmV
         8sMDKRhPa7fYbEdtIiqOYd4HHHkdRaKd7z0QkgcoohOE9fANev8WgaJ43uskgtsN9X
         DyUTPlhKsuHA/T60aBbNJMG5/R3aSx+CGuZa6YpJMwCY0yS+4BEZ2UXom0xeW4Szjy
         Tm0NDTYBHjbjg==
Date:   Fri, 3 May 2019 18:59:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the mips
 tree
Message-ID: <20190503185918.7b28aa0d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xsu/4eVFbq_pNGCen_CtTev"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xsu/4eVFbq_pNGCen_CtTev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/mips/kernel/setup.c

between commit:

  b93ddc4f9156 ("mips: Reserve memory for the kernel image resources")

from the mips tree and commit:

  68c7c323926b ("mips: replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC")

from the akpm-current tree.

I fixed it up (the former removed the line changed by the latter, so I
did that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Xsu/4eVFbq_pNGCen_CtTev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzMAuYACgkQAVBC80lX
0Gz9RAf/frEuDEVfvoFsjMuxfDLY1xADjq7yFXgSvPJFoIT+C4RaiTNYXBb6AP6x
Rp4b+Vvb/ETY+jfGx/bAeh4+rf4evOSp2B6I3ztqXscG/8NGs9bFuCd28DHXeJxs
dhLFU+quCaWL558ezW714Xl4wrQKSWlqds7RmORWIm8LhhTL1pudhQHg2p8br/RH
2G171sDg+qJVSv+L3ZOhGzdS773vbQYhuSOa4an1mYMt4TDfQDeVanVHFJt7CvQW
MzG8/NEkaJjRXynvw9WDn0FXoncJH6tDgpfBAofb1OxlDXavyN78FGGpG/+bEh8M
s7qrzf54SREuvcCtcMOsxk5RDRFHqQ==
=cQ4I
-----END PGP SIGNATURE-----

--Sig_/Xsu/4eVFbq_pNGCen_CtTev--
