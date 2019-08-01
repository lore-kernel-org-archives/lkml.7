Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461A7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459D20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="heFvJM+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfHAWyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:54:36 -0400
Received: from ozlabs.org ([203.11.71.1]:36781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfHAWyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:54:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4605G14P6cz9sBF;
        Fri,  2 Aug 2019 08:54:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564700074;
        bh=vfB0PlSfZUaGhjdBBzcDVT9V+GFGFz0aXzxBSr5tYbI=;
        h=Date:From:To:Cc:Subject:From;
        b=heFvJM+JgyliVVXnqA/92gpaH4ACiXuzUPiyrnRYmt9PJD0cPFdfs6ES3jGK7PoLZ
         +QSBrVFwl/YC1gbBTyOqDggTGGCKAc70aGM3Bs0sR6Qt7hbfikfuH6CMH7OnyVBNLU
         x3KE4b3gi7iwWd5mgZTTUCDyb/WUtJA9z9jM+ww6oXl9BChPSmWclD+KNkkLFxBT3i
         ZuVRID6wLIZdC7rNBGIfX6//OccjT7xkGIByuiY002ivgpI8YIKPFJy3zL4XnbxM84
         BR3PRbql+uFPeYleBOf4amYU6q03HV0GvA7nj/rj4QUdtTOAmihNe5nUghGvdBaBVc
         5L0N9yGd4a36w==
Date:   Fri, 2 Aug 2019 08:54:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Maloy <jon.maloy@ericsson.com>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190802085426.66fb56f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J0Lv5DcJQ6SDaZpXlB+mWzZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J0Lv5DcJQ6SDaZpXlB+mWzZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7c5b42055964 ("tipc: reduce risk of wakeup queue starvation")

Fixes tag

  Fixes: 365ad35 ("tipc: reduce risk of user starvation during link congest=
ion")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/J0Lv5DcJQ6SDaZpXlB+mWzZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DbaIACgkQAVBC80lX
0GyPhwf/Qk9AZcE6BYl31aA4dv5G6WA45FeOZMAFF/l9aepJduu3agdapST7gilf
a4aJ94qky0fu8EMfwGZsfKoyAhpbF9aQr24hss259FF8RHioDe+mc3ynHrwaMf06
1cCcj509ih9AZ9oRfOZzOjPtAXoxrGQ5GboUKGhnAcBde2r4Xrm9VBujuMl8Elq3
rdUbi+09xTgQnj7plPW6HO5B+Mq33amc8EHLNyWNERHHTFPb6/yXCV2l8rvIhCbD
SIZEzfR51BLoQ6MJifmpVJfIlc8riOTV0YaT/IWhZSCptIffSn8YsEy89RiPERlJ
5BlPFaWUR0jm0Ka1EAgz0x8jKui0NQ==
=kqED
-----END PGP SIGNATURE-----

--Sig_/J0Lv5DcJQ6SDaZpXlB+mWzZ--
