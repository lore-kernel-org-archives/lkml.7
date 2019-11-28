Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FEFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FE82176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bKFNLi7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK1VzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:55:16 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfK1VzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:55:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47PBJX4XFfz9s7T;
        Fri, 29 Nov 2019 08:55:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574978113;
        bh=wDOEHTT2VT0N4HQGhjLn9Chl3FGBwKvE3eeR1urev6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bKFNLi7zkmqOeXD/Q0QRNd02NEkjI7RMb56KwQkR9B0TZ6SQ5Bxohlr9Oy9TOjdC/
         KddeXzrEtstGonqvE1f01MfH91a6RqLzh3pA7wgzHksTXWno7fAnIp6/GT87AU21rN
         cg2bn3pLvCtaUrG7nSvoy+CCLmzTx5lkTPjl9tmKmtRg59Ix5rKwHgqzAI59vW83LL
         gBWiIisoCchhQdJA8b7JR8UnDbpGITHS0iYj48UASH8vpfgVJhqr26aOHUcpziR1Vg
         G0JF5H+Oht+G0z3olcT7dX/xEOq93lhHuBjvtDzQAuK2G6Ap+jRWi6j22jgF8TRLHZ
         dUhsu17pNbk6Q==
Date:   Fri, 29 Nov 2019 08:55:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 5.5-rc1
Message-ID: <20191129085502.3e9ffed4@canb.auug.org.au>
In-Reply-To: <CAPM=9tz3pFTOO45pGcZv+nGf29He-p03fXHbG4sNoCYxZzXkRQ@mail.gmail.com>
References: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
        <CAHk-=whdhd69G1AiYTQKSB-RApOVbmzmAzO=+oW+yHO-NXLhkQ@mail.gmail.com>
        <CAPM=9tz3pFTOO45pGcZv+nGf29He-p03fXHbG4sNoCYxZzXkRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZHBqmpetsqfe9gb0w_/ensF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZHBqmpetsqfe9gb0w_/ensF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Thu, 28 Nov 2019 12:37:06 +1000 Dave Airlie <airlied@gmail.com> wrote:
>
> > And apparently nobody bothered to tell me about the semantic conflict
> > with the media tree due to the changed calling convention of
> > cec_notifier_cec_adap_unregister(). Didn't that show up in linux-next? =
=20
>=20
> I can see no mention of it, I've got
>=20
> Hans saying
>=20
> "This will only be a problem if a new CEC adapter driver is added to the =
media
> subsystem for v5.5, but I am not aware of any plans for that." when I
> landed that
> in my tree, but I assume the ao-cec change in the media tree collided wit=
h it.
>=20
> But I hadn't seen any mention of it from -next before you mentioned it no=
w.

See https://lore.kernel.org/lkml/20191014111225.66b36035@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/ZHBqmpetsqfe9gb0w_/ensF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3gQjYACgkQAVBC80lX
0Gw+xQf9EfqDG+hyyKDMpFDzsioShRwkxiEQQdwY7wriROmDZYr1asgEseGTmxRZ
XepkDQjhuiosXW20SXUuD74auSAQ3t6DZei+0vAuK9mbuJmg39j1apLLpZPswRxr
eDullesmFbIfwRMllaeMlHg4lMS0TopOfUY6GHOub01X7LRPJd632LfDVNM1kwHn
kAsE0kY3P2WW1KX6dfcrqhZVZl4aLbo6y/keT7QV+812AkfIEcu6Opz2ziB2x01O
moQOiaFk33uIkwtDtYmBGbin5Fc/+42YW521nqD875/qZbbCouFBpJdb0Zx4uLR9
NdRbw2cUQZTK1N7XuaEhvVN9X/LENA==
=pRe1
-----END PGP SIGNATURE-----

--Sig_/ZHBqmpetsqfe9gb0w_/ensF--
