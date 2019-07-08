Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D86C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE5420665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OhbgFB4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfGHDst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:48:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfGHDss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:48:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hryy5RVhz9sN1;
        Mon,  8 Jul 2019 13:48:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562557726;
        bh=mDrD1Sn4fzfTzidyBGIKFqxSZ2KwSgFmpIydyvvKGVk=;
        h=Date:From:To:Cc:Subject:From;
        b=OhbgFB4GR7zBvporksGbd4ZLzYKRN5c6Co9heK4GsjTiUk/YPcJqdBFjB1RxakRTM
         2/wp0ldM9QAcH0m3emVCEsrT000FYyAP2HjJIt+5w9NzgGQO2uydbC0solsNhcyOGJ
         Jxj0X4DYcfqfUic6ldosKA6ri7eT1OreyOgceniU7KN4zxnqPOYl8rTzmLztIyqenO
         YoEElT7uC1FSRA6tMIYW9cmhia9eQv8uAa5QuanTtf4+RV7QXjBWoWZXoA7Uch+/F0
         jmPlo4gqaUjzP8dq3v4Ne+k1IT6ski/3F/y7X8dhYKCO3O9Rx70Nz6yPOmBaJarxF/
         PKekBsttorJ7Q==
Date:   Mon, 8 Jul 2019 13:48:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Price <anprice@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: manual merge of the gfs2 tree with the vfs tree
Message-ID: <20190708134842.1e947318@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rAX5HKHynv6BEhQ3eqYwSgn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rAX5HKHynv6BEhQ3eqYwSgn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gfs2 tree got a conflict in:

  fs/gfs2/super.c

between commit:

  000c8e591016 ("gfs2: Convert gfs2 to fs_context")

from the vfs tree and commit:

  5b3a9f348bc5 ("gfs2: kthread and remount improvements")

from the gfs2 tree.

I fixed it up (I just used the vfs tree version since it removed some of
the code modified by the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/rAX5HKHynv6BEhQ3eqYwSgn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ivRoACgkQAVBC80lX
0Gw+VAf+PpQ35iJhw5gaiz8VEgvYW3NcTC2QBnxmNFiyKQfE4gq3ludE43XTT8r5
UJ18rP4u+b7GxwlsYJmzvJxZyteSFB96UNqobzWjHyICF46ovhCbOC/4srOAokbQ
yRswzXZvpCWhYTpgsX/sjpt9X6yZeA5ImUZjcR6VKQFH7q2cGWLVbefn3VKdLOw1
5miwxGVJWz9/7X4N5jZgKbushwFtsxrrOvjfQylgmGstq6xmXUgOGwxaH+tik8hi
2lmFku6tiHg4gE+zGvapTRD5JQIBoyWTB1YAR1GE9GUwdtkG57SNlD+e+5PrzDiL
9HQIaixJQnFkdk0UTpAHX6889QFN5w==
=I2b8
-----END PGP SIGNATURE-----

--Sig_/rAX5HKHynv6BEhQ3eqYwSgn--
