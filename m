Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97638C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646E72082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m4DaOpk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDKGWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:22:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfDKGWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:22:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44frXP6qclz9s9T;
        Thu, 11 Apr 2019 16:21:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554963719;
        bh=ovt81IcCfPpcwkXPu0CSz7H/+rcsKY5rA++/B23vFWI=;
        h=Date:From:To:Cc:Subject:From;
        b=m4DaOpk/NeUIQJTqfgL9xamIrynweDfk/6whiIUheTnUouIvbDKbJqOkai6K64s/m
         NVSEUL+xXd0rXTdPURGbwoNAv6t90kfbIbYfI7CD6TQ365R03gSyEXc7BsVX/kJkL9
         5bbmq098OFVK9Ru/a+6Y+eIBPCOPqXvwq6sa5jbCG7E3YuCd5SQ58GviHo+4FICWE3
         rqL7OU+P5bI9oRqdPfekTSc4pXU7P7zfgeQxYOsI5sDnzrS2qKmFrA1BmJg1sDhP03
         NyLHJLg7y6C9vupAagwKRcWE/83tucXltj8o+5bSB4dvYIn54Q8tuwusWGsqeC62H0
         bbhhDywsTEr8w==
Date:   Thu, 11 Apr 2019 16:21:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengguang Xu <cgxu519@gmx.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: linux-next: manual merge of the akpm tree with the vfs tree
Message-ID: <20190411162157.77e4c8cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_aTxt_Lt9pi2Lcj13=x/t2q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_aTxt_Lt9pi2Lcj13=x/t2q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  fs/block_dev.c

between commit:

  6d46d2934aea ("fs/block_dev.c: remove unused include")

from the vfs tree and patch:

  "fs/block_dev.c: Remove duplicate header"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/block_dev.c
index 6b584817d461,bc80d165f0c0..000000000000
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@@ -29,7 -29,7 +29,6 @@@
  #include <linux/namei.h>
  #include <linux/log2.h>
  #include <linux/cleancache.h>
- #include <linux/dax.h>
 -#include <linux/badblocks.h>
  #include <linux/task_io_accounting_ops.h>
  #include <linux/falloc.h>
  #include <linux/uaccess.h>

--Sig_/_aTxt_Lt9pi2Lcj13=x/t2q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyu3QUACgkQAVBC80lX
0Gxa5gf/UaC3CSjHi/SFKtOOqgt/IrA2jvNHK9zFw7xlciuxb3qudMBvrQGEVchx
+gLNfvs8Pb/bdBLBvtZmVn3IwRyxgtaMDcBMjNcqUSRwt/gusrjUH352SpstHi8j
qYazoir6yas3lCz9SpyJCF4FeJxJyx6I5pyRT5RQBuR4JEKZRfT+94zbjk/XbvmZ
obqvSMQ4LpnGIrXbG3XqIDVnte9odKU+HytoSAP0kEkryL9Dj5ISlLgPa26qvgIN
qJQeU/pxGtWIslULNtCDoIa546zGQjQkutEQc207OvimkPzuw9YFKERnFDCAFEmq
Ti75nagGHuGtVapoK9iSBeQkgKeOxQ==
=oK7N
-----END PGP SIGNATURE-----

--Sig_/_aTxt_Lt9pi2Lcj13=x/t2q--
