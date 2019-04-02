Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA746C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5E420856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q/ksK0wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDBW5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:57:07 -0400
Received: from ozlabs.org ([203.11.71.1]:38123 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDBW5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:57:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Yl2l4jsjz9sPZ;
        Wed,  3 Apr 2019 09:57:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554245824;
        bh=DsdMf4DpKSTZq8UPBe35Q9sQyWp8eAnTB8tLh+BzkKs=;
        h=Date:From:To:Cc:Subject:From;
        b=Q/ksK0wDK7xl0vHyZWLX+RkSHxBFYdDljkdyY6rOHav6e6r5KsDoOFYwaMaZhAw/K
         bk8wdo3BagJkP28AfhTLq8Hw9qFZmj/GwuaTUX7S+gWfyGtqAVwNx7WcgTAl9ycInx
         CUpoljeecPYh00ik6RdmkcxQDyQ/S41VfSNaIV5BDID60REnAM8hmbPtXy8cx5mAoS
         H+w+0s66bD0T0wpWfoerM34vuLsdIk16/J3VnIH+CYkTyjB4YuIbeWCMSfExQgO56R
         L7TMDdiCU9FT2GfweMmFz3vQYq61+zgHGX0rha+L33EMIFZsw7v5UCTf/DTO1KDCFX
         KZrJ+lygfkPuQ==
Date:   Wed, 3 Apr 2019 09:56:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the net-next tree with Linus' tree
Message-ID: <20190403095650.0ded75e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K6G1/X+k_XFOqI_fehCuh=8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K6G1/X+k_XFOqI_fehCuh=8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/staging/mt7621-eth/mtk_eth_soc.c

between commit:

  bd31342f0046 ("staging: remove mt7621-eth")

from Linus' tree and commit:

  6b16f9ee89b8 ("net: move skb->xmit_more hint to softnet data")

from the net-next tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/K6G1/X+k_XFOqI_fehCuh=8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyj6LIACgkQAVBC80lX
0GxwkAf/WgDx6mwhxeIoHB+tASIZB4NPDsOZLIwX3ovacdgRikfVkduGpIgTMXM9
LdAg0UAfyigTwMRFyaNq5tQJS5NSDWLZIiwcWVAhY4lyEMOAYEAKOWZ1B8rreO99
7+Ji8+JVVKqTF2VUUzIa2Ax7WUjyq7hO8LMgXCZ4XCHEl56ScePi1vMzPMuXZElq
NpbhaUxei+fGSkkxyJLDol1+PT+X10gPkox8GVSVGyaoFeE1KGuXa0U7mhIJT5+h
IR9h5TcL+PGh5iYkuEtkImvqh5GcofMJgCcMEA+yN9F8f69CPWIoxfBBQBcs24Wo
7nJEMTvVeyyiHH1tiCEehJ9DXkjx/A==
=bGuk
-----END PGP SIGNATURE-----

--Sig_/K6G1/X+k_XFOqI_fehCuh=8--
