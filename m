Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12B6C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5FD21707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sWUOdSvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGIAQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:16:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfGIAQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:16:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jNCw1H3wz9s7T;
        Tue,  9 Jul 2019 10:16:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631404;
        bh=nk3neh4Zo9aogHly5OJsf0d91N2BmN+veRQb05n5YSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sWUOdSvKNY6HWxGpdJ0DauB58sZrxhjlSSCz9EwP339xXsEhg1qirSoYmU7zbMKdB
         cY+kYsyLwLswxO6FfOQ/h2OQTtypXS10oXYV5FxiAFQ3fmJWqZDteIlten5aqMww6V
         ve7fkGPgoLHF/ufNa1G1MXeO8Fz6OohjyAzW+1UnfABdzQNUAOnrytSGkL5Lrupw8I
         MtrbXNsfomFAVhhajJlh77e02igoiRVdrXyxVsi6Xxre+GGg6qqUr/aqIQXYhqpmqQ
         UidiAn7fKO6KhL7GproWbJKvgQw+yHXBzuf3uv7BdJpm6CmxwgtGjNy2Zl29/DLNru
         23YNKOcyNvuhw==
Date:   Tue, 9 Jul 2019 10:16:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fredrik Noring <noring@nocrew.org>
Subject: Re: linux-next: manual merge of the dma-mapping tree with Linus'
 tree
Message-ID: <20190709101643.335abba1@canb.auug.org.au>
In-Reply-To: <20190701084213.1056beab@canb.auug.org.au>
References: <20190701084213.1056beab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3PLp19x1hK.Lb_kp0Dl=kLQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3PLp19x1hK.Lb_kp0Dl=kLQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 1 Jul 2019 08:42:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the dma-mapping tree got a conflict in:
>=20
>   include/linux/genalloc.h
>=20
> between commit:
>=20
>   795ee30648c7 ("lib/genalloc: introduce chunk owners")
>=20
> from Linus' tree and commit:
>=20
>   cf394fc5f715 ("lib/genalloc.c: Add algorithm, align and zeroed family o=
f DMA allocators")
>=20
> from the dma-mapping tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/genalloc.h
> index 205f62b8d291,ed641337df87..000000000000
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@@ -122,47 -116,21 +122,56 @@@ static inline int gen_pool_add(struct g
>   	return gen_pool_add_virt(pool, addr, -1, size, nid);
>   }
>   extern void gen_pool_destroy(struct gen_pool *);
>  -extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
>  -extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
>  -		genpool_algo_t algo, void *data);
>  +unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t s=
ize,
>  +		genpool_algo_t algo, void *data, void **owner);
>  +
>  +static inline unsigned long gen_pool_alloc_owner(struct gen_pool *pool,
>  +		size_t size, void **owner)
>  +{
>  +	return gen_pool_alloc_algo_owner(pool, size, pool->algo, pool->data,
>  +			owner);
>  +}
>  +
>  +static inline unsigned long gen_pool_alloc_algo(struct gen_pool *pool,
>  +		size_t size, genpool_algo_t algo, void *data)
>  +{
>  +	return gen_pool_alloc_algo_owner(pool, size, algo, data, NULL);
>  +}
>  +
>  +/**
>  + * gen_pool_alloc - allocate special memory from the pool
>  + * @pool: pool to allocate from
>  + * @size: number of bytes to allocate from the pool
>  + *
>  + * Allocate the requested number of bytes from the specified pool.
>  + * Uses the pool allocation function (with first-fit algorithm by defau=
lt).
>  + * Can not be used in NMI handler on architectures without
>  + * NMI-safe cmpxchg implementation.
>  + */
>  +static inline unsigned long gen_pool_alloc(struct gen_pool *pool, size_=
t size)
>  +{
>  +	return gen_pool_alloc_algo(pool, size, pool->algo, pool->data);
>  +}
>  +
>   extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
>   		dma_addr_t *dma);
> + extern void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
> + 		dma_addr_t *dma, genpool_algo_t algo, void *data);
> + extern void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t siz=
e,
> + 		dma_addr_t *dma, int align);
> + extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dm=
a_addr_t *dma);
> + extern void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t siz=
e,
> + 		dma_addr_t *dma, genpool_algo_t algo, void *data);
> + extern void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t si=
ze,
> + 		dma_addr_t *dma, int align);
>  -extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
>  +extern void gen_pool_free_owner(struct gen_pool *pool, unsigned long ad=
dr,
>  +		size_t size, void **owner);
>  +static inline void gen_pool_free(struct gen_pool *pool, unsigned long a=
ddr,
>  +                size_t size)
>  +{
>  +	gen_pool_free_owner(pool, addr, size, NULL);
>  +}
>  +
>   extern void gen_pool_for_each_chunk(struct gen_pool *,
>   	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
>   extern size_t gen_pool_avail(struct gen_pool *);

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/3PLp19x1hK.Lb_kp0Dl=kLQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j3OsACgkQAVBC80lX
0GwB7Qf7BO3NB8TpO59WmIdVTpF4aDnBv/ofbhm5xXFt/cZB47Vo7RRlWo9DfKdt
ub1WPHC4BB0ATu2ZLhEY78wv5dZoJONADjeBpl9HUKuHp8tm53vmUCVh6bzSpnJ4
XeAo6JJNZo3M8gx/I0fny2DGIRY5H6PuLQ6LKADjaPu3lbb1TtKMSV331OE1seVH
K4xmjAvIaSAdYkZp8iS0oZ48Ck7X1VUw4ZbkZScsgR981QkA0vUNFE9Fo7DktWSs
ykweaxFQGY/sSiWKO95/rnczkR67y8Js/iOKQboiQi4PeY+EEmFiE+BmPgKORd/t
CKSyb9QzQZFeeGonWTqP/hF2mB8Meg==
=+n3i
-----END PGP SIGNATURE-----

--Sig_/3PLp19x1hK.Lb_kp0Dl=kLQ--
