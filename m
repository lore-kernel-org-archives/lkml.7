Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF852C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773F23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eUSyPKka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfH3DB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:01:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfH3DB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:01:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46KPPv3vlSz9sBp;
        Fri, 30 Aug 2019 13:01:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567134084;
        bh=ZGcKQcDuLMAiiPzUKHhHVk5LoTnjwVnTJ40ll8PejpY=;
        h=Date:From:To:Cc:Subject:From;
        b=eUSyPKkafOP5F0QPRq7X7JbSs5ehS5OlG1Ce6yIXgFXNJilHobUjJfc9XPZt/7VJi
         pxtDV+wI8L77CS+eyQLhKgQ8f3JXWl4IJW1z3IOfpKzXR9X+FvfXaX7tod/UqtbC/2
         6brk6EsUrTtSfzcbYMprPda/1d+mTRsRsnW3WafPTmyCEUuhBeIWEvTB000P/BrRwj
         792srkFzT6eyNl8k52KO4cifK4fMesAmTrWZzPQSiR73M/4ggbAn1XstGBpNQQmIBY
         r5JWjq64UvT0n8WLTbd5rVg1pMinag+SYRUCE5cl4PCyhoEC2Dzyk+G5VWKf+bPjNZ
         wV+jlGsGcNyfg==
Date:   Fri, 30 Aug 2019 13:01:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the fuse tree
Message-ID: <20190830130119.446e7389@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tn=2ZLbKUMqhULSfKru47vA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tn=2ZLbKUMqhULSfKru47vA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/fuse/inode.c

between commit:

  1458e5e9f99a ("fuse: extract fuse_fill_super_common()")

from the fuse tree and commit:

  2ad9ab0f7429 ("vfs: Convert fuse to use the new mount API")
  48ceb15f98c8 ("vfs: Move the subtype parameter into fuse")

from the vfs tree.

This is too much to work out, so I have effectively reverted the 2 vfs
tree commits.

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tn=2ZLbKUMqhULSfKru47vA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1okX8ACgkQAVBC80lX
0GzQuwf/bnDmW+NPdNxJXTcgZ9hm3O+JmDYt53J7xpjGVs8/t1oI5lki5r2r6iwJ
5VlrVmIy6q90RSSNbXrPcjEitdi/sNuTyYsQw9gG5NBs7VkxQAneQnCQEmG26Gss
LPBjkh1Mxtp90I5s12PJPBvlOiC2H++sqwpEfQalJFHQZU5Q5Uuzs8u8yjiLJZJD
io8n+aM1K1XSMYKTC60fnwgWT8sT7H4sqYLHqPuZmnmR0eJqxw6+JUp+zQpXuBUz
pAFBrGT1cypjbw75hrYIt7uu8UawpIUZ4Sx/AZVteOF5GaM2EoOl6bP0EoSkNzbL
tGEJOxtnzhSeOiAeKrS4FM8yPDCs5A==
=t/LM
-----END PGP SIGNATURE-----

--Sig_/Tn=2ZLbKUMqhULSfKru47vA--
