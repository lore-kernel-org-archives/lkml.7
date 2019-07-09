Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBF0C606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B421537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KlxcZ2tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGIGHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:07:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIGHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:07:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jX0z2lnrz9sN4;
        Tue,  9 Jul 2019 16:07:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562652468;
        bh=ScPQiVHWvxusIeahC6BhnSyrNxd4vqY2c+dtXKHyx2I=;
        h=Date:From:To:Cc:Subject:From;
        b=KlxcZ2tftktbdup16b4ST9t6Gbc74uAG1Dil95bMpb34SERV/KRE4j1SlOc3LDH9f
         fUvr1FpRy7pSHOjWREdHhaURJGrf6ck3Jb6GI5s8RpaZdh9viV3bhtN4xEB+Cwoafx
         E6phGD8uj6snya/oA0mMuyKqCs5px5IQtzgsO0OtK3iBfYGIWURZZhwWncuu4w5Uui
         pHcA+awpXa/CDo+3WrXZP4KB4NJNUHwIsnJAAsoyiw5GLRkVB9bLCYsKKuXCjX77GT
         HObZFSX7fUqEBvNxBgpS91Oqyt1jZGn3+yHn7MfsBLP5K+ImcbeutBiXUc0zuGWEsi
         +zMX3Z0usAgzA==
Date:   Tue, 9 Jul 2019 16:07:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: linux-next: manual merge of the watchdog tree with the jc_docs tree
Message-ID: <20190709160746.19bbaa37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8poHyZdIldWWirZsFGM/IWt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8poHyZdIldWWirZsFGM/IWt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the watchdog tree got a conflict in:

  Documentation/watchdog/hpwdt.rst
  Documentation/watchdog/watchdog-parameters.rst

between commit:

  cc2a2d19f896 ("docs: watchdog: convert docs to ReST and rename to *.rst")

from the jc_docs tree and commit:

  74665686f0e2 ("docs: watchdog: convert docs to ReST and rename to *.rst")

from the watchdog tree.

These are the same patch with only a coouple of differences.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8poHyZdIldWWirZsFGM/IWt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kLzIACgkQAVBC80lX
0GxzQgf8DMjEgCmSXdueF39iOi40Ann5AA2fp/1Imj4W8Lde4h4JbwkuwghYM0W1
9lY7dqEcVKCAeD9mjLsPsA6aYHbyDPQ6+iFmJVaZaI0g92NBKDstswRXEF56XWcj
MHQdnKa4mMPfBCutFB2gN/SfsY1PA25mt3zF+qqPEvIrhwBz3+PVPOkG0q0fpzcn
e5AbgovOj9tNqCe68SP2GxYtjneUHW5DYEvR4K3JM1YNJ7tTkDJBah6Hi9A68Np8
Ncr7c/jC8t44X/iemLOmC+6ufplCan6rC+Hrji16Jlglxo8CWdZ4LJAj586lELJw
NnzRkbOAVtXnff8/gBsyQSqr2CH9Qw==
=f/QO
-----END PGP SIGNATURE-----

--Sig_/8poHyZdIldWWirZsFGM/IWt--
