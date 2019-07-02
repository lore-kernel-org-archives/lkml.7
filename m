Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7429C0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75342205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g04EgJQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGBDNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:13:31 -0400
Received: from ozlabs.org ([203.11.71.1]:33705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfGBDNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:13:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d8T42GZ9z9s4V;
        Tue,  2 Jul 2019 13:13:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562037208;
        bh=jc8Y+Amgn5i1Y3Rg8MXcVfdSKPs8D1u9eA90xHAITEI=;
        h=Date:From:To:Cc:Subject:From;
        b=g04EgJQdQIDumHBiTzX+PthFRv2QfBa0fTcJv628CvYXLgYVeoXJZWvOpUbUfdb26
         wIRG3/XSNlftALy1qMluEqxi/0jHNffpQ2TqjqHo07nFVGyBI+xRKXvyMirqW2V1E7
         mmVjm0cI2HvbGKKUt2zmv4q9BP+OaiiU0q/JBEEnYpJowBcawSUzCWobgmGSaSRgXs
         khDjGEmg5m13tkWDLysFPcrGUzAaFwQYhLsQA05jqIzFu2sjZYmk1/asMF7GpDJC+g
         qR52QurHN8y1oy3pOzZoCI3fl41DbMHcVmoqlVsvUGXxDgUFXsVvibmcc+ZezPvurQ
         sKRsLNcYvLZkA==
Date:   Tue, 2 Jul 2019 13:13:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Britstein <elibr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Bodong Wang <bodong@mellanox.com>
Subject: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20190702131327.65dfdcd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uCtOuwcMaejTz69Axufn4C8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uCtOuwcMaejTz69Axufn4C8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c

between commit:

  955858009708 ("net/mlx5e: Fix number of vports for ingress ACL configurat=
ion")

from Linus' tree and commit:

  062f4bf4aab5 ("net/mlx5: E-Switch, Consolidate eswitch function number of=
 VFs")

from the mlx5-next tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/uCtOuwcMaejTz69Axufn4C8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ay9cACgkQAVBC80lX
0Gy74AgAna6dU926TPmhdeiySQP+9awZYRtn7970MN17785j87L0P2PxmqfB1LNR
0W0zyU3uoaorN2/FFbRFxDFUJWiErlCn664PAU3ReYSkHf0ExPGn/0rSse1/8V+x
PCRzgsqa+f3UaLxW/fLJbAHXHgUqJB309NZ/8X91LyfpN4bJfW02lLh/l3bfN7Es
wkXuW4EQ0Qm2kcm6i5Dc4ty7IVjEErbLV5gp5iODvrm+oFx43kiIlTleuz/yPfk4
ZmXONEcn8Ytp9fgpCMuszd3Au5uwIgeQX573FwFAHHw/eKHdzMn7kPhyr+fQks+q
sYIurnN78kCmbczUC/uu42JxaVLT7Q==
=Q3tC
-----END PGP SIGNATURE-----

--Sig_/uCtOuwcMaejTz69Axufn4C8--
