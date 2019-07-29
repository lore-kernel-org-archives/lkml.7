Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E94CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1FE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TauNOvaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfG2FNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:13:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfG2FNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:13:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xnsW5fp6z9s00;
        Mon, 29 Jul 2019 15:13:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564377232;
        bh=QuGOn8C+K50DWu78WniLWcdc+XreUwSiEy+j0lxYyH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TauNOvaHLBKhXH22Z1Bd4I9/jUQc9B8XGXo6vAEG113TYbITuLz7Cfl0EQcIEFWch
         ODUnPy6baL3dPdeynhiNkmRX69Ftm0XcaQPI///R9bpxB18mCo18qAH+SCzyutq9sY
         x7LhcIiVri49TWKENRCUkdIVEg6g87yfbtrlgiQtA/r/oDOx0oXkjSe8MyDv8Mb1f3
         LcjmAahidsZMMgrcWA6IY+tIcBzZmdMnSbKGdVlp+6UMgD1PyTzJhv9T0Vc9XzDiAV
         O/MQ0wJIlqaBWF3OhHFpaXyx0RJr/MI6MoRZAUsM8COOFpQaNneNE78uWBRQfm42Mc
         dZJHSVaw6at3g==
Date:   Mon, 29 Jul 2019 15:13:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Denis Efremov <efremov@linux.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modpost: check for static EXPORT_SYMBOL* functions
Message-ID: <20190729151351.24f9eeb9@canb.auug.org.au>
In-Reply-To: <20190728100906.18847-1-efremov@linux.com>
References: <20190714152817.24693-1-efremov@linux.com>
        <20190728100906.18847-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fSyd3K5KRCXREfTWGJHSsGT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fSyd3K5KRCXREfTWGJHSsGT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sun, 28 Jul 2019 13:09:06 +0300 Denis Efremov <efremov@linux.com> wrote:
>
> Thus, the current implementation adds approx. 1 min for allmodconfig.

Just a reminder that some of us (just me?) do well over 100+ builds per
day ...  if this can be optimised some what that would be good.

--=20
Cheers,
Stephen Rothwell

--Sig_/fSyd3K5KRCXREfTWGJHSsGT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+gI8ACgkQAVBC80lX
0GzDlAgAj8tlMdZYaX6/zkzdTuPCBG03dlkV7SVXM1VvedIhPgKU9iA2oCFuUGKI
g6gfwXKOXeInsNMJAcND2YQcsVuD83HOnwWCUXiWmKbLhwrauCj80x+F0LsVROan
mSGjEEJOZuI8UAcb4ER998RELlcoD4W4IZB1LS/pjBkhLOyqyptAlfjecH0ZfQ23
JWC0SsfpeGDNF4De4GBK9ozxuwx911ufpsHSO+0pVUMF48E5gXobj7l8ukApBJfH
RJ1dwLP5+OMeA+mTWRxdaIlLrZNOwO/NloYjuVGn8ICZf4VawxYxD71COB7xXwgo
dQdh9sT+0Yg9BkZIU3mR36GnbXPyqQ==
=LHxE
-----END PGP SIGNATURE-----

--Sig_/fSyd3K5KRCXREfTWGJHSsGT--
