Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA019C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8292D20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PGu+9+pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfFKCHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 22:07:33 -0400
Received: from ozlabs.org ([203.11.71.1]:47545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfFKCHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:07:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ND0f3knRz9sNC;
        Tue, 11 Jun 2019 12:07:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560218851;
        bh=m2FWhHME3XZj5STQwESX5Nb6gzcHzgfOilHsf4Im6nA=;
        h=Date:From:To:Cc:Subject:From;
        b=PGu+9+pJaco/mZuRkz3ReylE50zAvS/z7OxeX2QAYhsUsiMmHLqAvDOEmctFFopmT
         tpxSQsVo6x5KKq1kTccPLlONwkDQdNgAbOqXERMP/DgUANxXv30ZIKxqk1jdppjFOC
         xL6ZTg46yzyQ5Bo8J9mBnLKTvGG85MH51hYTVw2Plc0mF5YKQSVzuNH6rcNNEPDKjF
         JwiY7P7bv2SdFcnwGD08oVqpCYwMy0fUglF+ib2a7nvBcDmaC75QQbWk3suueUM31L
         m0wwX2p3bu3PVUnSpAKd/9OZ8W5g0pBjAYMtJY0V1aTnMAarpr3Ao4QoyKM4Lh3Hhk
         45aV7bddn9jDQ==
Date:   Tue, 11 Jun 2019 12:07:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>
Subject: linux-next: manual merge of the crypto tree with Linus' tree
Message-ID: <20190611120728.287af1f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8czFThpdyTCucr7DXBCF+JB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8czFThpdyTCucr7DXBCF+JB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the crypto tree got conflicts in:

  drivers/crypto/vmx/aes.c
  drivers/crypto/vmx/aes_cbc.c
  drivers/crypto/vmx/aes_ctr.c
  drivers/crypto/vmx/aes_xts.c
  drivers/crypto/vmx/vmx.c

between commits:

  64d85cc99980 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 299")
  27ba4deb4e26 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 442")

from Linus' tree and commit:

  1fa0a7dcf759 ("crypto: vmx - convert to SPDX license identifiers")

from the crypto tree.

I fixed it up (I just used the SPDX tags from Linus' tree) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8czFThpdyTCucr7DXBCF+JB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/DOAACgkQAVBC80lX
0GzJCgf+PSJjayUlkgOfTY9r8nDNsfZUlCnZs/EklT3rshOc9d37ov5W0vwyxA/n
01T+yjNtUAr3Y9HPNjlPcsGFPOkOPkOxDYINfxOvclwzDW4FXZdt72XTjXahHBdU
woksA/uuWxYQ65XBGKRDWrUDpHutgvOXuO3LMsYsXC9Sat1b8scM0RyOugQDojLb
kxu9W0iH7GJ2YVM+TDxULuIGKqpJQ4Tlt6QkvbZB67V5jMYAq+OFYjrNcvppWPYm
HHXKjSAEwxMCe6pL20U8jPyNxpjtGoMAtoyGxMNui8XRTyNugouSQwy/FVyKEdMu
KzGDV46hzEL5VZHP0ycm4L6+K6AW6Q==
=UrW1
-----END PGP SIGNATURE-----

--Sig_/8czFThpdyTCucr7DXBCF+JB--
