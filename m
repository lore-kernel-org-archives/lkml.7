Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E24C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E5B2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GV50JKTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfDVVak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:30:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfDVVak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:30:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p09n5NJpz9s7T;
        Tue, 23 Apr 2019 07:30:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555968638;
        bh=e7DiKTro1MXyNLYlAqUb0KbJQGRVXIcplnO2lfPptFY=;
        h=Date:From:To:Cc:Subject:From;
        b=GV50JKTwtL0p1r30QYbUXq9LkeIdlvn1LevONjeQStloEUI4T+G/ePOnp/O/qvF3Q
         r/dyU30FeE3dIXueQbc2vRSpsUccGiFaUmL7EN4ESWqGrpbXh7ai2sRcAR8TnvHT11
         i64KvCIMTVKlPWQOMyIFuVtCS3HdkLCjxOnEpTnWJv4aTfTVNcZmjzCxJy3MNRuPmR
         qHkV2UctdZmCBplhDYqTjXWlmQOjAEM/TptaZEwHhlOmcqjhCYeLkXi1tVVi2SJv1x
         XLSZnLBJOFHszeI0jAFzFSt1wgwymM8RB35mG1zgv3NGwd+gPkh+QUnJ6twiWZYS98
         xzaA3tPwUFhDw==
Date:   Tue, 23 Apr 2019 07:30:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20190423073036.3fe21a5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RXB9yMIEok_3_i2o/aOAro9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RXB9yMIEok_3_i2o/aOAro9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f5a2aeb8b254 ("crypto: ccp - Do not free psp_master when PLATFORM_INIT fa=
ils")

Fixes tag

  Fixes: 200664d5237f ("crypto: ccp: Add SEV support")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/RXB9yMIEok_3_i2o/aOAro9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+MnwACgkQAVBC80lX
0GyE/Qf9GDRYxthCAWMoXZwE1IC/uYi30qs12/bOIeesOm5T5Db3m8TalDZiYalC
GJyJfYJyZEmjxQDaQaB0ZMjkHbe1qAs7ELO5+2MlVWtXCFqEBD2ZYzkJkOAgkPqQ
fjOWk46Db5GSVUKMXgO8Q25dIvso6HZ9Zj4aS195TkelRo6bZEUfXjTizAE3/iwF
EtCyMH8ZuyKEGZYG048ItsO1Nnso4ezpSRT/RzCrT3c+wnU2e+An0avItCGXmjBn
hPJCElUYqItbnJfbr8zWUh49yVxpoITd/sdLJnTyf5BkgACVmPKbbh7YGVSUz4E1
Kur6dgY7WPLkcysTxqfm2Cu3d7r05Q==
=izbc
-----END PGP SIGNATURE-----

--Sig_/RXB9yMIEok_3_i2o/aOAro9--
