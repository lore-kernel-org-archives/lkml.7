Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3651CC5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A1720665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kIYLYDh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfGHIgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:36:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbfGHIgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:36:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hzLl5Df0z9sNx;
        Mon,  8 Jul 2019 18:36:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562574976;
        bh=Zgisn+lvV/TJcGnaVkvliEJ17h2XWEJf3MZpsmg5464=;
        h=Date:From:To:Cc:Subject:From;
        b=kIYLYDh7U0a/uhDAjdkcACq81IR09/MYDiIQag5lxSKmqNpQUut8/GBNZ1msBrmVr
         sq2aI+WiPnfETAw6eO1blWdV7Od/qofsW5PVHG8IeyZ0bbjS4bqFNcYBJApJW2SBZ0
         EpnSJ0Qk0a6G7/MBDzNBoYrKgi0FMq+bAxEA6LMFvZaBeZGbzn001LTcQchqzZSUO9
         hdtqEZyhcQP8QrNApsAWL3miWjg8prOPRU+9W6Y8AtGfUIQCRAOmWABtWzKxPprj/T
         QeLqt6mHYRo3MEhAxnnYltIqSbaIAlg+ujyClcu/3hsInOLZudGj1p4WOLTDGp7VcZ
         NesDYSZ5vA7Aw==
Date:   Mon, 8 Jul 2019 18:36:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the driver-core tree with the vfs tree
Message-ID: <20190708183605.2812b8fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m4FHP_.pvFw_ItiVPA2/msL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m4FHP_.pvFw_ItiVPA2/msL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  fs/ceph/super.c

between commit:

  108f95bfaa56 ("vfs: Convert ceph to use the new mount API")

from the vfs tree and commit:

  1a829ff2a6c3 ("ceph: no need to check return value of debugfs_create func=
tions")

from the driver-core tree.

I fixed it up (I used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/m4FHP_.pvFw_ItiVPA2/msL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jAHUACgkQAVBC80lX
0GxHswf/ZCxdHFwKA8RIMD7Kk2AMkOB1iwIQK9UofB8pxU2UfnQXoa182oOdlc9R
GC8GLQvkWRs4qZ/HYl4AREBN/HOzVDN72XcoyMk9e4NsTUXxbZgHi9tUyi7i7S5J
BC+inijdQF+mWVxLetDRVfrPSummi71+UtsEwzp396shTYp1rIIBNFG9YTjDNl5q
4EPmol4cfSrBPyOXq5YVep+m3fXqsfP52khSJ5bvXky4HG9/OXW22+tj3uPDbrfC
l45LBf/o/tZqT3Esr6vMkkTDfU6ly9R3nO+15DAClVXcPnU800SuFxfyM7epkvjS
VSMHuG36tH2fhWIh8vev1SPvewuK6g==
=ZwYj
-----END PGP SIGNATURE-----

--Sig_/m4FHP_.pvFw_ItiVPA2/msL--
