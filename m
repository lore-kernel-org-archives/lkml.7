Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E9AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78697222F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Av9hiPCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKSJas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:30:48 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKSJas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:30:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47HLCm59gDz9sPf;
        Tue, 19 Nov 2019 20:30:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574155846;
        bh=zPPLhVb2Bxi6Rfx1Lohy5QPjCnGLHI0POCTpRUG7kj4=;
        h=Date:From:To:Cc:Subject:From;
        b=Av9hiPCWWHYXlwCsgjXdzmWJ96jjz8VykjGy6kyr3oxBgzIfZ+PF431poqojcLol/
         Wv/8Bfgzys7waZrLQM3nxxdE786kQltvWPAgs9yjiebq4NSK0AuMpjEqUNB6HLjr+F
         9L/veboWztpqrdOcpzrGphuw3URNLq3xJG1+WjFCmo8huII1r4i/iX30sIsLuh6SUz
         9+jxUb+OjoROfov4Mbm+WQShFTXwsVO6bxQM/WS+Q2pa0dyrVVJiZ8tJ3V39EpiROh
         UQ3eipBC3scF5NSFWbKc2glZdKs3sAj+Klh/F3DZcHpV0dhefaCOSAVMGjYiwTx+Wy
         sPk/m0ObDm3ag==
Date:   Tue, 19 Nov 2019 20:30:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>
Subject: linux-next: Signed-off-by missing for commit in the scsi-mkp tree
Message-ID: <20191119203043.67cc7d32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l6UzrAwnONJx+BtY98tekbF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l6UzrAwnONJx+BtY98tekbF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  379c3789d023 ("scsi: ufs: Fix irq return code")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/l6UzrAwnONJx+BtY98tekbF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3TtkMACgkQAVBC80lX
0GyQeQgAlfQ63Sq+BLZeqJadk7pwoX6rksgBjOaomS200lbDoUMyc7UnwTXEqovp
cLsAzfW7Ww6ym2/vOSLFQyq8iP0Kn1O1nzg5Pe+/kvPqLCFh59n7KMYWsxQ2qlVh
PSiAsUkDHNLELX2+AAySnL1b3detP11J7LYqxdaYkozyt7orcpBJNDbXcwyCyhPS
Q388B9WjXFV3vANVcGIomcunHQqLlJdziYwYKeOpl9J5eRQhx1+OUH+c18PIgFQs
2c7vchX55VETRnwPvO5R9/GK+CvAHDc8N5sVpFS1JVn6OAsfFIJrtM+CAd8qfsct
7zWDTFOebl8y0rglJHO7sHn5dBwQmg==
=PHgD
-----END PGP SIGNATURE-----

--Sig_/l6UzrAwnONJx+BtY98tekbF--
