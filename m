Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16453C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D735A206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tyBSIIzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfLRAtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:49:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRAts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:49:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47cxHF2Ymjz9sRk;
        Wed, 18 Dec 2019 11:49:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576630185;
        bh=Q0utsYCz4hrK7U5iqG0PY9eBxGrO0dwqQiJb4phghSI=;
        h=Date:From:To:Cc:Subject:From;
        b=tyBSIIzkxo20BqNNpFo1gfgFFuHw5z61pFX45P7p3h53WNVpF+xC7H8+RYNpCfHyv
         bx/uiOosHVnjq3CS4cR6G+/LBJPZLiptTppMfoMm02yk3rLbWISikKNJp22jusfW6k
         S69cJL/zZd6PZZwGAcHVYnr8DhUzi+Ny0iiwCmZEIrMsUk9EMsceWexN+fwhZvU1OT
         U9tx1PJYqWgkhypCcZZmZS9tG9+q2YkjEtTtCj7YTtWIBoB8mkN+sUyzbfz6HGqizg
         EHewAyV/GIJFJ7ReByyJzA9UgGmnw0CRc48psJPSGXHwZIGJhOQflB5FkXdz0pdNmf
         waRkje89kCpig==
Date:   Wed, 18 Dec 2019 11:49:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Engraf <david.engraf@sysgo.com>
Subject: linux-next: manual merge of the tty tree with the tty.current tree
Message-ID: <20191218114942.59cc0446@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qeb/88b9jni87uD9xaZg1UD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qeb/88b9jni87uD9xaZg1UD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/tty/serial/atmel_serial.c

between commit:

  cb47b9f8630a ("tty/serial: atmel: fix out of range clock divider handling=
")

from the tty.current tree and commit:

  751d0017334d ("tty/serial: atmel: fix out of range clock divider handling=
")

from the tty tree.

These are 2 version of the same change, I guess.

I fixed it up (I just used the tty tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qeb/88b9jni87uD9xaZg1UD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl35d6YACgkQAVBC80lX
0GzlGgf+JbQbfh8T1PifCuQ7kralPhxo3xDomKwAXliPdIy5X0nh1TgxpitPOHFJ
jT97CUyGh8mIj0xAXmhNpyOhpzquJwGbLexrZHNfJU+/p4U0nzGTWtD9rEic2I2U
v946mD/eU6qWoxfCh5uqKEyWMgnFs9PO51M/JyTKLjzBoYonFf7x/T8dGdkQRUfV
5oJYyV9MPlj/6OiX+iOrd+vf7luKYv+N/ajtLz2FWaKaIUrAwJppQQgsNUxHY7Ti
AIAUyuh5qApACzGnHVIEMg0C7NcfFDAPQ+BagVYZZu/3Cah/JHR+Jeb/Yi/es89u
9ZDce4yAgDNixVjcOmsH+puDu3+Yzg==
=YMTU
-----END PGP SIGNATURE-----

--Sig_/qeb/88b9jni87uD9xaZg1UD--
