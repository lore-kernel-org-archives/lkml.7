Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331FFC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F9218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SKrdMAcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbfGPXhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:37:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbfGPXhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:37:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45pGyL0HXrz9s3l;
        Wed, 17 Jul 2019 09:36:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563320218;
        bh=hoQVxDinIKNkDATU7tpI+LeYJYnCFGspc4zHVsO6MOg=;
        h=Date:From:To:Cc:Subject:From;
        b=SKrdMAcFP36B1mv4a0U/Xu03UEV6sQWsnm7leJysoc2HkRQ2QX/s/n/k/xev5uNme
         fEtErVO8/ojV2DjDpOhJHKTs1aufnePTxK3vXL8gkA7TSdTJaFycwm5U2OTPfB+9x7
         F11x52PRvfvwd+x5npsmFfP+HQtiStG+kVFU5dHv9mg3kW3mXvVbZJMs21S0yJAf3d
         AcUdb+8HSUwdreYBlgG4GqIry5vU4gQWlCNyX3erpJ2/uV7cs4PZsIQkCDuVNAppwS
         dke73/iu2sElQWa9WiVPqq2a9Kj+MJLq6Vw1LTX8UkUfwh7IeIK3+kQh230u4eQYgn
         dTPpT+5E5foYA==
Date:   Wed, 17 Jul 2019 09:36:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sheriff Esseson <sheriffesseson@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20190717093657.37a4186e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1gVKxdAeql9+nyt7jnlkzFp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1gVKxdAeql9+nyt7jnlkzFp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xfs tree got a conflict in:

  Documentation/admin-guide/index.rst

between commit:

  66f2a122c68d ("docs: Move binderfs to admin-guide")

from Linus' tree and commit:

  89b408a68b9d ("Documentation: filesystem: Convert xfs.txt to ReST")

from the xfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/1gVKxdAeql9+nyt7jnlkzFp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0uX5kACgkQAVBC80lX
0GwmHwf/Xk4ev3lF3dqRLCX46J22k80G1RUiw0cgtFgPzbwVxYU1xVIaQUq5fPQ8
Zp1n3XnXmKnVJyMmP/ie72i/YNdxCWZYIu6rUxjWF+8/5jq8vXqRRSG5Vwnp41Jb
xV4Y7K0LhG5hSfoCen+E9rkGhM9NJ4d/heLmZXvdz4v4AP8dt+zHGfHEarjv3egC
Vyly8WW0dlITKnNYsB1MqaF6rC6XyD/F81N9VhHVXkQ4VudHECBFZlmt/lDsIiTX
E/5B8P3rIIfYmUj4As2RRrOqnboJQ/l7gHmc82yPwHs+ATXFtLbntM8hoOiUdQQ9
+8zmrWtk1gzXEY6IfHvrXKR7BR9jpw==
=0zfE
-----END PGP SIGNATURE-----

--Sig_/1gVKxdAeql9+nyt7jnlkzFp--
