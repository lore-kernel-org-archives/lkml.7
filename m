Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA502084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tn/ECxD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDALgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:36:31 -0400
Received: from ozlabs.org ([203.11.71.1]:42921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:36:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Xqzv3TVmz9sQr;
        Mon,  1 Apr 2019 22:36:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554118587;
        bh=EbvZrga8PqS4dOHkrS2Qu0uC73Q5jzPRYW2pFQoC0X4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tn/ECxD7UxQqeG/05AZZv/HfpCHXzQkKKSRz9twuwJydocIx+iBImdNGwpGFBTc+l
         mnwEqSrg4PRWHtl45L26DUtZs1npx4g6C7zzqqfUaE8l1EplzyPmtuFW0e+PYgR+Tn
         ju5F9JivrAOVFJlkRSqjO3zwHZt6CjbL8kl5BKsmopSLcjqqUxk/BjPdGYibNPCtXA
         NL9XrAtjVLMdY7GlCdvu5gGBXTG0+U9now8I3e/W0qkz+2KDdcMCQxj1vpOocrN/vV
         JpzB2SItK90sWVZW+/D/NGeVy4rJoOiz1uiRsO7ZCYRfvI1sKU97SQXmiDrGQVt8I6
         KiTlTMEuTWiJQ==
Date:   Mon, 1 Apr 2019 22:36:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: linux-next: Tree for Mar 27 (sunxi clk & mfd)
Message-ID: <20190401223624.6b4f8c42@canb.auug.org.au>
In-Reply-To: <20190401102732.GD4187@dell>
References: <20190327145020.2fff97b8@canb.auug.org.au>
        <641a04ec-e2e6-4263-e77e-d272058c18c9@infradead.org>
        <20190328095036.734adbba@canb.auug.org.au>
        <20190401102732.GD4187@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TQEStlbOBWCvct8AwL66QLQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TQEStlbOBWCvct8AwL66QLQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, 1 Apr 2019 11:27:32 +0100 Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 28 Mar 2019, Stephen Rothwell wrote:
>=20
> > I reported that a while ago (x86_64 allmodconfig after the merge of the
> > sunxi tree).  Apparently there is a fix out there but it hasn't been
> > applied yet. =20
>=20
> Where is the fix to be applied?  SUNXI or MFD?

Well, I only see the problem after applying the sunxi tree (which
happens before I merge the mfd tree).

Maxime said:

> I've just sent a patch fixing this:
> https://lore.kernel.org/lkml/20190322091650.5189-1-maxime.ripard@bootlin.=
com/

So maybe if you (Lee) acked it, Maxime could apply it to the sunxi
tree, so we keep the breakage and fix together?  Assuming that the fix
is acceptable (and works :-)).
--=20
Cheers,
Stephen Rothwell

--Sig_/TQEStlbOBWCvct8AwL66QLQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyh97gACgkQAVBC80lX
0GyxLAf/bFGw4fX8AubeNHrIvatp3/buMOEzbllGr7f9Fb6GNcEk5KrQZ41JrB86
eMw0kKGbelqGGBE1Lq2T5LvdsWataFx2nQGLy4hyX/sIPgq7p7BF/Qj9kwcgAehF
kgPfvpcmOZ1xYnbq6YG1CCKKDpTCnD3Nm5IOCFVO0FjHfuzQKUQ24S0Ua+Ieq4gk
EHjLZIGdK99j0RZKM1Z1zzzw4mzQRJ3eL2FsSTjfMNj9X5DmPstlnoYi4ZmA8l+/
4NxDc1htdOczmfG9cSxv/lqFUXIOIoa7HFElS71xBB81s9erFvRkw5v+DmdllGwh
CaOI1qJZXmQFCpqOR6CUf9tUnwmuFw==
=uXY6
-----END PGP SIGNATURE-----

--Sig_/TQEStlbOBWCvct8AwL66QLQ--
