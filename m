Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDDCC48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB81214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Us8FuvMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfFTKAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:00:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFTKAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:00:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Ty3h16TBz9s4V;
        Thu, 20 Jun 2019 19:59:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561024800;
        bh=IipggBUwCm8dG12BaaBdSFNwAisAMU72LTzcB1dN14I=;
        h=Date:From:To:Cc:Subject:From;
        b=Us8FuvMV8tLgi5WXoX0bXJURl8e7PbGPhEcUaxa2Ea5zL0IEf5l5Vv20O6pNMdydx
         dMEI0tF9RjJ2JqgN9ouJV5D658zmEkLgiVxHpIw0ZLkiY1iNZYD8/sDtPk5PYFw1L5
         JUhuAgme/XbgtMN3E2xE94Q0jqLFLgdFna+MUEmhvX7iRB+1v09fU24bLWJ1nZT3Ek
         9Lfbbpfzrvl6OUBtx3BJDb/iH6m3BvL9jcKkTkeqz9iDyDP4rLoDUzOIoZaj8/2gqf
         k7pyEj3jX+X7aUoVb/5HLTtxFJZAvJiuKhnAwjjrKtDugD8mjW8+ML1Ykk7B+WCL3S
         l2gi2Te1vDhyw==
Date:   Thu, 20 Jun 2019 19:59:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>
Subject: linux-next: manual merge of the akpm tree with the s390 tree
Message-ID: <20190620195958.44841896@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gQ=SzubxHMkTfaRKs_V7Ny6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gQ=SzubxHMkTfaRKs_V7Ny6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  drivers/s390/char/sclp_async.c

between commit:

  191fa92b3448 ("s390/sclp: remove call home support")

from the s390 tree and patch:

   proc/sysctl: add shared variables for range check

from the akpm tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/gQ=SzubxHMkTfaRKs_V7Ny6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LWR4ACgkQAVBC80lX
0GyB7Qf/Tani1A7xx/mSXffQ8membEuKI+vLA3o1IWWZG3fTC9NKMjcwDLEvrbrj
+/xRsdeHpIqlxh0/9CKcMpqY9ArFSlRj9EJkPYtSlfE/hWVl1b7S7/rZ9Qfy9hM0
tZcaPp4kMoUfsV8RfbT8rXE/4B0ftYgKyUrAA+JIH2UsIfgWbc8cOkr3wSeqvfbj
eIud8a9urAHCd02DL/iLNwOh+mxYmDcxMDZnfp36B4qTqAvyLQ1nCz12uthQZhiE
ZW1LRbJs4wTIA9nGeORgK6cS8g8F80/At7ztVkt7Qp1Og20DKyIKy5GgbovIjJwA
4ECqL72qzuw62ARpuKK3/u9Gi0SrlA==
=ntpj
-----END PGP SIGNATURE-----

--Sig_/gQ=SzubxHMkTfaRKs_V7Ny6--
