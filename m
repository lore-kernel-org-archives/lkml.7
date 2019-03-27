Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4862F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iIwuV8N2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfC0Wu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:50:57 -0400
Received: from ozlabs.org ([203.11.71.1]:33819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfC0Wu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:50:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V3BN5wHhz9sR0;
        Thu, 28 Mar 2019 09:50:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553727053;
        bh=DG+ruyGeW4FpjNJbCYvuJiDmm3ruIB+VH5OlVJb5OxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iIwuV8N2vzeQl5xn+IgAIeM+J2dCnxEHTDx8D+WQiGMJa0YlR2N3QaPIKZM0AN+YT
         8H0735zaE01kMs4D4unCv8tfTah2wso0FONaTfFByHKEP7c+ZgKDa3qmrLqnVvZMDV
         zxsir7UQLvCCLXjnUa16JYwabH6+GXRGxdUkfIzBsss2ytGCXvgMGSJQIL3XemFUCq
         zXjH/f10MSy9SwC8wCeHMb8nXcbk6kf9kZtAGLcqNreE96FqqWnEJa9K6vyOpWCeyw
         9KtLY5rfv8tvZlEOhWUn3ezOr73VqkQoKxk9GDtuDHmCpnS0gkQPGnalMq1mTP4uOd
         aN2f7hlUJvXwg==
Date:   Thu, 28 Mar 2019 09:50:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: linux-next: Tree for Mar 27 (sunxi clk & mfd)
Message-ID: <20190328095036.734adbba@canb.auug.org.au>
In-Reply-To: <641a04ec-e2e6-4263-e77e-d272058c18c9@infradead.org>
References: <20190327145020.2fff97b8@canb.auug.org.au>
        <641a04ec-e2e6-4263-e77e-d272058c18c9@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2y/24R9YVVfBV9eqHhF_Wc6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2y/24R9YVVfBV9eqHhF_Wc6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Wed, 27 Mar 2019 13:32:26 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386 or x86_64:
>=20
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]

I reported that a while ago (x86_64 allmodconfig after the merge of the
sunxi tree).  Apparently there is a fix out there but it hasn't been
applied yet.

--=20
Cheers,
Stephen Rothwell

--Sig_/2y/24R9YVVfBV9eqHhF_Wc6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyb/jwACgkQAVBC80lX
0GzdgAf/eg6NADI6jioc4zeNy5YSgPVmpghBePkE3A5Lh5xJ1Ity/75vcaInsOLJ
O8fQm4eOn/mSyY+s18/nYXH2naVn5/ea5uszxmf9FplhaKRN14wvYiiupxg0J+mQ
Fk2EzLCuaxSTorJbdJ4i/nRmeKL4Sje+iMh9ZuNgom8MwFysfeSyTp0hoP8eWIvy
HvP5TBqDA9kLgV2XzKZ2erEELHDPp4Y5bRA5pgvEAFtQqZ/k2m+pEZ221fb62LMI
6iSf1wxAJLYHNCdDa0wTCUWO0QZ8yIqCnC5moybhF+taU0dJDR49wG7WcCeYGiIA
DwezjKXBNwRQjSmsnel1bm53HhXziw==
=Ibwh
-----END PGP SIGNATURE-----

--Sig_/2y/24R9YVVfBV9eqHhF_Wc6--
