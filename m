Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D69C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E77421881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F8PlcePD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfIBVNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:13:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfIBVNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:13:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46MjV05wJ2z9sBF;
        Tue,  3 Sep 2019 07:12:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567458778;
        bh=YLFOuafLtktMTxfNG9ChbmdV7a8fE+Qr2vYZ/ultEdk=;
        h=Date:From:To:Cc:Subject:From;
        b=F8PlcePDTGmFoPhElOO+NNxm64/8xNLBuGKzyuR6KMAZhsXwyE/Qmr3NUHrnc34/j
         qEbiWw+jZAl76/+M98vc97Cz+3IaWkLEZjbguOo/N//4f+thujgdnU8n1DMMjmwJcl
         +SsWuY/2uI3AKq2azrkqQIXv6wj08gMaMf8/eUl3ch8R3RBxZmEBIixJFWYImH861m
         BbOhbX8gn0u7F71kbsYapKRkqKK4FW0nJw/KL9VKioiJLdxztQRBG9jnb+AeYZjWH/
         mfvPRJ8v0b0mz4Ew6Xh5nw7GNHDoE8NxLvP+94roCzr10CW9X4pr6XjvaNeENxQvG4
         f/nohEfEHymIg==
Date:   Tue, 3 Sep 2019 07:12:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: Signed-off-by missing for commits in the fuse tree
Message-ID: <20190903071251.7967684a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3/wmMl9fldTfXn.=mT2GO6C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3/wmMl9fldTfXn.=mT2GO6C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5eae593422da ("vfs: Convert fuse to use the new mount API")

is missing a Signed-off-by from its author.

Commit

  c08428c528bc ("vfs: Create fs_context-aware mount_bdev() replacement")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3/wmMl9fldTfXn.=mT2GO6C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1thdMACgkQAVBC80lX
0Gxpwwf8CRFzwwU0tsD7FQqwn0VmeaxZEkyUdJNl+qPdiPqEaxGnqq80HESCED2p
coKEkK4DjPRSzi9295mynteAv8UikoGtWiun038Qy1taPIiau51VQ8TFhmiclvTR
68MDg2ylmE2/fHrCmNB9zzkQUKBcAoiKGgdK9sXI5hcGjfuB0NWkqSbmyUvlzCp6
aiL9N1KF1Px8v9Rklyco4aaqGNBdc/9rFgp9+iZ5Vh+b2KEi1AtFzfC/+g5RYx4T
M/tAUIEYr223prgT6aQA97I36NWGmpfSRgJ8jgrLaMLkP3z3e97bzoL5xoFp7pJ1
LFCO8VyMgNReQ76UHhrEEHZ5uJQWWQ==
=iloA
-----END PGP SIGNATURE-----

--Sig_/3/wmMl9fldTfXn.=mT2GO6C--
