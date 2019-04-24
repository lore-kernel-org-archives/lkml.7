Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CC3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE6F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M7h/no+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfDXIXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:23:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfDXIXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:23:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ptck1xmHz9s3Z;
        Wed, 24 Apr 2019 18:23:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556094214;
        bh=diwHPCq+7mCG+GoXi2hm6PXlg+UVxN+zCVTR1l5lpDA=;
        h=Date:From:To:Cc:Subject:From;
        b=M7h/no+3TNgUDQ+BU7Fcnvl+D2/sHmvBDeQ+3k21gckHqs5ba+G6WpjR/nsbsOv7Z
         SAF9nGmEPawEtaSVryFGvJ+LYiPtJiAWZ/UQ8Ueq7dp400u3ROLVe24WFUinN80kQn
         QUPiON6tI91MRnCH+KH+LshBvUCfu+mGKcpG7MjYE3JNOpW6DOp1te1cLH3yvBCnKx
         hE/W5UoXSDPmshxq0Ej6ui7goSvmRcByfHXhVjq691qZVIlP7m2IwSIjTytK6uZWSM
         GRME0lkV4gZc0eaKoCHbtYQuB5VXLmw80OMi7l8oku2HTKnsM4JKpM/8s1Hz2ShtRe
         6KfmKXSSBHxCw==
Date:   Wed, 24 Apr 2019 18:23:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the s390
 tree
Message-ID: <20190424182200.71f5975d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//Ng1Kao81O8Yg=kz9KX.ul2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//Ng1Kao81O8Yg=kz9KX.ul2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/s390/mm/gup.c

between commit:

  1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")

from the s390 tree and commit:

  0dbe0ed39fa1 ("mm/gup: change GUP fast to use flags rather than a write '=
bool'")

from the akpm-current tree.

I fixed it up (the former removed the file, so I just did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_//Ng1Kao81O8Yg=kz9KX.ul2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzAHQAACgkQAVBC80lX
0GzA2wf/Zh2NqX9iOuM+7KN5LbFP+xsUxgj96y70YPJoxEnavdVmho8sdBIzrxZE
Y1e9MypZ9lUwkRDmd8M1x4sKNuHfSdEOcjq4hLAYjikY+AGPjdZJJ8e+TNexj4S8
oZrkwE0fN0ZLgyOjVFJBe7yrRE5N1qUKBYeGNXXqLtKqhYpbhm27oDqU62jNG5AE
+uRYLlZk6Py5BbmyTGYYCpYSW4xrssbfCRwB/nQvXWR/Rf5kAnLChMJrqnKQoTL8
kgUL3IcL8QGIB7ppJXF7xKMpSuk4TT4TKX8YvW5DfJN4+NsM2OO86BuypIFtvvbM
6YAM4HdWk0UvasvsfUzXAh29YyLCgg==
=K+Tm
-----END PGP SIGNATURE-----

--Sig_//Ng1Kao81O8Yg=kz9KX.ul2--
