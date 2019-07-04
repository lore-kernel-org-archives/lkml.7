Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCAC46497
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4AE2184C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PKUNdXaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfGDVIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:08:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfGDVIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:08:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45frDL267jz9sBp;
        Fri,  5 Jul 2019 07:08:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562274498;
        bh=uiKym7gdeDlyMdoWAy3bdqHaCGNeEnlC8k+Noqqs0Yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PKUNdXaXg6FqSKQOpFK/jvd0Jwon/XU7Pz3k704jZr9wWPZo35q+IH0uz/+zMSEoS
         eRkhnG4fyxCIMY+8iRse7oonn4AGOIxoGmpT4TLPgsG6h7gNNhiSlXMj/dwjcCGmBV
         Q2IlcMDt0w7GKqxpvkYIwMsyHRrRwzG1eykLKHJdDp6N1Jo4VnYsWWcTnJtN4PM2mk
         QSFF8dRHVwviQKy+7ddmcR5yCZVWP2NZywdb2N3zm1P3tvR/09a/B0dvGWS5Ct5h1h
         cHfKs6ZHQ5SZj3Uw3n8+8F5EyylgRfpHBlebJZ7hLgsyEdqFoJ3JA+mf/dyca0WBk7
         zjY/BrbQ7Trzw==
Date:   Fri, 5 Jul 2019 07:08:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Message-ID: <20190705070810.1e01ea9d@canb.auug.org.au>
In-Reply-To: <20190704132836.GM3401@mellanox.com>
References: <20190704205536.32740b34@canb.auug.org.au>
        <20190704125539.GL3401@mellanox.com>
        <20190704230133.1fe67031@canb.auug.org.au>
        <20190704132836.GM3401@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.mdJ876r_5mgmleKxQi6puG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.mdJ876r_5mgmleKxQi6puG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Thu, 4 Jul 2019 13:28:41 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> BTW, do you use a script to get these conflicting patch commit ID
> automatically? It is so helpful to have them.

No, I just use gitk and a bit of searching.  Though often there are not
many possible commits to search.

--=20
Cheers,
Stephen Rothwell

--Sig_/.mdJ876r_5mgmleKxQi6puG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0earsACgkQAVBC80lX
0GzS7gf8CTB2erFpQ9ri/9IBqbNwdjk/6yvzDws8bx1+yLuYWdWkGvoAxnjV2Ixu
uEoGvI+lg1O2AfNWa/NIcy1a8iqBkf/tFm7ZA6P7W1O7AIwp8VVL/rYEbMVe3Qjk
YlmU/t2cdAFfdfOPMRVbOcbCUrI9llIiqO+BeSM/up6x3NfeJuAl/AQiWwl4EQP9
u59RW+Im0Byq5SRSH72BmexZlIRaWqlEWMwWddGzkrrmgbX558LBxK+YuocW7+x0
NgTnZEFv4RMd85Xk58vXvCt+0DtgH+HqdA7bAz8++ccRg8Q0zYoiLWEJivffXnmP
DMBF2a5n1VXM+O28IqT0ChRuSKB28w==
=WSr2
-----END PGP SIGNATURE-----

--Sig_/.mdJ876r_5mgmleKxQi6puG--
