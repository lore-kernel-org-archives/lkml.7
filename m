Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385F3C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D9820673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OPPnWLes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfFXCc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:32:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFXCc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:32:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45X76d2fsSz9sND;
        Mon, 24 Jun 2019 08:55:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561330508;
        bh=CfQNGmyRCYuEzDMKXQ9cnOE6ZWSd1jrKEmYS1i0ftMY=;
        h=Date:From:To:Cc:Subject:From;
        b=OPPnWLest3qGwfakF/bUj22KshAxAKvJEZ0TvgYF5uvuSBZGz/y6stgy+9T9dbQbR
         Q6TxIhic6rQNA3YkEEUzDlY9HLwZoY7in3lpLZXOHuZ4ou63g1TVccUu5L6ATd6iup
         n+4FXtfPBWEWphTMfMcZGy9/GKOoEkdpPfauvfsknPMGWwRkggdulx3z5UxoFXAPMj
         u637IiT4Zw+C/33wHl4r1qLk53b3xh0cPHvl5BNzGZlOiifsAUyhaBkWqqi9CTzODp
         +SPxnLIjZs+nAFzHIj0jTqkFq+0MkcjMnnErRverJJdvM6c5GljDY0BrVrg/gWhV8w
         W09yR2nk+4Ykw==
Date:   Mon, 24 Jun 2019 08:54:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20190624085444.7b4a01a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TvkKorMsiA0+QoO2/asEuNP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TvkKorMsiA0+QoO2/asEuNP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/include/debug/netx.S

between commit:

  d2912cb15bdd ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 500")

from Linus' tree and commit:

  ceb02dcf676f ("ARM: delete netx machine")

from the arm-soc tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/TvkKorMsiA0+QoO2/asEuNP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QA0IACgkQAVBC80lX
0GwUQwf/cvz09njduHbXOnvqgqpXjuwRlTlJVpRWy9/ThE0Q4jDgn7nlVqGXWJyV
sHC6yPf5D3d4VWbcXhEt6rj1Nu5FiSUvPfS+4FGHpvCXQ76sDZIr2nMms6Y9kJ31
D7wyipX+LWmd7LsTLGq06X0LMZbVEg5g8SjK/bvc4nzhM8yLhMazzFHh1fAYXG6n
Vv7/KyDmUDosCC+Pas2adNx0XwyU5vWjAC9znJsMrZW/057g13iohKR67nImJKpw
RB3SU6LPR1dpWHCtVbnlJjRZyXC3RccdkMDntccB+E8Sx3c/czVyCbm/nUmd4Uka
zYJOk+AQkp3YtXBhcxQ1mjoy/1GMnA==
=vLqH
-----END PGP SIGNATURE-----

--Sig_/TvkKorMsiA0+QoO2/asEuNP--
