Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B20C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1192086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Btz5wTJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403965AbfFKGcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:32:52 -0400
Received: from ozlabs.org ([203.11.71.1]:50097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391045AbfFKGcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:32:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NKtm5z4Yz9s3l;
        Tue, 11 Jun 2019 16:32:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560234769;
        bh=XCaHli6O4cB8u4MOhcBBw2PeyV9cd8jTGqbDtKaB1ak=;
        h=Date:From:To:Cc:Subject:From;
        b=Btz5wTJRuEQTYBCimYrOlfI7QI2D5j2Tf+4k5R1wcmJyinP4xlDkv6sp+HocbWyRN
         SUjHwLTQLMGexDfLE7ds3Ku1e2CVyhHzw4GHFCFCre0yKEv0xZL9jea3RGjrzgt+bH
         GwJcHUql6coru5wJTy4BGJOXsKodZaJM3ssxZFP3AWFEOmS3M/5iv4cdUrsa+QWT8V
         3RJLfgpv9tLF9VKY2CqH9u9y9hVcje1BTbxaKiZGr1HiCIdLTQiRWquEDwZEZE2FmU
         P3A9Jw66mX7I9CvjuTVjwX5cFYqrnG7QsdwC1AVDSLD7/02z/8WCJ1yO06WuJLtr8n
         0hgSUlaZDU4sQ==
Date:   Tue, 11 Jun 2019 16:32:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: linux-next: manual merge of the slave-dma tree with Linus' tree
Message-ID: <20190611163246.6f90fba6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zT+_=bmZ96yjIPQLyX.Zbae"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zT+_=bmZ96yjIPQLyX.Zbae
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slave-dma tree got a conflict in:

  include/linux/sudmac.h

between commit:

  49833cbeafa4 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 311")

from Linus' tree and commit:

  9a0f780958bb ("dmaengine: sudmac: remove unused driver")

from the slave-dma tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/zT+_=bmZ96yjIPQLyX.Zbae
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/Sw4ACgkQAVBC80lX
0GwCigf/dnsq+HSsjyWyGUotVxgg18xFqgiCu8SOZWG2k7dTlpfCqTcjaNcy/wq/
opfkp0dd9nWIRYcCbfcQ/JYXecarH03ztDEyR1gcYG3dF7tMvwSDqnhVD1K0TtNs
HWmqgGNH+VM4zkK6eoFQGt7Pm8vqF3JRLCOC3pAjfI2fRwED2xm5lztdUBFn7pn+
O7XnhO4zdNmOiA8tn470Bzf9SNI4KrnmhBA5o2wGE23sXnX4DcOycXshXUHKIBrs
6zUTTIFv/M1X2+cKFFQmB+2aUEaqVDiitp8p6hOlPs/nz6vTux9jz+UtIzZBufFr
Mzct5XeYM8a8Uff71XW3iRuaQCTQaw==
=i+gD
-----END PGP SIGNATURE-----

--Sig_/zT+_=bmZ96yjIPQLyX.Zbae--
