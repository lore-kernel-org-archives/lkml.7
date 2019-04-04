Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60829C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20891206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ca7kJC1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfDDUym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:54:42 -0400
Received: from ozlabs.org ([203.11.71.1]:39859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfDDUym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:54:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ZwDb6VgKz9sPC;
        Fri,  5 Apr 2019 07:54:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554411280;
        bh=bCR50MyV34TPPkQ0FLDsLdOO4MfNOM0rW+mYnsA/IH4=;
        h=Date:From:To:Cc:Subject:From;
        b=Ca7kJC1N+7YP361y/KV9DcJfH8yX177+B2oSqLCoyEDzbJ1z/rIy+MWofs2Had4+n
         qEE8pcm2cXVWrbIKweVbGZspszGzO+5yPmFIkVL4J8H40pKaCGcaJ/Hxb++qYc0srH
         qf1K/X67jExSGraqDaV9ugkJ5kmzhb+fpV9AEYwZGZrb9IZr5SkVH8r/weh4sI295E
         X6IgV+mW9Ir7vdarQetVltFYUJLWpEpeGSRWYdhsATSkWBAj4pGZBLyp5kfYkwl29a
         Dy3ImUkTXmzwttdXoIB7KNoOPkevAM5YaDXU0jlHeQ+8VpL5ZcBH2I5ElIm+PlkpyO
         rGGUCH7KNgYkg==
Date:   Fri, 5 Apr 2019 07:54:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hwmon-staging tree
Message-ID: <20190405075438.12f98275@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RUYEN55DHEtgzUPI3Ya1w2K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RUYEN55DHEtgzUPI3Ya1w2K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

In commit

  742ad88f0440 ("hwmon: (smsc47b397) Use request_muxed_region for Super-IO =
accesses")

Fixes tag

  Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

In commit

  4d730440042d ("hwmon: (smsc47b397) Use request_muxed_region for Super-IO =
accesses")

Fixes tag

  Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

In commit

  2f38d5d31508 ("hwmon: (f71805f) Use request_muxed_region for Super-IO acc=
esses")

Fixes tag

  Fixes: e53004e20a58e ("hwmon: New f71805f driver")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

--=20
Cheers,
Stephen Rothwell

--Sig_/RUYEN55DHEtgzUPI3Ya1w2K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlymbw4ACgkQAVBC80lX
0GzZGQf+ImWg5fJO857xqIEzCOY9mNJEEk+4n+FEMEwi3FI/QDrgNGdegm9D37PJ
gFHRSzX7wJPgvpbhTJTUFdPaqNrHIs/nIZLjyygWoPyIh1kZm4ZyiDyarJQb3wJq
G1bJx8k6J/snctmOLtHEfToAR219pe3MixQSexdNg58PNfONeIyxWBL/NbD7T94S
Ger1QUjgBNYO+LJHKh3dEzYmZOvmCscIKvC/AuuJxvpDJkPwa681w6Zg+u9zUh/m
EljHj7bS2DDicu7GpKmMR8kgMx2m8Ke1cX1FcwGTJCF6Iolq38p+pn8t3Jv8Z+nt
b//zGjAQYvDIc1JQTWA9hqzwLFbzrg==
=eXAO
-----END PGP SIGNATURE-----

--Sig_/RUYEN55DHEtgzUPI3Ya1w2K--
