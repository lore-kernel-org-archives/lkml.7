Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4183CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB0420835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eHG9jN0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfD3Hsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:48:35 -0400
Received: from ozlabs.org ([203.11.71.1]:43427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3Hse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:48:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tYYW4GWXz9s7T;
        Tue, 30 Apr 2019 17:48:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556610512;
        bh=8rOSl/GuJIamydyY1hpJYrSlMVfj1koZLQRXc4uPkJ4=;
        h=Date:From:To:Cc:Subject:From;
        b=eHG9jN0tlChImKgEFjTXfYyk69Bmxdpy2pdBEkoK0WpTyVcW6UrknaNK/D7YKiqvW
         jWKb4VOVZHQeyTeVwSS3j3gA62JJxVxLcbpaVxaaRcwvfBS+f7goTgq9+vAEm9QlB0
         GNkG/5QnWR1pnaHGYaR06xo/TbxUzMLDtlUiAgVG6V2l6BgUE63sOt3p0dJhuN28LS
         sLPqX7EHjTFq+v9fN1wxFFqL5bigd1KYYSA4mL1xloznuCPrViUJXo5ubM2m9UePSD
         QgWseGu0VqX3YNIPLrGqTFGK/mKDaegB7/0nIrxjANX5hsqDyWv40sb4Cb62CKaWG9
         Na0oU78EKJHyg==
Date:   Tue, 30 Apr 2019 17:48:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: linux-next: manual merge of the staging tree with the pm tree
Message-ID: <20190430174829.4f33e8b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tY5zH+.a1hnR/MQ9ywNeJ+P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tY5zH+.a1hnR/MQ9ywNeJ+P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  Documentation/driver-api/index.rst

between commit:

  680e6ffa1510 ("Documentation: add Linux ACPI to Sphinx TOC tree")

from the pm tree and commit:

  09e7d4ed8991 ("docs: Add Generic Counter interface documentation")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/driver-api/index.rst
index aa87075c7846,201247b7c1e8..000000000000
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@@ -56,7 -56,7 +56,8 @@@ available subsections can be seen below
     slimbus
     soundwire/index
     fpga/index
 +   acpi/index
+    generic-counter
 =20
  .. only::  subproject and html
 =20

--Sig_/tY5zH+.a1hnR/MQ9ywNeJ+P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzH/c0ACgkQAVBC80lX
0Gzg5gf8Cu23ZHieu0LDK4k6BT34cgCWBgHWEzDcxCQhD/of7hf8e/nIryBzvICg
4rTEWtv7PoNXtIBDoZDHAGSfS4FLqpkZCwoMi7JGO+RLZyjc7oV3aSO2rgthIFut
QMqfKBG5Z9QLsBXGPMqCC9+/Wurwu5cDYYwLybJDgveKk2eaK78FdAX88K9Xzcaj
Uy61mcW2cQ+e0guwTKWLoEV+gOoJeQaeMfNfj31+EzOKzguL4s9YOW76hAf6fJzx
HvU+IIDXk/XB1QMx1hM8N5i5tEHIih9AAqZNtK7yvN0A7nxSJ5PDQTRUnIYKV4Kr
F025sHq6kw0ryHH0eldgFX1Xz4FjvA==
=DOkb
-----END PGP SIGNATURE-----

--Sig_/tY5zH+.a1hnR/MQ9ywNeJ+P--
