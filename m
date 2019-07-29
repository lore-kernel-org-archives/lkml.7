Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1477C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 02:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7183F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 02:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tK0GBhPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfG2CAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 22:00:08 -0400
Received: from ozlabs.org ([203.11.71.1]:50033 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfG2CAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 22:00:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xjYv0j4Lz9sMQ;
        Mon, 29 Jul 2019 12:00:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564365605;
        bh=1pCp8KqHZ/WmNAFaNxpUyKcAQ0lgMCiZ+XkYHe8FaqA=;
        h=Date:From:To:Cc:Subject:From;
        b=tK0GBhPN/VGBdJDOufxs+98rT//vHQiOH5MYz92S+Pftw7aW9a/5kwJksYG0WQl+j
         Ra3ovx5B8icKJf+RVZHWpkKsg8ZMHo88HRu5lHOXNqs+u7z85GsSJhj7p0YLU6D2vK
         bL4RIWL3kIeXcgp3tHHJxfLZvWT7Jg1CrPvr+iCeigksl4omaBg4UrX0O1B0+11LxY
         bGpeucflqz4HNTpEOKHzY0Hpso0EMgUBRaGX5pnqXNjwRe070BlYV9hSjaJEnW4jmH
         xjCb05hVPTTsDzvJIDvElqYx7jGqdKeom9hjjVHSM1Kv5f9FjnOFso1or4mkRBTJCX
         gwpRaQ96VdSwQ==
Date:   Mon, 29 Jul 2019 12:00:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20190729120002.79714b83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//bYjR_P7ZP6u6bU/09cltSs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//bYjR_P7ZP6u6bU/09cltSs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/include/uapi/asm/types.h

between commit:

  d9c525229521 ("treewide: add "WITH Linux-syscall-note" to SPDX tag of uap=
i headers")

from Linus' tree and commit:

  701010532164 ("x86/build: Remove unneeded uapi asm-generic wrappers")

from the tip tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_//bYjR_P7ZP6u6bU/09cltSs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+UyIACgkQAVBC80lX
0GxMXQgAmmFqa+4w27VbxICOUHIP6GTJXTW8xCw4NVlBu67+k+t7xtPvKAm0EMCt
9fLiPMIt6IDWybwLPQwd7ck3gNBzL5jyfV3bhgtEVsqEc9pUL8u9UsY+Xkne4DXI
7y+pjoO7T53E1PLZM4q67DeKfSZkYKS6Wv3PXhShyabiCpcECZv7PmG4/w0CVyx3
oLVx+fUlk11qbg4xUJxYWwW5GCADhZE0Uhfix4XRaNUhYd2LsUjOgCdF83O/YX3t
WtnwEp8/5xINz5IglWRYwJozvuUIqC5wQmnwx206uAVK3UUH9w0LqFOHJcbBrvaZ
Qaulkkm9LN5bEr3q6+ltYi4CQD2STA==
=e2VR
-----END PGP SIGNATURE-----

--Sig_//bYjR_P7ZP6u6bU/09cltSs--
