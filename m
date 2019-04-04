Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A212DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664A520820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M5SxmLqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDDCnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:43:39 -0400
Received: from ozlabs.org ([203.11.71.1]:44431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDDCni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:43:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ZS1g5zzFz9sSW;
        Thu,  4 Apr 2019 13:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554345816;
        bh=PwLdbTexVM81ioS7LBLs4IRVQ22hNhqi3htGg9r5W50=;
        h=Date:From:To:Cc:Subject:From;
        b=M5SxmLqaCPDVh1wNWD2Tyei7jDcfAOq5nB5NcmNHulBMLaOC0kx8j6+ChnYd4arih
         QgyF8ODCHDB7nUkP6UwyEg0nw9jISYVUpZIvwFpgBDBcqc4JzFEKqK07lnKJxyrPaa
         uMgmigAt+PjhGu6TTELuPndDLvkFFpsW1QXOh4NTYUOskmtadjeQimbaQafG63qFv/
         w9+FKvVpatEmlbSMeYvHhTG6b+I3swy93CRAE8Mjc44VQQdf5HUf6mdpcd6oX60T8T
         ZRv5oM+crxXxdiEoM+xKvU//wN7UFbEqd58NQS6dofzwYhqHNCpTdarqOwjlIF0gby
         /23Hyr3Wjq3xA==
Date:   Thu, 4 Apr 2019 13:43:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20190404134335.6752d477@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/idTcLt29mAheRKmHQW9qx.W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/idTcLt29mAheRKmHQW9qx.W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/media/mt9t031/Kconfig
  drivers/staging/media/mt9t031/Makefile

between commit:

  dfe571ca8daa ("media: soc_camera: Remove leftover files, add TODO")

from the v4l-dvb tree and commits:

  99b75a4e3275 ("staging: add missing SPDX lines to Kconfig files")
  97ed8eab2a00 ("staging: add missing SPDX lines to Makefile files")

from the staging tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/idTcLt29mAheRKmHQW9qx.W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlylb1cACgkQAVBC80lX
0Gwbwgf/Stjq9acsaCMzrgvVsc1uhBFrF4R2i/6Imf0RuXw1Qw86gpSDwumgo2FL
KPtN2Mj0Pug6s5jt8O+qLeHEQJ6frBWD5IS7yoHdps53Ua5cOIK7yld/jsTLCtdN
ZdjsCnsPXMsVE2rVrVWyt/z7aqUwxoV3wIRzKse5FevMYo/rlPvK+02qIchW8vzK
hUWiTChucpix5BBiscPSRPNpct5n5nhfcYY8lgzsoznMDPM/vz0x9DgoM50XBrPV
+Hp2PxKGL+EutFKTchVWBpTdCAREvoLSAAlMPJlqkqqeG/noCKugW/SfsB6Mgg/F
NBA+7m3KDXBxD62vHaDXRUzO/XqFiw==
=PzvP
-----END PGP SIGNATURE-----

--Sig_/idTcLt29mAheRKmHQW9qx.W--
