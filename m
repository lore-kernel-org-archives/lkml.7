Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F8C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2845421882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AJ0ojO3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGDCCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:02:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfGDCCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:02:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fLpP3X6Pz9sBp;
        Thu,  4 Jul 2019 12:02:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562205757;
        bh=v6K3yot/bH7FrUBtKBKdelIeLLFR9NCR+y1/8vmqsM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJ0ojO3ktorI5rAlyZGi2PmJ+iYLU8uJTIuZo7ji1wU9zrCBPWnIcImH+sbALu4fQ
         hYu6M8MW5BKN+iCB2Q0g/7rcaW3f8fNcFG9jBrGi2VYYQXZcp2IlOJrDi/n8JwZR5g
         EeozRnvh6P2G+CNkVVXRrWTXzkzHeG72hdTqgehlC/G+tqLNPH0qbTH8x3p+e2Y3ZF
         /2tsyoQ3Zo29nozq+kENMM3mhb2LIVBzwMQQmtY9Ygknn3U+pM1DdRxRcf1n9hO2D8
         e64CcdAv9POblSLU8WEdhmHxPiOAVx8b9Vt9M4NcGA80xasn+nWgVpmN1RA3Hdb+mF
         By30EEqyeC2Xg==
Date:   Thu, 4 Jul 2019 12:02:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xi Wang <wangxi11@huawei.com>, Lijun Ou <oulijun@huawei.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20190704120235.5914499b@canb.auug.org.au>
In-Reply-To: <20190701141431.5cba95c3@canb.auug.org.au>
References: <20190701141431.5cba95c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XOFE2=SUf+b5y3U/JINby9_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XOFE2=SUf+b5y3U/JINby9_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 1 Jul 2019 14:14:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/h=
ns_roce_ah.o
> see include/linux/module.h for more information
	.
	.
	.
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.=
ko] undefined!
	.
	.
	.
> ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1=
.ko] undefined!
>=20
> Presumably caused by commit
>=20
>   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
>=20
> I have used the rdma tree from next-20190628 for today.

I am still getting these errors/warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/XOFE2=SUf+b5y3U/JINby9_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dXjsACgkQAVBC80lX
0Gz/vAf8CLlFKWuUavsZiQWa89uCGubOf8B9azXRtXDxDM7ViNLaJujCnEFmpofK
7KPSL2Rf0fsO16Pqe+9A+a4mZbJa9Iv6D+mxkwCkWXmQvB6Pw2Q98TlBbT/ZJB/e
XmlVwjvpol4F/NnqCk8DnlHg6LXXE7v2DXS4r1rMOj7BhPwyWs6EsklmoGWWgLPt
wa5GXk7BQRsgGlobvQ8OFXGTBxv8QtK02dyPR6i3tdyc8IsQFuV+ObnA7KDUZ3uO
HP8FYV+Ua8hl1yRKvaBGUc0DxJ9qLQ4KkM9K8AEPRQUHKRwEbqNth91is67H1yEo
W+1oPPuPW9OGOo2gurqqbDf5EVwx4w==
=6M1t
-----END PGP SIGNATURE-----

--Sig_/XOFE2=SUf+b5y3U/JINby9_--
