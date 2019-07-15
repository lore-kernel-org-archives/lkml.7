Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A17C74A44
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B3D20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XdZSrUPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfGOAG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:06:27 -0400
Received: from ozlabs.org ([203.11.71.1]:39325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbfGOAG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:06:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45n3jD5YrYz9sMQ;
        Mon, 15 Jul 2019 10:06:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563149184;
        bh=0+uCFa4Gv4psJERzms4nSYHlcKm0SgM1ZlEldtrN0NU=;
        h=Date:From:To:Cc:Subject:From;
        b=XdZSrUPsZGForhj54nmvb2ALVLfu6eC+ZoU2BvLyQgMNs9WV3EmDZfE6zpSnpkWq7
         Sq3XgXc6fweWPsNq4HFDS8UOM35KO3ZLPZ5x0kzeXI6w5q6dnTBukoi/VISiYHW1+Q
         Nfp2D7cIoxkKLgu/jnVEBbrvMorHxAPimwfH45zR3SedvA3upAfsvuptdUL13vpl+r
         lKxTJjeRWwsB4yhtayV9hTWrdJTHBUM5IwdVMYrGYnp3x0FoeYtRiiYhb1V1qE2Am7
         Hm2etcjSQBo4fR7l5kkHL+oqRGp5+gimlyTyWe3FtnL8qkxTfw2mg6lQLAXeunAybr
         bjK2BswLEmvgg==
Date:   Mon, 15 Jul 2019 10:06:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Teigland <teigland@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: error fetching the dlm tree
Message-ID: <20190715100624.359730da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XUSKFVOV+ou6sI2UgAFquIn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XUSKFVOV+ou6sI2UgAFquIn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the dlm tree fails like this:

fatal: Couldn't find remote ref refs/heads/next

--=20
Cheers,
Stephen Rothwell

--Sig_/XUSKFVOV+ou6sI2UgAFquIn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0rw4AACgkQAVBC80lX
0Gx3YQf/etONh00e5wzEygVXOB+hjcvyJgGDBDYkcxkzwCDdnxeEjQNWdhT/Z7Co
zcZ4y8MhtU0hLBzTlWYJLBF8m5YdoSqlxaOQzudvi1yaWoEknyBausRkaHwxVI8B
MCZrwDnzlcTgOjHRAegCLtYSixETX8cZ4djPiVgOolsV2wmJjIURrlea/1hf/+ep
gY8SIlZlYa0N3IM6Iw4xRnQtoquDiHbJ4ORgr731YZ9CbIegeKGYkMJzzJt5MyiT
XHtCIAVVq9kavaDwciAiwdBioehJCfGzXGysRpnhePHQjbBTx8p3UkWc6FdUqb/1
nAUMANrnPfFQy2H/Fbc6hDt13g/AGg==
=nhTY
-----END PGP SIGNATURE-----

--Sig_/XUSKFVOV+ou6sI2UgAFquIn--
