Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FEBC31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EAD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BsT5KBuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfFQBzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:55:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfFQBzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:55:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45RvS51nlnz9s4Y;
        Mon, 17 Jun 2019 11:55:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560736533;
        bh=ITpVgOoQn3Bd36Idi4CQR6vSlRW41CVJwTKJMIPgfO0=;
        h=Date:From:To:Cc:Subject:From;
        b=BsT5KBuLLdTHumpfvnZts/Z8zHUG6Nz9iwp5cNlAE0IrULi6GZ+ZEKwij2doV3SPN
         glGtQElTdbw6Uzu4Rp9CvY3ZoM2rm8JVylAqd2tzNj0O2362QsWG9Op7bmvh0tHSOp
         L0mvWCzboEH8Qiid2ACUiAMqzI8KEQ4kFWau3VU/P5VjFm1nf0e0x9d+rDNYjisHjz
         pk28t5dy54qJ21aFvk8GFCT51JqSVDsTunuzhopE2hfhJCZnanDPWiJsrAKskp4YQN
         0JIszqQwnLBmk63kgQBLVuS/06ST5taxLH1fzA0T1OI1MaZIYFs7eTtERAMa+bM9I+
         R3AHw5BZ9j5Rg==
Date:   Mon, 17 Jun 2019 11:55:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190617115532.74abea04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+Ali6yBG=wPg=qEq3qM9oUJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Ali6yBG=wPg=qEq3qM9oUJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/wireless/nl80211.c

between commit:

  180aa422ef27 ("nl80211: fill all policy .type entries")

from the net tree and commit:

  1a28ed213696 ("nl80211: fill all policy .type entries")

from the net-next tree.

I fixed it up (they were just formatted differently, so I used the latter)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+Ali6yBG=wPg=qEq3qM9oUJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0G8xQACgkQAVBC80lX
0GwKiQgAiIOSFBqHjyiz6eEkVJ5vQ+8eDpKzB5pPvEecfQ4L2lJMlOpGY+yXpkQi
Doin+bTfQODJPjYg6r+Bwn9E0dDtMG9g3BsxEKhTlZ63/9u1NvsrTQFR7cPgy3oC
Vx7mJVRZWL80l7mDRxmfYpvXzVnmOQnI+oxNhH2nyfXa05coV2SCvSuPamomNITb
jEdoi4+uFflmRw/Kf85sfHxjnLwk+Bz5h4k4+6W/TElk+wMYYxmZDH17lhdnCKkK
9ML2v4KMuSN5SKwnwYjW1yg47xFDvdYkMbTF7FaiOzbVaCIirLZ3lk1L1YbnCYUT
9Jg6XJqQ2YYsQUY7dwfXVdFrViLFYg==
=2vD+
-----END PGP SIGNATURE-----

--Sig_/+Ali6yBG=wPg=qEq3qM9oUJ--
