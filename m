Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01766C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DEC20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D2dBE2wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfCYXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:09:20 -0400
Received: from ozlabs.org ([203.11.71.1]:35127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfCYXJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:09:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44SqhY2Xm8z9sLt;
        Tue, 26 Mar 2019 10:09:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553555357;
        bh=cRUFqoH0op7+prSsanEt6lE7bK2rhY6jOlXhP+MgbS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D2dBE2wBAULw8SnCSre+qpmHpxAO86D2DDqTEHGF1lGcQS5lu9fs91RYflg4rsNpf
         PKbEneLGv/1sG8YH/7nD8+IO1UFSQP3aUgax6cVDiYV3lbjkWxUanBXcTqUqExSN3e
         jrSzUdexJKYEfBaBgybPfC7NX69w4McvkM+Jo/Hl0QETmb1n8olddfrMvgwpcPLc+T
         8Nbj1bt1QeoOt8pBGKJ6odXdHj7CYDG4dyoR6CU7g+MhohF7k2s6U0Y7twMDlo2MsH
         EwYP3kNK5DEtr0o4xxev7U80iikkjIc9t3Gp5LeZymg7Ku/nP6kJgARpcyvmuzYQoh
         p/aXRbbn2V82w==
Date:   Tue, 26 Mar 2019 10:09:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sunxi tree
Message-ID: <20190326100915.3fa1e4c9@canb.auug.org.au>
In-Reply-To: <20190322083048.31084cf8@canb.auug.org.au>
References: <20190322083048.31084cf8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pvwmm6ZF_4jU5TbsfpW_ZHY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pvwmm6ZF_4jU5TbsfpW_ZHY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 22 Mar 2019 08:30:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the sunxi tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>=20
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN6I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
>   - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN6I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
>   - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN6I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
>   - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
>=20
> Introduced by commit
>=20
>   49c726d55c1b ("clk: sunxi: Add Kconfig options")

I am still getting these warnings.
--=20
Cheers,
Stephen Rothwell

--Sig_/pvwmm6ZF_4jU5TbsfpW_ZHY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyZX5sACgkQAVBC80lX
0GwnGgf+KwAyLaPwYOeCFAgclduhWxifha74rgF0zp7ZnaP0aTrn5etAgo+5bTpL
pwJReMsMcPy4NT1Y6RE95UtDplZMLM1w2OwRteXO6zKFF3Kef9eQx2IM9Q5UhPVb
SV0eJyXJcLMT9N8DDybNRhwm7H63zNLXzCe8Zffqj8QvCnZTXUybYKRwGuz+YlaV
I4gmgKNv1rqsKRDohjUfUFfgJVUg1dwe/8Ht//lh4k7t67NITsBuIwY4oE7FQsDb
ohj8UP0jmRyzPsOjn5zsrByeLXkt5XHCVMSOGxnHtFvRwrgnebnnIQGsv6AQ7PC/
PaTm4guRvda4bzrPSnbiDoA/UFZZIA==
=s4Bq
-----END PGP SIGNATURE-----

--Sig_/pvwmm6ZF_4jU5TbsfpW_ZHY--
