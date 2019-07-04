Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31FDC06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21DC218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xwxbt6lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGDKoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:44:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:44:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fZNf02w6z9s8m;
        Thu,  4 Jul 2019 20:44:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562237074;
        bh=zKiyI95dkoai3uIXIayRFOVipQVVsyAGWwhdVmxXez0=;
        h=Date:From:To:Cc:Subject:From;
        b=Xwxbt6lb+P4e6Tol9JGcIkSVdXo6y7X5KloD1AOr079/NSbt/mPiEBjI8/Go0+AlY
         kYsXfx+71M//IhZxOG+iUNsr4oiQH7GgLwf6qjjrCXhzc8NyqSAm9vjKjMvQMXlPww
         Udn2AaH1Vz/k1tKLHEiJiBdxFopzaiKNwi/4SGabp7hVdcDpQrFn40B927/SoM2Qvk
         a7gY/31lX5tDeEfMcOotlm3xvrQEPakg2ll96AaAMrlm2x85BMyt8TxnSbc/P9RP2g
         53NP1uDUSD1D6JRPDpZR40UYfby4hTNT2GjhkG67NkaC3uVrEgOnBWP5ALDqAxz5/r
         tFsc5vIaUVXkA==
Date:   Thu, 4 Jul 2019 20:44:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the akpm-current tree with the hmm tree
Message-ID: <20190704204432.5e4a0261@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6=IVp6HPHpVRIbQpflpc.ck"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6=IVp6HPHpVRIbQpflpc.ck
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/hmm.c

between commits:

  0092908d16c6 ("mm: factor out a devm_request_free_mem_region helper")
  43535b0aefab ("mm: remove the HMM config option")

from the hmm tree and commit:

  4c24b795d8c4 ("mm/memremap: rename and consolidate SECTION_SIZE")

from the akpm-current tree.

I fixed it up (the latter is just part of the first hmm tree commit) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6=IVp6HPHpVRIbQpflpc.ck
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0d2JAACgkQAVBC80lX
0GxjIwf+Ne3YE2DQzE/HBtlv2qN6nDLZRWjP57zLz4FhUUAbO8dVfiLbyEnw8Rmu
ENjx+H7hIlWuBcTcV9ACS4+C6l+TexW27V02++wLdhOcgs2yFImUADGb1Pzu967Y
dWQnib0umlr2qloQ/+DkCJLTBy3jsrrMiqNP9Mh7NZL+gQwNrZHY9GW89TubpVd9
isBtrX0lutjiLgHwi5qNIdhXSNmpcigVgXcWuUZVizD5uMlKcvaBHDVlyg6IkKS4
v5sA/LuovDl9FZPkgljaE6dpxcv9Kclg7sOus7H4Ixd7MxXqolJ3oLJbFpHDFnfK
iYogHWKJ/pv0UPcl400IMxIBO3tPsQ==
=DZ3u
-----END PGP SIGNATURE-----

--Sig_/6=IVp6HPHpVRIbQpflpc.ck--
