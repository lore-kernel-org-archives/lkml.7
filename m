Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E2A212F5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E4h391VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfGAIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:33:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfGAIdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:33:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cgc82J63z9s00;
        Mon,  1 Jul 2019 18:32:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561969977;
        bh=lvUQE5LQxDBXezWNt7nLUjtyv3Va8fBShJfSlsLuk3E=;
        h=Date:From:To:Cc:Subject:From;
        b=E4h391VL/x+CovzSYW+Mo7G6qB4bd+Cm+rwg26d4XuX2ACuUIK7A/U86mpEhx333P
         DCxbWDFJXlwUuPmo/pyC7vEMq+srGVQTu8bOseMdncQLoIDE66lDogIUHa3chtJ/d9
         6DKH4LUkRinUXGd0L9vSbhbUNOr1qYaCIPhrT58tD4BdNUlaanV/1NF3iOafjVXG4l
         ZEV468uItG+JCNuthrgayCOm2eQBASnmUKpBq4Ogzm66VEN+p5heLdKXsasoMLCmsH
         hLXNE1IsGCVolei7WBKLnDds0MLykoHbNbdTgvPbmHFLsJK3TXqUKuFCiztGo58lN1
         yNUGPPaiO2U+Q==
Date:   Mon, 1 Jul 2019 18:32:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: linux-next: manual merge of the driver-core tree with the pm tree
Message-ID: <20190701183249.34c928ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wr.kHDqdCgNY1uyOkKAGf3x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wr.kHDqdCgNY1uyOkKAGf3x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/acpi/sleep.c

between commit:

  a3487d8f3063 ("ACPI / sleep: Switch to use acpi_dev_get_first_match_dev()=
")

from the pm tree and commit:

  418e3ea157ef ("bus_find_device: Unify the match callback with class_find_=
device")

from the driver-core tree.

I fixed it up (the former removed the code modified by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wr.kHDqdCgNY1uyOkKAGf3x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZxTEACgkQAVBC80lX
0GylbggAib8BaNYR3uG3tK0BDyQAtEZHE+9aboGguHtoB9bQNR0YZoQ9yJDsg65b
dr38MXnp+3Bb7JCs3NlS4BJsonCgGw8TLJ8o5W0FQZ9Ozckvh0eFsDt5Ka0IVoMd
EQm7cED/EEQGvn3G+aLg/zybbQrUtOGp38pD5kf5qP2NYwjk6v71vwGZvltW9Aeh
94fxlvH+a/ZJF1C8x1ZpsJyXtjsVoHj3iaPQdhWexjHEWtf/9E7jLljWrW9fnoHV
I9ia/aufCRC3Qv3PkIeTSyFV5IRIJJTbmkPXZaYghmv614gmt/uG9HhnURZuJnTJ
kMSdd41sRom949uCRSQQfMY6hjkMTw==
=WQnN
-----END PGP SIGNATURE-----

--Sig_/Wr.kHDqdCgNY1uyOkKAGf3x--
