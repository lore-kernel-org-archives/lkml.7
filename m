Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B312CA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5105F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EDtZaf3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfJ2ETd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:19:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbfJ2ETd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:19:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 472JJK36xjz9sPT;
        Tue, 29 Oct 2019 15:19:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572322770;
        bh=N30H+2ZFOSen+pDJx8e/CIs4ajwdKakKy3o6oQQ64Bw=;
        h=Date:From:To:Cc:Subject:From;
        b=EDtZaf3+NllBHvEpVbzF6iTnH/SR2utszr9hyNVjt+FDVeabGG3d13OCokDZ6if08
         ytIG2G9aC8In1b8db2Aok/4rEpxgeZxDADZX/Qv0CCUE/kxKOqqGVG3lXLZORg9Cct
         qNKAA3xkG1C1pWKxcAXiDMSe8OAfcYwENRJ+P2ZDAd+fzyKE++TKgVGGlFOQFx4q5r
         G+LNL40z7EJrXOTmGSYl/P4Z4u6S7Y+T6ZfnVa6ov5SQRe1svuR67uHhSXFrfp75ni
         9HmmOhtrOT7rWvpowdT41ZYKO1Iumg5nUBWbg6+m1q3MUn78W8bRh8lEc96Cah3CPP
         7AECSvg82iNRA==
Date:   Tue, 29 Oct 2019 15:19:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yin Fengwei <fengwei.yin@intel.com>
Subject: linux-next: manual merge of the vhost tree with the pm tree
Message-ID: <20191029151928.780c8ede@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8/pO3iz7Jzmo1jr.hT+nBWe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8/pO3iz7Jzmo1jr.hT+nBWe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/acpi/processor_idle.c

between commit:

  fa583f71a99c ("ACPI: processor_idle: Skip dummy wait if kernel is in gues=
t")

from the pm tree and commit:

  a04c0533b07c ("ACPI: disable extra P_LVLx access on KVM")

from the vhost tree.

I fixed it up (I just used the pm tree version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8/pO3iz7Jzmo1jr.hT+nBWe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl23vdAACgkQAVBC80lX
0GwB7Af/bIMWCfmlAWbK1bcyj7T0fC3Akqzp9SKgR6ff98TmFY7LKDmRmnfE4Cvv
9TK6E8IZbXT5Fm5k0LTE9zsZxWWYlJvPr7wSfrMWg8YMZ64LXdL5SGr+HwS8u58G
P68ajYRLY6xmbyYPjQxCJ7ZcOPJK5wIrnBiZEHgKjIo7BRl5c3CRwe/C1Xef+FCM
uRkrn32jaWehpIaEak/rihhO++z/kvcPUYiAW+cIQKqVo6IgRtx0OGnI8MpllBSL
gvzAla2ApKLoRmuMEDwQYxRXcO43/ZwuPgdy7h5ce7xM59ERfwjLJsIRHZO8XZuC
KTII8JFVnlP7Bg7UNZ/KUWHW4ZrIRg==
=C/QN
-----END PGP SIGNATURE-----

--Sig_/8/pO3iz7Jzmo1jr.hT+nBWe--
