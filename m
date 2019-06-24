Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE6EC48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D261222CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ue29gswp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFXBpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:45:42 -0400
Received: from ozlabs.org ([203.11.71.1]:57055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFXBpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:45:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XBvR0PWJz9sPH;
        Mon, 24 Jun 2019 11:45:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561340739;
        bh=zkSCkl0gojgWBGa4Stc4JAW0V93TLweT54wrJwAyYuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ue29gswpBZzY3FyH4Aees54n7ClB5v/jT1OPIeJS9tIsZxl9y0ZsJdkNTMZsEToEN
         8nUUj0nwzZ8ocr7g5x8f2i+oTP9usbB20yXG9ghAKGIf5V6bRUWxUhtB4K4jEVPW/8
         96eAs+h5QP7wgSmI4W5WNwMj3GdqAe7IEOAEJtBXhqePVh9ONYLHX0bFZsMjLLT7w7
         M0ZW4IwLdwAe7sQtOtQmpUthFqVdU3k6D4ICyHtGcumeKfCmAxaEWfhPSrcMJpDIIP
         4IYf62TOWslk7oeDYOK9EDstyES+wNDOl48VSag/tcqkgxK3hm0swXXRNGkyHqU+O0
         FiGIGGz78qbcA==
Date:   Mon, 24 Jun 2019 11:45:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: linux-next: build failure after merge of the fbdev tree
Message-ID: <20190624114538.3531b28d@canb.auug.org.au>
In-Reply-To: <20190620114126.2f13ab9c@canb.auug.org.au>
References: <20190620114126.2f13ab9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ra_kr64igc2JlwOFNmOIoXv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ra_kr64igc2JlwOFNmOIoXv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jun 2019 11:41:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the fbdev tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> x86_64-linux-gnu-ld: drivers/gpu/vga/vga_switcheroo.o: in function `vga_s=
witchto_stage2':
> vga_switcheroo.c:(.text+0x997): undefined reference to `fbcon_remap_all'
>=20
> Caused by commit
>=20
>   1cd51b5d200d ("vgaswitcheroo: call fbcon_remap_all directly")
>=20
> I have used the version of the fbdev tree from next-20190619 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/ra_kr64igc2JlwOFNmOIoXv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QK0IACgkQAVBC80lX
0GzcHAf/VUpCFCvenu72dL0otq+Q2xsvwFA3yZB9A/w6ryZ81uyHbb2or3VepFLO
ACNP9YtTPxFdm01V1aFCpzHhtM2aO2PGpRIdaBWz7HkCtz6msZLZqwsJdMtg1qCX
oqaxTCv8G9KQsneroeAOTWN/3D67AAK80nk6AmG4e0Q7RANGtR7+pG8iEWUGF9OG
D9iVw1LYEeDLZ3fryaWLp9MOLwGAdUOccjHcd+Ryn3ZmuIdu9OZA6fsrkmMT00SG
9uvovFqHUHniGL7aBn1APMHAlEHfIlHFu45GKHTRqr6SG23HcSuPu3/eXmNWMrd4
Lz0/9u1aiUULq3ng1f4VD0MBTz5Ihg==
=I5dT
-----END PGP SIGNATURE-----

--Sig_/ra_kr64igc2JlwOFNmOIoXv--
