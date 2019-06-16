Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB4C31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A7C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Jyiw9FB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfFPNYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:24:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfFPNYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:24:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45RZnD39HNz9sNC;
        Sun, 16 Jun 2019 23:24:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560691456;
        bh=K09dk6Vf0k5SGjThD1s9PCHJxWBI/O+5MV9so/yJjbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jyiw9FB9vNjGNyT/IkByhDewK/hQA+9ULF4FHKLrv1vTauT2ccJLZmMMtUnjjXVo7
         g2fUMmH5LwUrN2tHxGZIaGIitKBpHOvdO9vQgNzvhlfKDLtW0wGlLK1KyEADZ2Gikt
         fcZ/EbLg6GJXXe975EITwbBbP1aAMvrX8HJrzY8/yRUfaTNrn0uTRU60RwT8X0ahSX
         ZxBcSD0HtJW5a3mExhMs2+wZMiPujN1ApWJ5/D8FIZdrCKbL5ykHpSAbf21HTzY+2b
         vM8DV+Wc0TP7/Qll78O6CUtqlWM+A0HBQ22mmswUpBXe+dfmI9axni4gZMQ+J1lUhV
         dNaKeO2oFE2Hg==
Date:   Sun, 16 Jun 2019 23:24:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the clockevents tree
Message-ID: <20190616232408.7ca0ec1c@canb.auug.org.au>
In-Reply-To: <1b6c715b-5aa9-b0c1-d228-c99d2adc57b4@linaro.org>
References: <20190613090700.04badfc3@canb.auug.org.au>
        <1b6c715b-5aa9-b0c1-d228-c99d2adc57b4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/._Vh6uQmZOzqKWRQed7rTCQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/._Vh6uQmZOzqKWRQed7rTCQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

[Sorry for the slow response.]

On Thu, 13 Jun 2019 08:52:21 +0200 Daniel Lezcano <daniel.lezcano@linaro.or=
g> wrote:
>
> actually it returns:
>=20
> git log -1 --format=3D'Fixes: %h ("%s")' 3be2a85a0b61
>=20
> Fixes: 3be2a85a0b61 ("clocksource/drivers/tegra: Support per-CPU timers o=
n all Tegra's")

Indeed.

> Is it ok to shorten the subject?

I figure it is easier to just use the "git log" result and to give
anyone (or any script) the wants to use the Fixes tag as much
information as possible.

--=20
Cheers,
Stephen Rothwell

--Sig_/._Vh6uQmZOzqKWRQed7rTCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0GQvgACgkQAVBC80lX
0Gzb4Qf+N+TQ3mJEsiKHkgm8O75CQJFEYjVcDW//+OJv7BFi07RtFRGWlSyEu1f4
lVtqiAgQf5fcwHHb8VTjouQgV0XUtxXjVNg6KRIyEc/eHGFRXhmrUAr7bV3CA/LE
wCCWCfYhCfiTRfghBBsEZnlmThGx7Iyw4S1HpLFjoWqHC5hJPrt9kdd1I2lzxjKZ
6irXOUzVl3pPjPSIy0zRihsfPA+DfM2W0LKWMpRaxiIlv3bdsUxQyCXawnmijnmy
cUx9H7rmPjwtBrTOyaH3g3Id6IUK2hyOXC8tlnhGOGiG0AKkVueY0pqA58QhJkbm
VvY3AfWwUt5lPNRSetgs2VD+07F1tw==
=eRKn
-----END PGP SIGNATURE-----

--Sig_/._Vh6uQmZOzqKWRQed7rTCQ--
