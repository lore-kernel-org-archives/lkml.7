Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AD3C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F80320879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h7e99HGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfCYUGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:06:03 -0400
Received: from ozlabs.org ([203.11.71.1]:53399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbfCYUF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:05:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Slcz516Yz9sSR;
        Tue, 26 Mar 2019 07:05:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553544356;
        bh=09z5J9OK6XaGoBRLP9ljJwhurJTdlehA57b+39zQKpY=;
        h=Date:From:To:Cc:Subject:From;
        b=h7e99HGd59l+DjXSaQn9G4KBgkfudr15mwpzCBJHHqI43Ejs5lfjeABU2xGLr7igW
         Lqj72j4iU4/8HE/xQ2qM8elq2PcIJDRjpQVcATPNszs5fPFiXsGPZ3xm02jPhgQo2t
         wRGyJgz9fyARwJulCv6P+4uADNsYcC40tEp0lBjZx2dvXqyzVQw5pTGTLR7htZIBRS
         fAweX8VsO76sRRNZ+X7jfDp2OPcR+MW/a5iGiFOlavKk09U0HCgmSILPKemxpR6K/k
         UoFw8dVjdM/y5JG80PUmIzIPYWasa9FysBWdV5zEr74+LKOzhDQUreUQGDK9+RDufy
         IBdf1mzSo0lsg==
Date:   Tue, 26 Mar 2019 07:05:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: Signed-off-by missing for commit in the btrfs-kdave
 tree
Message-ID: <20190326070547.006baaae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2jfdEvC4kh9np6OjprWeoGT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2jfdEvC4kh9np6OjprWeoGT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bb8bce012bdd ("btrfs: replace pending/pinned chunks lists with io tree")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/2jfdEvC4kh9np6OjprWeoGT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyZNJsACgkQAVBC80lX
0GyX1wf+Ij6m29ScEqlcTMgJPu6yx1me56D7mr7zUuKv2WmLOPqwvj7gcn9kRKKs
NWvrfi6a3hPdh1+oB0VYwU3Eu/HAUhqq99UoZ0xUA+ouC2RbUVhiMbZhKea3vh+e
IqcUDULlxJ8geHdFmZ0rB2R6xgT6ItzrUW3eM0mJs9lPOH+LEK6EUQtAE5tju/Nf
82OxaXnIwNShmWFS7LSb/Bz8VOGU8Bj4CPigHLeTeA3BizF1LZsKb2LH1a+cJ7u6
ELl0XcsTkkyMPTIG2VvRgVC9pGchHySC/Emm+zYD0LZG+6usDzsO8IQypxxBrMrs
0a/I7rOfz5a/X/HTkZkLUoqqaZ/LsA==
=tIU9
-----END PGP SIGNATURE-----

--Sig_/2jfdEvC4kh9np6OjprWeoGT--
