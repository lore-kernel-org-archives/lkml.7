Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA07C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC450206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JV7Mn5/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfDEGDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:03:54 -0400
Received: from ozlabs.org ([203.11.71.1]:50973 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfDEGDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:03:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44b8QG1kNCz9sPf;
        Fri,  5 Apr 2019 17:03:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554444231;
        bh=f2D7It/v5u6PAhjPO6XUeN8evHMXIol6lRXaqU+h4Vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JV7Mn5/xeUz2XVMQQsUxNTCNP5fLNDGW3tg3P6M+miBXi/l8EQ248dDen4DAEbzCl
         0MsNHwLkBioS/s6OzsgtESr6FMS48CGrGBpsx0ClK8x4NHLkuYqm2QKJa8Z2lXDar3
         EvPAurwD18nf19ciQNU08+VQW3qjou7YOpQ04b/rJZG0omHCfWXBYeObSn8BYbdB+q
         8mlut6l9ZkYEYcdbgNyx6gMS3f/MlpAhzQ5e2mGPo5jgzIWac+KTqmJoG/F7asqT0D
         bgJhMa1obb7UnkutHTOTDq785hLHsq4PtU6cSBLby6I93Hnpjm5HKdta6yAQUrX0db
         D0w5nOMWGxRYg==
Date:   Fri, 5 Apr 2019 17:03:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190405170349.687cd08c@canb.auug.org.au>
In-Reply-To: <20190405155550.5648e84e@canb.auug.org.au>
References: <20190405155550.5648e84e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B_7E1h8ne1BDtkR9dSqkofC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B_7E1h8ne1BDtkR9dSqkofC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Fri, 5 Apr 2019 15:55:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the drm-misc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> kernel/dma/contiguous.c:19:10: fatal error: asm/dma-contiguous.h: No such=
 file or directory
>  #include <asm/dma-contiguous.h>
>           ^~~~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   4f2a8f5898ec ("drm: Add ASPEED GFX driver")
>=20
> I have disabled that driver for today (by making it depend on BROKEN).

I noticed that this is now in the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/B_7E1h8ne1BDtkR9dSqkofC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlym78UACgkQAVBC80lX
0GwNTQgAnYfBPX73VFrHb2Z6GE/xGiXWT4e9EEWJmt8vk0UqXKDDh723AXzGaFwa
crVoEsk0odWA1RHMt1GIYPs56CjTO066IDNAgp7QvJmtHJ58PpCHSJGzDRZdq9Mu
TVyRQ591Ti4xCerOkGSvNyxiwyyK2vy6DI8VGJ4q1jeX+UykQpBWy6hwgAFCEuoh
SolLEEuWKps1ZP21w3CgnU8ol0MEGUHXEbjj/Xb1Llf2Z0xXg/U7zpSOI349ODAq
9KJIfTEO3F/MJmQLpdTQ7YyZ0hBHwEm9evWHNIY6i8D+wSteQ+Efx7ZNtgbam+fd
Bu+7MsJkr/N4CPz4S+0ofhhPadDmDg==
=dPAB
-----END PGP SIGNATURE-----

--Sig_/B_7E1h8ne1BDtkR9dSqkofC--
