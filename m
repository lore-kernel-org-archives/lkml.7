Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFBBC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA68206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hAhq/a0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfD2FYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:24:05 -0400
Received: from ozlabs.org ([203.11.71.1]:35733 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfD2FYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:24:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44stPF293Hz9s3l;
        Mon, 29 Apr 2019 15:24:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556515441;
        bh=lJBLZeacaHY7I3jFISjJ3jSRsD+GAc4RfI2kpQrdPwQ=;
        h=Date:From:To:Cc:Subject:From;
        b=hAhq/a0xupdqAwzo7GhYUHbkidevQhSSDvPNKMU8AWf58df4wrC+9AZNUK+RXYM3/
         YHLRGev01Ecev/Y7qyCXoenvdFAte18kPtUr3K8jiio+npA68Fxxg0UPgbJWR/TEbA
         0Z9YOGHeIbcGbwI9+WsHTeEkghddCWuD5QoDU++pkPuAILGLUtR1LFBGcm+G/pC7Pp
         +rSnc8s7+tEorvkABKRHWhCbQy/eRZzQNAd/UDzQOAGtm+U5ZyXj5DWy910YQJcCag
         pR5dzBq8GS6uxTAXrWehi0HG5KCfSFa1hiEzAQc5JIfQ6mrQySUzTD9RD+KkZ03uvv
         O1V1ESxxawq3w==
Date:   Mon, 29 Apr 2019 15:24:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        Kimberly Brown <kimbrownkd@gmail.com>
Subject: linux-next: manual merge of the driver-core tree with the block
 tree
Message-ID: <20190429152400.281524b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7Jf7rBpQeJoAG=M3SUNEf3C"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Jf7rBpQeJoAG=M3SUNEf3C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  block/blk-sysfs.c

between commit:

  4d25339e32a1 ("block: don't show io_timeout if driver has no timeout hand=
ler")

from the block tree and commit:

  800f5aa1e7e1 ("block: Replace all ktype default_attrs with groups")

from the driver-core tree.

I fixed it up (the former stopped using the default_attrs field, so I
effectively reverted the latter changes to this file) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/7Jf7rBpQeJoAG=M3SUNEf3C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzGinAACgkQAVBC80lX
0Gz8Dwf+MJWy5X1/uwKQmm4Z+028zGSMFh9bMYORHGZteWUGsXsJN08urOwKbpmw
3v3T+x21OTK5xyOwVbOArgRZh6uBulHgC19TeGPbzKbVk+GYwdQ2oNo+o+nIUZmj
ups16WAewFOkPkbZsYvcJHKAMgcS3n/mgjIaPRFeogJoTI4mz02yGkqC80hRg1uP
WuDI9RgliIpHfPC6oCjoKA14CHIzhlg8EqytRrWarQnj3WmNK78R0JFLyBnAWNgy
MyTfYrdQ/izUGcHd+VChvK/2jFMFF5sUv1UjmTJUIWf1z8VLhryeIDirl6EEnffq
YkW3IJnLV8VW3ZewJVF2kejqzthhQw==
=UFmE
-----END PGP SIGNATURE-----

--Sig_/7Jf7rBpQeJoAG=M3SUNEf3C--
