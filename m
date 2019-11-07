Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DDC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85904206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="il9eyF3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbfKGKEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:04:31 -0500
Received: from ozlabs.org ([203.11.71.1]:51761 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGKEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:04:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 477zXC5CN7z9sPT;
        Thu,  7 Nov 2019 21:04:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573121067;
        bh=1EBSfa9DppfkkXPCl8Nz5/lZJ2ZKDXtKClZzsnCBel0=;
        h=Date:From:To:Cc:Subject:From;
        b=il9eyF3ZKHmO9krZnxN3u5zJKo6kJlh0tPUoxZQfbKhVBZVs2lcxAHJDkdsYwmEHH
         4+R/raaobgfhnqqMbfF53Mnu5NQGEG7PSz/ecKRzXddbhbHwRPQWR7NUXE+DUb1PWo
         ukI5LUcubPKi1NlnSW3mFVO3T3XIdERDiU6PSPs+1fFYWQqQ/Wx01FSK9uKomCZhBi
         LbbPItvlluMj/nCy3uquWvDtX0iIex5+d8f4Q3yqLmJ8P9yFasC90AuJmAEapa25v6
         wOqBKmpX3uVksdAvOcouybl6xLLKqGv7+lbypHoi8izQVG/W+IQEAOxs6LvM1CC9xJ
         Am8R+xkMwegDA==
Date:   Thu, 7 Nov 2019 21:04:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Linkin <dmitrolin@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20191107210424.230ae6f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wn3yw3su=s=Kgsv5shmUZXx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wn3yw3su=s=Kgsv5shmUZXx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  950d3af70ea8 ("net/mlx5e: Use correct enum to determine uplink port")

Fixes tag

  Fixes: bb204dcf39fe ("net/mlx5e: Determine source port properly for vlan =
push action")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: d5dbcc4e87bc ("net/mlx5e: Determine source port properly for vlan pu=
sh action")

--=20
Cheers,
Stephen Rothwell

--Sig_/wn3yw3su=s=Kgsv5shmUZXx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3D7CgACgkQAVBC80lX
0GxCWgf8CQe3cYbo1AJV/rHv3RwGIBgGRigkhRJGn1pyUgd55ChVHTfBYc3Yd9cX
NHBdtJ6C90gkIfAclCRyLsBt0EdsTzeu5eKnDBOt5Au4ycV4YR7N9jwqkUypA5F6
5vTc46RqsRRZznWyRTZVO08Y2qQBN9P4h5CmMLBkTh5LRxI/5qu3d/9GSqjIu4bV
cEAiVhaOgopqUemcW4ltVWZn22xZlPv11C4ZAuVD2/Foz+fiHOsebr0uTkjwNvVE
GU6FuuXl5DnjeF5SzU93YK/1kXaWsbQFLJNnneRxo4iHLHA9NuKZxg9x/OPQ7tyP
c4seM8QKdJ8IRlHURepoQToKGhETtQ==
=Hy1d
-----END PGP SIGNATURE-----

--Sig_/wn3yw3su=s=Kgsv5shmUZXx--
