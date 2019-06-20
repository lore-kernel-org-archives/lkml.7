Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DB72084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K0CYk8Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfFTCP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:15:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfFTCP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:15:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TlmB4tdGz9s3l;
        Thu, 20 Jun 2019 12:15:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560996955;
        bh=WYZIHceZurM550G0nBpWksLmBz0WZT6hiqxdE989L4g=;
        h=Date:From:To:Cc:Subject:From;
        b=K0CYk8QswAeS0bsySxycLfLgZuK6PaglPJhch5ZKldiFYhr4oSHQ/2081ZvkZEULr
         fWsWVtSkLO8+wdRYfZO5nWCt/s8Fnj4KlaiZzd4Y6SMWkviivp0f7WHemK8JjYj7zV
         ye2aQaeP4tqoVNRZ7rIBzoNhqpHUNjpj9E1Cc/PzslXAK4Gk0HX7xksgIkww867mCz
         kqLxtcq9Y4rh3wK2mpu07W61DqZT/3uR0mwddOhk56UA6IOTVDm2KMKQ2AQ9EtZIX8
         FBtp/QbCVZFBvIYC98s7U2wLGBR4mfQogTJIDyB6s3pkKy+iSYXPESw62nf3u8eSth
         xTgvVyWdB/PVA==
Date:   Thu, 20 Jun 2019 12:15:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20190620121553.16f2297f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AQcJa7AwP=cW.Tdh_kvnKV="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AQcJa7AwP=cW.Tdh_kvnKV=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/infiniband/hw/nes/nes.c

between commit:

  2d3c72ed5041 ("rdma: Remove nes")

from the rdma tree and commit:

  2638eb8b50cf ("net: ipv4: provide __rcu annotation for ifa_list")

from the net-next tree.

I fixed it up (I removed the file) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/AQcJa7AwP=cW.Tdh_kvnKV=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0K7FkACgkQAVBC80lX
0GwxCwf/T2n4IKaulRdTQDeyekS+YVT3LeCTwTxZNvrRJkU1dAHJZ6DA2xxey8lP
nAts5MFB1X0FHxjqPghUBnTh5Ki+ssBAuDEgoNXxTSdVQpHa7FUlXmsTfpikCOUs
fJL0oblVxnjAtcM7DGo2oDJFLc28h5uUnS30UH5dbLM8IFIcEwtxYQ8Rueu4aRlP
4W5ngdslZZSC/P9l5+uixNocLZEGWBv0nq3YJY7EzKi9/RHUntmNf2V3EN3dt7mC
30m7ABR98uaFHdlmoveOBhccT9lywOEqA3Ma01s3e6XM4trrP5KBu4kOBbCkw7tw
Fr9//fVNf69LVKN+X3vVBXpzbgEKWg==
=CpmS
-----END PGP SIGNATURE-----

--Sig_/AQcJa7AwP=cW.Tdh_kvnKV=--
