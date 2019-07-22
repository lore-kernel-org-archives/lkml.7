Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313EC21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="md8dIW/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfGVVwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:52:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47003 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbfGVVwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:52:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45swLW1p2rz9s3Z;
        Tue, 23 Jul 2019 07:52:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563832323;
        bh=KUYmUF/AXBMZiStclARGa7trFqJYxkg3fV4Ml1kJIeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=md8dIW/OaWB5mYoMv0qZmkujXr8Q8YuDL+yt1xD2jVHBg/QP3oLhWCZI6zOimBLRF
         jEpuKzfcBmr0PYMeyaLuPj4ET7pWr1CnWkdW+tleaVwFEmiSsfA5qFqG7pB8OHYw6k
         pPHP2bmbHMxM0t/g4M6u/9HddR3Hjckg7j5P4jHNJKI69KxTtaYlxn66wZduiy0Yl/
         0mn/jJe9hp4hfksRYQx5KshAjTXVDpe1ttelitRL3ooOYBRpJxVHg56oDcjQG0RLjU
         6P+RNlpI9x+xq9g2DRB3DIhVw0H6CjY0j8BtIfM88RnZoOdJoFrCRecw+/bNZwEawf
         wXtzOBM+MIiBQ==
Date:   Tue, 23 Jul 2019 07:52:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc2
Message-ID: <20190723075201.60fa577c@canb.auug.org.au>
In-Reply-To: <20190722195813.GA18127@embeddedor>
References: <20190722195813.GA18127@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QSQEkZdd0A7Zm6r6d_7wylr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QSQEkZdd0A7Zm6r6d_7wylr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Mon, 22 Jul 2019 14:58:13 -0500 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca=
4b:
>=20
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags=
/Wimplicit-fallthrough-5.3-rc2
>=20
> for you to fetch changes up to bc512fd704a92e1be700c941c137d73c0f222eed:
>=20
>   Makefile: Globally enable fall-through warning (2019-07-22 14:50:20 -05=
00)

It may be that Linus has not seen your emails due to SPF errors.  I got
the following error from your mail:

Authentication-Results: ozlabs.org; spf=3Dpermerror (mailfrom) smtp.mailfro=
m=3Dembeddedor.com (client-ip=3D192.185.49.184; helo=3Dgateway23.websitewel=
come.com; envelope-from=3Dgustavo@embeddedor.com; receiver=3D<UNKNOWN>)

--=20
Cheers,
Stephen Rothwell

--Sig_/QSQEkZdd0A7Zm6r6d_7wylr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl02MAEACgkQAVBC80lX
0GypGwgAgblW53WxY+QcyrgaP8LM2Yy7/NXVFOw4/pmacNeKQV5l64i5pVz6m4YX
ROKqHv2oILigAnGdoqGjdUH4K+K8x04Rvr+iGrMFnnCkHHM0iMO1I6axQCVhCF1H
obDds6vIMZFjQ7A1yMKcuCeBYQc5wzs3XKtcvR6fz6TCAweBHbD3DygUvNue9WXk
jPAUKMzPgRwwE2qPh92Y9qyP+7fFcDcn1aZRpQMBOIYJDrAHvzEVb8nV/nLa2fzS
tfwjkla5yeboEyYsdYJRXupUHwl3pdvuf9Pf5Dk2PNHjlmxg+u8/PYroaGzLshDI
7uYdAcdn2x4uPzqKzDjDWPQuszgrxw==
=e7Q+
-----END PGP SIGNATURE-----

--Sig_/QSQEkZdd0A7Zm6r6d_7wylr--
