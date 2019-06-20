Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16897C48BE0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98F82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EyS0OkgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfFTCKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:10:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfFTCKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:10:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TldT6TDRz9sBp;
        Thu, 20 Jun 2019 12:10:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560996606;
        bh=1gobiFQ7PSy3wL4wllkVbtu1pclXmkkfIBzSW8dztXc=;
        h=Date:From:To:Cc:Subject:From;
        b=EyS0OkgIVGg2cfTPVFlCGEamRucR0nG9T7A2M1FUOljDzXglUnGz2EH5YTAt10OfA
         dtfBoPE6C+gxYoSyEBWAIRopIzTdokve4PgxM0/DpktSvY77c1l+wJfKeYe24L+y2Z
         zSRxy9U6k4e/7CDghEDFEwvAXuvqB87VPio2ns5d0ULfhFNS077qxAo/bsce/Wc/nA
         9VkJf3//OIq7xYfXK82n3HmyQDvgm0gK3MPfHuttOYpxHuboB1/zuj2z4fQQ2JWPdC
         K+DSJCg8M6w9w71epBeKhkN66Dw/v5m2hhrpI/5Q/+SgHUrUeylJv54+m6nionB3PY
         Exg0jj0ZB2G0w==
Date:   Thu, 20 Jun 2019 12:10:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20190620121005.6c01e6ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yjfmbKG99f90xRxJn3DT_6n"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yjfmbKG99f90xRxJn3DT_6n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got conflicts in:

  drivers/infiniband/hw/nes/Kconfig
  drivers/infiniband/hw/nes/Makefile

between commit:

  ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

from Linus' tree and commit:

  2d3c72ed5041 ("rdma: Remove nes")

from the rdma tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/yjfmbKG99f90xRxJn3DT_6n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0K6v0ACgkQAVBC80lX
0GysBgf8DnQVVCbh/4bGYBeESD4ZiR89rPHgLFqss9JEMbboJoxsaZGnxrr4Rx2p
9Di/diyOLLzI5rdOrHuUbZMvo/Nj3mY3yU872UJwwaXyAJ8uzJynclpG4pGRJcOU
Bm7dck1wqJ+g21bTdvEVbLf5Ff3o0N1z4ga5l+eUeufh7Ux8iyTYuP9DUdbJ5xQZ
dd0g3ZQbxIcyApzpw0uSdM+OA+GZrW1NZPEK5JgOZIfhCrky+1IwUr128JDffGB4
5WtwRN/j9QM//VzAeHeocknfF5J9R1rT9C1LMAfv/kBCuQlyHKl15gtuz5ykgX4W
fiaeb6ZMWzrwvSL0ztdpU1WyLE3KUA==
=W2ms
-----END PGP SIGNATURE-----

--Sig_/yjfmbKG99f90xRxJn3DT_6n--
