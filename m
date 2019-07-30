Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B4C206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X7i5oqvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfG3OmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:42:12 -0400
Received: from ozlabs.org ([203.11.71.1]:58509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731516AbfG3OmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:42:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yfQn59zQz9s8m;
        Wed, 31 Jul 2019 00:42:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564497729;
        bh=vUMUX/7k3pQXC5FL4whWy2LS4dQN6qjUSbztGnpKFb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X7i5oqvtODD3P29rlwibSJ50R+u572IKhvqmA7QGbDw006vmURD+kId8vehoq5Kr6
         qqOAWxv/yVr34hNxYD4p6Jbr8Cm7G4TEKDHHdPPmJuJGROojXIIdPOpNg/SbY5xFtW
         sc/fPQYhH9evC9ZxD7cAy8M0PLy5SwZ/Wz8Gpnj4bckbEglbO1EWdMv3l1lFUmLyVN
         dCaGjTmp+L8nMQHVcNFKVip5S+s01Mf7mMj8Abnlz2PpHbQzq2/0zX0AJqAOqvxFrz
         SIc5V5w/jrMKkdG4zHs3vdhyGJh8n6pNzB6ISxUbyPfN3mx66lLt9vQoJa9mablOGD
         zBphf0rm9oaKw==
Date:   Wed, 31 Jul 2019 00:41:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch
 fall-through
Message-ID: <20190731004153.6c6198fa@canb.auug.org.au>
In-Reply-To: <878ssfzjdk.fsf@concordia.ellerman.id.au>
References: <20190730143704.060a2606@canb.auug.org.au>
        <878ssfzjdk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pIdlFQu0i8FL/lm6/rYKL9L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pIdlFQu0i8FL/lm6/rYKL9L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 31 Jul 2019 00:28:55 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Why do we think it's an expected fall through? I can't really convince
> myself from the surrounding code that it's definitely intentional.

Its been that way since this code was introduced by commit

  0365ba7fb1fa ("[PATCH] ppc64: SMU driver update & i2c support")

in 2005 ...

--=20
Cheers,
Stephen Rothwell

--Sig_/pIdlFQu0i8FL/lm6/rYKL9L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1AVzEACgkQAVBC80lX
0Gw/rwf+P6QPr+aB8iXvRzPQ1R6e2idCJJup+E7e51Z/Gl59GezLyodDWg3UcALE
lmzirNhyw1ZwnlhfpzcJ5pzHazfn7z/37UuqjUVenq9VWaYiZLRY6XA5ufe3aj6X
Q7xVeJplLON1xKRp+34fPYA3+mYQqNEWhgdsrHzxrSje+aXE3Wac0ArVLPL0ct59
/w/OOidJMAsh3InX2KUK3i83tGUPMyBby56/owxqpJLXFpuFlOpL+vb0ymEawkkL
/gqftyc45jwNC75tOE/17Km8qNqiFSKjQArDgDA3iyjLF1edvr/iNQZBjcRe9WFc
6+5WYM6uIpZVv+og6vpdSzUW3/zvug==
=1jvs
-----END PGP SIGNATURE-----

--Sig_/pIdlFQu0i8FL/lm6/rYKL9L--
