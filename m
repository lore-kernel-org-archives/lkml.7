Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF9DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51F820651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dUdXhGJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBWDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:03:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49469 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBWDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:03:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44w8R95MJ1z9s55;
        Fri,  3 May 2019 08:03:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556834615;
        bh=1XcVg5iNreGDjZX9Sk7gu3lAAG04wWFYAfB6eyN8v3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dUdXhGJ4ltYtHDdPmiGKMf0AyvqIUDJJIolhkPUNyLhAqU0gvQzfla5r0rvqzzwpS
         0ODTvAIW/g6MjYLDLJtatLUqHaXDXcMTEJYTwg52yE/AL1Au2PINbMrMeAEKTnqEP4
         A7tSP+7ky10MqU+CEvVBqTMdElz5KWHt9HrMGtopVOMlW3tk2h7UCviw6fHeerxtU5
         5bFmcgao1f9U7G6EdG2rSk5l+0Ur/+ALZG6OMy6PT4hogjxXeR1O4ASVBHNtetSjGR
         WOrL69LB9ZcNOaLjWX9GcXawY2CscYn6Uh6xuz1rxnKDBEwGuZwzmq5U5l6htixnrp
         tjqj19wK5DwnQ==
Date:   Fri, 3 May 2019 08:03:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        maxime.ripard@bootlin.com, andre.przywara@arm.com,
        samuel@sholland.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for May 2
Message-ID: <20190503080331.0ccc2419@canb.auug.org.au>
In-Reply-To: <0a28f5b8-296a-451c-c2f4-c0057833fb00@linaro.org>
References: <20190502201028.707453d8@canb.auug.org.au>
        <CADYN=9LHJpDyvA=3wkcqdS5f3kahD0vdXFY415k8UmLHMDzL+Q@mail.gmail.com>
        <20190502190845.GA19485@archlinux-i9>
        <0a28f5b8-296a-451c-c2f4-c0057833fb00@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LDFhNINO6Q+CN8C=9JPJzpA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LDFhNINO6Q+CN8C=9JPJzpA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, 2 May 2019 22:09:49 +0200 Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>
> Yes, I picked the patch and it was merged it via the tip tree [1] as
> requested by Marc Zyngier [2] and notified [3].
>=20
> In any case, this patch should have go through my tree initially, so if
> it is found somewhere else that's wrong.
>=20
> I did a respin of my branch and pushed it again in case there was
> something wrong from it.

The patch ("clocksource/drivers/arch_timer: Workaround for Allwinner
A64 timer instability") was merged into v5.1-rc1 via the tip tree as
you say, however the version of your clockevents tree in yesterday's
linux-next was based on v5.0-rc1 and contained the patch again ...

Today's should be better.
--=20
Cheers,
Stephen Rothwell

--Sig_/LDFhNINO6Q+CN8C=9JPJzpA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLaTMACgkQAVBC80lX
0GwK2gf/T46LsHptfQcVHZYq0BKp3GlqA/KAkpndiWhiqzVF4j12VWKizW7fskBG
jO6IQiEjlLugRilJxK8AH28UtkvETvLaiMeHBBGjxW4rvOpkkeVymsCZkVmGnNc/
3Ywm6kkQWQ8bn+h1jmeSKm35+kNepC7Xa9/ll5ParMz0bsBoeKQ+p8Au0uLroEva
DzGfgXq3m/5eihWwMlNcam7Kb6OjnN1+T9ArIg78y/UviaBvecBkzGsvJYJ07Nk1
dwjNZliVpesEDiDT1iFMGcStQ04SEhZ6Cu+F1cSvL+LRoA1Pyjscp7ITP5/NQLuz
mNJCgqfarwjbRYd8jPf/pXwpfT5q5w==
=+AWD
-----END PGP SIGNATURE-----

--Sig_/LDFhNINO6Q+CN8C=9JPJzpA--
