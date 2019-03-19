Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E595C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3367920989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SqEPV5Li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCSFV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:21:56 -0400
Received: from ozlabs.org ([203.11.71.1]:40747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCSFVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:21:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NhHh539Rz9s71;
        Tue, 19 Mar 2019 16:21:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552972913;
        bh=qzmjTq4AkHhNfxXFWfOd/4+AxoJ0tkPqg+KkRpO82j0=;
        h=Date:From:To:Cc:Subject:From;
        b=SqEPV5Li+k+iK58xB3+zlRHlt9uIC4QUS2imaMiHr1Omf9UR9JXUCr9eY91eV1PS6
         9nN6nVrMfaheMVs8EegVF5UZbT5ypZLcjKEolKAqRkPg4z80tt1PmqmqAZ5ZQNPEp4
         U01xxwBFAS6zUrHBtChG0SleVbe/dDwOchumECRjByeniu9V7v4ZceBczXocSbrY9F
         YaVA84x6EuvaD0ozPQlnlHM/KYDIFzNwIOW3a2u75miapg9iEIJmE5WIyo1RzVzZYr
         3piRALFNt2sg8SHnkGhT7qgzyfWmFSUt0Tiq3hqXwpMNtPX6U2dxiVeE4JcPORDbI8
         gBegT/l3M7d9w==
Date:   Tue, 19 Mar 2019 16:21:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "Suanming.Mou" <mousuanming@huawei.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20190319162152.102d98d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wzK3DhsIfkktuZC/W=28rah"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wzK3DhsIfkktuZC/W=28rah
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cc4807bb6092 ("vxlan: Don't call gro_cells_destroy() before device is unr=
egistered")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/wzK3DhsIfkktuZC/W=28rah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQfHAACgkQAVBC80lX
0Gy2Egf+Lut+eekzPkamFTUU31A/3EHI2ZxLDdWWksBtyutAKuUzLJxDHxZGmkJo
X0kBNKfX6oR1q4kdflxcr9X1PHWbSESto9r2neOqPmFPGDjA1gscWfWMAMAwsLQn
6HTg8MNeXHFxloXImL1z5W9N1abzSa8n9xxTVLxH9nK/e0ozqYa2alKMq/YVmUwA
5LLP0R8jAOLTeCoPVSYrO2mWAafYI/neJMvlNXx3UURKmuPzsLJURk649zuD+NUC
Mvp8sfhtnlRQ2lqnDtNXU8hIFuOt/XhFoZbhjI89s1voRqWxNlENffxcmWWasQOU
81HjottsmiQFQojA0Mp8sFVWsXNIUQ==
=vYAJ
-----END PGP SIGNATURE-----

--Sig_/wzK3DhsIfkktuZC/W=28rah--
