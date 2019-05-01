Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8731C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C022085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Jbg+GEkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEAVwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:52:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfEAVwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:52:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vXF43fYlz9s9y;
        Thu,  2 May 2019 07:52:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556747560;
        bh=qnz/9ptAcsBuobXUVKSqpT8XkQecU09ic3sbybNQz3E=;
        h=Date:From:To:Cc:Subject:From;
        b=Jbg+GEkGkkHmXfj1tLuLc1EdqH5DkD4NtRsmMj3HTgYTjGzPWLrydxlmnYC8keKft
         /tf0FaNkJx/IxQaG8XCQNIgXlZwujotOPbh9oVunfo8mT8egz93JM+aH8SBI4gi55B
         4gBsXhMv4FB4g+SAEQIkoiCg4OmRPVBTW0c64hezEzAmSEBRKao9HeycvZjCK0F547
         vAXSCuOGeshJFcHLLH2QsZf3KGOsbwavMTKw5RnFkcmKEyndoxkRAnkVUlsK5Ibnyd
         brgDooMXLB5K1dHEmd1LX3CXXTgmG/xGkMIEkDkY1jQ7+uzx9FfA/ZDKtzVa20enrX
         8pMN0Wbv3u4Ag==
Date:   Thu, 2 May 2019 07:52:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the battery tree
Message-ID: <20190502075238.4069504b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0a_cVyywzwlbVbVtXroyX+r"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0a_cVyywzwlbVbVtXroyX+r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Commit

  465089b4abe0 ("TODO")

is missing a Signed-off-by from its author and committer.

Not much of a commit message either :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/0a_cVyywzwlbVbVtXroyX+r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKFSYACgkQAVBC80lX
0GzQOwf+MdhKg/J6psrSaKrUn05TrccqmE37O7UOHqLIRKUtr5T1quU7dMeJaG3w
Vg4hb730/tWlnCK+4eKBWIjQ0yCcSdbqr04CT4oz5EMn1d0q+qHjjr2QmI8l97AK
8AxEu+RgCJTcSJ4KW8CMQzjbPim0QO4p45qYs3504sx6jmfwV14lV5lbqTl4nn7s
lgBYy4CU8lpmaj5s2BOAnfQapd0d8mTqHLk2Xou8FKX6h25c0MX6K9tIgg6NYsPd
fzfi9pdCBktm/Ku6HruYDvlTn1tC3B7BGF/D3gUK6dRMDtvdzFhuczLySdd3ukWz
T0tEQDvcuzmejtO7JY255kgPsbFWhA==
=+/KP
-----END PGP SIGNATURE-----

--Sig_/0a_cVyywzwlbVbVtXroyX+r--
