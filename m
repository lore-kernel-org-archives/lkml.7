Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851AEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sA0I15Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDIVWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:22:49 -0400
Received: from ozlabs.org ([203.11.71.1]:45473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfDIVWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:22:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44f0cj2GJNz9sTc;
        Wed, 10 Apr 2019 07:22:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554844965;
        bh=9IK4OUkGqdGV47oGAdI1QtMfqxRd5L75CXMARq0N46g=;
        h=Date:From:To:Cc:Subject:From;
        b=sA0I15Ibadk85OAoCEcSVynXVdeuAQxHjF7h8nRlFuak3l/tCGNWtx+7rQbmWdVOz
         zrZ2NoVUW+0Pa9+kmdT/jnv/OfU5xRtIWTgTqAx8a681dU5rLM+1jTeIq6Oc1OhrVD
         4KpdtVp8OyG3VVfgDhC7o5WL+bfxTXpHOj5AbDy8QCP2jXGOCPFE4e5JK4GiUJTnnv
         HS6qybx6dePC6814vX65Q91YbvmSJArkcOy1buQ6a/P1kNVK2JmipN1Pf6HaYO/pn6
         OJC5XUFU99KvZ7Cj5QHr1GPJqYxrkUq5cN8YH9C5VZgmlijEUxGnDoedkT7AgRR35C
         Y/hcO2KYQD9Kw==
Date:   Wed, 10 Apr 2019 07:22:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: linux-next: Fixes tag needs some work in the rdma tree
Message-ID: <20190410072243.085d9811@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a1yXBXPTbE0Rmg0fjFH97Q="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a1yXBXPTbE0Rmg0fjFH97Q=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b5efc447c650 ("RDMA/umem: Use correct value for SG entries in sg_copy_to_=
buffer()")

Fixes tag

  Fixes: a4ca56b2b416 ("RDMA/umem: Combine contiguous PAGE_SIZE regions in =
SGEs")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SG=
Es")

--=20
Cheers,
Stephen Rothwell

--Sig_/a1yXBXPTbE0Rmg0fjFH97Q=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytDSMACgkQAVBC80lX
0Gx/Zwf/eiuiRjzriGtVJaBBa/RTA9uWMMnD5wQ8F4e1H024QY4bwl3yP432Wb4y
63UAAHSHK6CFgj2j/RVwrNDXu7XfGR/yDiCHofnCaTBdNNZYvB6CzfRBJ1dU77BI
U+ib66Io9RVKVLgAk0EAPJeCI9UhQ0IqLaHdtgAO6b2u+3CQLxl6cG3Jhoi8B8db
LkymLjzhGBVcKJIFHn1mrWS9VgjZiERJawJkiud56udU7U+QfEaeWGGFdJhh8oYP
zh8pf1Ct0hZMdSjQHhvrIyxEeJ7KgL9vcpfZHXSi9ougKpPqZp+tIjnSqOxqDlwV
vjp8jzlFb38xdPLDhx9K98wOvKoXnw==
=tnql
-----END PGP SIGNATURE-----

--Sig_/a1yXBXPTbE0Rmg0fjFH97Q=--
