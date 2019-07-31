Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0841C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BB2216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FBICxLxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfGaWGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:06:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfGaWGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:06:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zSFF52Pfz9s3Z;
        Thu,  1 Aug 2019 08:06:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564610801;
        bh=oOJoFJxl13f9yQkTvDJjcuS7iKTNs2x5YbEE9xHPpzw=;
        h=Date:From:To:Cc:Subject:From;
        b=FBICxLxNpPHy2xAOd72h3JQ+oyelUwrlBZYK1gYG3TM2YOyf6yf0kv8ePJBRZEghS
         Tfn8HLsJuL2bv8XhR+9zeDUaQk19vioEfEAIMLjlu4fXuxeJ694CjuJ+3hBaNZ4Wxl
         qe4z4wskPPoGUvmZfdjXg/R8oLy28Dfh1jOpSD8+JlGekxZ+b3a2zX4DHTNZIqy07n
         mJ8B1r9FdjjrFZGkNvpcLQrfowxGWmnD5n0Aqnw7SJjDq76BgA2WQATdklNuwrOcX1
         uziBCsQjeLuhyIeYSS3LwXCxxNL9vS06Krr8Hbv4bG/SaSYES8TGdkluL3ekYlV+41
         zp4r2edWTsY1w==
Date:   Thu, 1 Aug 2019 08:06:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: linux-next: Fixes tag needs some work in the arm64-fixes tree
Message-ID: <20190801080621.18868050@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bNGeYCDyOY0W9=mFDxre+bP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bNGeYCDyOY0W9=mFDxre+bP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  97d5db366224 ("arm64: Lower priority mask for GIC_PRIO_IRQON")

Fixes tag

  Fixes: bd82d4bd21880b7c ("arm64: Fix incorrect irqflag restore for

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/bNGeYCDyOY0W9=mFDxre+bP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CEN0ACgkQAVBC80lX
0GyIOwf8DQXnq1ik65qSHmCxITMfmtJUEi95+ulWnDajaBJYWBVRYVy4hf55GYoi
aZSONjZ2idKiHOJBwBmexaT5Qa2oJiAZ0F5468wgHpL22iX7Zfxrw/psJcl6lJkZ
Cdl5mJC1T29tscH+/LW5KuJqllR/dVWgcKnBaympe36IWGFrD10R6FuYShHGFHe2
aWKPi7mqC/t2IrWbaVH28PBWbEJy962H3X2MHaj38Urw+253pe8lQgC3dN7XomKC
B0eDsJLBONUZDNjspgRnsrYt/9RzKoHos5XbOFTsCerKbaiYx4bVkknZNi0hgJAW
/iVjjW9zBH/GDeQnyhjvtRRHAhp2Aw==
=gjiu
-----END PGP SIGNATURE-----

--Sig_/bNGeYCDyOY0W9=mFDxre+bP--
