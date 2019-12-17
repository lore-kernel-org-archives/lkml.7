Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9094C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7190D21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lw1Y5Ehl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfLQURw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:17:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbfLQURQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:17:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47cqDl6MQVz9sRM;
        Wed, 18 Dec 2019 07:17:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576613834;
        bh=to3nAIMJMhJTiwo/9pBgTcO1nHmn5+b/bWSIpM3ItcM=;
        h=Date:From:To:Cc:Subject:From;
        b=lw1Y5EhldrOoOxqSZgOHnSNQg2+ApiWHLuF5q8KtPhhpBI0ZDXKLdLtS6AvATKnuF
         EBABxHtaDz4PFxQEFaPA2vYRupsa6GqzoGqOBGvJSwtFd9T8u0QyeWgEvnL5iXB8KE
         PmszQwUBp7TyDC1H7gq4WKpoM5CvyOoJ+cI60hxY8GxDb00hI+tZAU21mfWYjNTSGx
         Fkd16yVuE6zTTP1QHdSEKCtDKBoAalC/89walxTXnJMDHUEwkf1IQA1QcuRe1JlAwl
         XZTosMKoTjU9syOvgQJpaLRNxdAvsCNKadvwfdsdwismu6DaO0X0r3Y1ks2zDunX6T
         8nSkHlwa6ySDw==
Date:   Wed, 18 Dec 2019 07:17:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20191218071710.61602251@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ip44PrA7z9g_nx5J8I_SBQB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ip44PrA7z9g_nx5J8I_SBQB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,


  78d3e7c19e2d ("tools/power/acpi: fix compilation error")

Fixes tag

  Fixes: d5a4b1a540b ("tools/power/acpi: Remove direct kernel source includ=
e reference")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ip44PrA7z9g_nx5J8I_SBQB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl35N8YACgkQAVBC80lX
0Gz8MAf9FEzIt9+SX7HvQSQA3T+1g4qEpxARPRfUwkPaGy0g+VmgTY+h0C1T50UR
ZjXjYRrrQCA0KjTxcXnqrXm8uOpfyCxSMmg1VYq2up8ZP+ooj9Nm6SxfhPCjvL5x
kgWDXGwk6jufo5NSJW0VMmaEQuvhnAPrSHvFpBwxTzw8JRElyJmX7DsGzqhlSh6V
M7sTZgN33SVGA55Q/NmgOgvCJLc1d0lcd41jglWHlzy0zM2HGFYzSm7g/7XYcrWZ
SG/JdUrYYFm+frWDh/hEOV9+KZgHHzOiSuaxpzn6QMiI/DzUvSbOb/uKdc55y6/Y
KiZKX4geU/WYs6+90ujDKzn937TQWg==
=Kutr
-----END PGP SIGNATURE-----

--Sig_/ip44PrA7z9g_nx5J8I_SBQB--
