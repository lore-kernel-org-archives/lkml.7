Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F54C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A184C2184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bF6cVxv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGEO7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:59:39 -0400
Received: from ozlabs.org ([203.11.71.1]:58813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGEO7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:59:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gJ0Q6Tnfz9sNs;
        Sat,  6 Jul 2019 00:59:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562338775;
        bh=wW9hZ97MJH7zAQcbUrtAds4nhk4mkT2TvGNtHSDHti0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bF6cVxv2TO879uxrz8AFPqYei/M35mKxoOBaLxTz1rphHDPneeYW3mY+Amm2ubmTJ
         zwuz59RzuLNUXLUBV+EMdrrFe9YgyKM6GoZWD/ylriQiag6MlPhMx0JwDqsbByeTKC
         Ir3Pgu7BDaeEryMmZcyzNoRn6THd5Z+ur3A+05jTrPRrz7RMy78C7bRBPw8rQPK1G8
         CJoT7wh9vI1WD3pODRafSLOzkuzS0R/EdhHje90UqPSRoFFXzRp8nGcMmupJWkCstX
         Lt24doO8nlBobJu749G8rQxQ2RdbBFvUUePNVrJRvl9KDUwlO0o4ilnuFXl2B9Wgwm
         X8Q4y9Zm8miFQ==
Date:   Sat, 6 Jul 2019 00:59:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xi Wang <wangxi11@huawei.com>, Lijun Ou <oulijun@huawei.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20190706005934.66925686@canb.auug.org.au>
In-Reply-To: <20190705131520.GD31525@mellanox.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
        <20190704120235.5914499b@canb.auug.org.au>
        <20190705131520.GD31525@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fnMEpeFDt4zxXBm+1pmjaqF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fnMEpeFDt4zxXBm+1pmjaqF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, 5 Jul 2019 13:15:31 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> It should be fixed now

Excellent, thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/fnMEpeFDt4zxXBm+1pmjaqF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fZdYACgkQAVBC80lX
0GwSlggAmZ6yA5JgRPxfwb6cXj1KXTI15CZcL21+urL7fYxPwlZ2On4/nES+k2Cl
39SztSovaTfr5+1+PZEm+c/7haSAG3JMIoj9/Gzpj05BcJ7X0BefZE1ll1Yntndf
zkAMlyOgtXmVzxdDuSGHHtjQbS2nqHogTFAV8iScMKiAexsjqG2gGuqaPx6GMUGz
amFGuEm9AQqF+i5/55b7EDfNqHEHd7nPkxBu6iH9hSOgDZBgDjQBLlJuFh7XDmDy
3ueXhTIUdMwnV9U7zG86nNQ0BrlVfMwWLUnri2IEielDKjFYxOvtVGdLABOpzsjc
lIvGV6IAWHpESSMErYIvtlY7dcV0yw==
=DTuf
-----END PGP SIGNATURE-----

--Sig_/fnMEpeFDt4zxXBm+1pmjaqF--
