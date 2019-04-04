Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BFDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6C42177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fbbcRqTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfDDXDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:03:38 -0400
Received: from ozlabs.org ([203.11.71.1]:39575 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbfDDXDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:03:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Zz5M1XMPz9sPf;
        Fri,  5 Apr 2019 10:03:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554419015;
        bh=LXEN11Q1BRIGLaf2rf+WS1Fg9U58oCRMI2+QGOnvzRA=;
        h=Date:From:To:Cc:Subject:From;
        b=fbbcRqTptSj6stWU2DGec5Iy5N0Pj2cTR/9qrKmPpQxfux2gvTzhySe3FszgnT2JZ
         e1btwuokMXk/m2ofb6URzFaLmTBWwEQw1fM8IRGcabLiBdrm5tsU+BGRSQMzoM/m00
         wUhMhqoPgnyvre/EDSa09by9JfVOITgRlD480gXa8Amjg/ebirSnzrx5h17MrNpeaw
         219N5FmDyUJBKVSwkhGh7mptKUmBtL8VKhJrm6GzqTORvXr1gxXgeiZX86/pIw6717
         LWAICaGXrAUIYKNjWWHdEd2vUe9ucfuaMZGPA9vbsc2xnoh+7DYgAW56O0puEYLhIg
         /TH4w3dGyxk+g==
Date:   Fri, 5 Apr 2019 10:03:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: linux-next: manual merge of the btrfs-kdave tree with the
 btrfs-fixes tree
Message-ID: <20190405100329.1fab45a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kTo4dKiR8goPPhKVcKF0iyi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kTo4dKiR8goPPhKVcKF0iyi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs-kdave tree got a conflict in:

  fs/btrfs/props.c

between commits:

  50398fde997f ("btrfs: prop: fix zstd compression parameter validation")
  272e5326c783 ("btrfs: prop: fix vanished compression property after faile=
d set")

from the btrfs-fixes tree and commit:

  10e02a8f96ea ("btrfs: drop redundant forward declaration in props.c")

from the btrfs-kdave tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/kTo4dKiR8goPPhKVcKF0iyi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlymjUEACgkQAVBC80lX
0GxdPwf+KBlZTbMI/TAZjEQsz9yqsxyePbkhR+n7/rcV/J1xjWc08M+fdiec41XD
ikKn4EH6HmWG45G/MMadHrm0kapzbev+BAu+Ntm8Kad5tnIrVXIqmdnWVVy0sSIU
ycSY/3exlzdl1DMzEqsmIAr3SKNhvbKNIdOlYd0BfRkPu5sPR22I+O4K/pi6/by+
jLnDLcoTRc5jFLJQpbnhFsCYL/0ly2FBnPUTNTykh4Iya6Xv/Wh20QBPx+mu3mhs
bAXSMpm7VDmRqxmHtwMio6tlJJVg+VVQPM9w5x7hxAXzShANxRX/DmczICFFgpPA
KUhxYyAJV7B5o3yVp3s5N3DdAcUsTQ==
=xA1m
-----END PGP SIGNATURE-----

--Sig_/kTo4dKiR8goPPhKVcKF0iyi--
