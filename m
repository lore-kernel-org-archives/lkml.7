Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A9BC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F402084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F8YMVv3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDLBFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:05:23 -0400
Received: from ozlabs.org ([203.11.71.1]:50311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfDLBFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:05:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44gKSb4D0Dz9s6w;
        Fri, 12 Apr 2019 11:05:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555031120;
        bh=pLq/b5V1krU1w9zGS5n9Xr4O5CxmDKdq1DcFmeD+taY=;
        h=Date:From:To:Cc:Subject:From;
        b=F8YMVv3LJJpnPkPvdBxy4IUU9Bi6PdaSSJCDaYO8l7wtiUI4lKwta8f+MxjY+okRN
         wWOkNcqyI2X2q0C5lkswK3hnrvl32Y0iweClvWySMJupgszWE2ObWFCqMlnu4/RBHE
         WOXdV7t1AxQXpkU0AtYWDwnMREVLjOSVPuICZ5hSoGphHUnYacsMMTlYvW3noY3xCx
         43fUcymLHJnghYeGRjG46XbV22b42zpoclxHPeUotQRsbeYn1PTop68F1nD/HNVC6b
         IMocSgrYQm0W4y8hOasLrizL27VEBuXTad+J1J1f1prNEcdGm+Tv2jg+I1ReB2saId
         femhX+GXp4suQ==
Date:   Fri, 12 Apr 2019 11:05:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: linux-next: manual merge of the bpf-next tree with the jc_docs tree
Message-ID: <20190412110518.46e329af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/emHHSzS8SwAffydAoVO3eI_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/emHHSzS8SwAffydAoVO3eI_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  .mailmap

between commit:

  9b628c6ab437 ("mailmap: update my obsolete email address")

from the jc_docs tree and commit:

  fa0dcb3fe2ca ("mailmap: add entry for email addresses")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc .mailmap
index 151501c73503,e7984bb6b4b0..000000000000
--- a/.mailmap
+++ b/.mailmap
@@@ -16,8 -16,9 +16,11 @@@ Alan Cox <alan@lxorguk.ukuu.org.uk
  Alan Cox <root@hraefn.swansea.linux.org.uk>
  Aleksey Gorelov <aleksey_gorelov@phoenix.com>
  Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@i=
mgtec.com>
 +Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
 +Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
+ Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
+ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
+ Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
  Al Viro <viro@ftp.linux.org.uk>
  Al Viro <viro@zenIV.linux.org.uk>
  Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>

--Sig_/emHHSzS8SwAffydAoVO3eI_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyv5E4ACgkQAVBC80lX
0Gy9MQf9HV3njCxmY/t9eYQlrQRRYFcqtKBWXcQBaLUONuT5S+uqDlU9o8yGqZFz
v72XOw+gU8HaFr/Xa0gd0LIiLVBrCmDibOlEvSq8N3giHIJUhKiCMcVTkf3lfQ7m
QdKBBRC23YFTAGcJC17uEY8nvBQINVH5QZ9P0+RgwzjoGHOedPd41rb+GiY/M8D8
5ooqo5v1qZPTSnteB23esVCxvxwRjALz3ZfegsQnPaXN4TJ30WrnGnVzqQSt638m
SrBdmo8iAQL14U/Fq5HvYdAA3w+MIAso5r/tiAhYmSQRLW5SAl2DIytYVVxGOM6w
7VKUxvPEvSpdPbuyKSBm0rC6fdO2Sw==
=/QdY
-----END PGP SIGNATURE-----

--Sig_/emHHSzS8SwAffydAoVO3eI_--
