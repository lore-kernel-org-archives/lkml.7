Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SBxQb+eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCREyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:54:22 -0400
Received: from ozlabs.org ([203.11.71.1]:33083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfCREyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 00:54:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44N3kM747Fz9s47;
        Mon, 18 Mar 2019 15:54:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552884860;
        bh=YwKGOS4Mk5lT/87BG5cwdPJj83rmWo1mIL6kbUp6+38=;
        h=Date:From:To:Cc:Subject:From;
        b=SBxQb+eB0OzP3ufPJui6ixo4Pp4nbvGbWYGwKw2jk1YaA9dc9RQlOTbBa0oKQq8j4
         ifmGDcEHFWL/pVNZ0xJD6inOSF4RWl9P8tilersfWhDN+ZBuapA37H7ts2q4Xk8Afo
         jt8Y+mOWmdnXeYRv6jRTicGORxeabCTeH0yBVHL9+5V4OJdbhmxomZYcOUaPrz7yiV
         AAh/V2Np5tCOstK6wVRg76TMWcaM7bdNEC+I+7PaoJEnX6oUHpWPiGbHZKDUzYvcwd
         pZUqxPIxmWl27giaKPKH+9Sbvo+Z5tCnbIe02J1MGydzkCzoNrA0FI9ItsTRw18mK+
         cciF7qcuHblwg==
Date:   Mon, 18 Mar 2019 15:54:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20190318155419.0e6d34f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JLSLO4MGfOk6rg94xHti=c2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JLSLO4MGfOk6rg94xHti=c2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Commits

  b208c3a940b9 ("drm/amdkfd: avoid HMM change cause circular lock")
  8a3397a108e5 ("drm/amdgpu: use HMM callback to replace mmu notifier")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/JLSLO4MGfOk6rg94xHti=c2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyPJHsACgkQAVBC80lX
0Gz1ewgAmXaUNL20i6dWQ0uvPZo68J+vWkXDBSc/DCESjgsz606PaCxrMt/sj2jF
Tcy294QtNs1x41kYtVa5b0gqMMajToQYGNna/LTBy5SNfiiP2mIH/e9cLjHaSDky
MkMLs09yJVIlVY5KgQPjsBkuTuCe0kRL9Ti9QDK4qXBRieILNbsBgF9GOy/8Vi6y
PQ+3WskSAETJoVWsgA2szYQgsqm/UEjIH4R3YwxZ//glEqOL7dIIs+LJbzaqOFh8
pK31QpHtEnSAx7LmmDqNmyFqM/X/wFI/KupSV6SOcs2kBB9wSR1YbjLevPnRvIjB
1q7wkuKVXLkkVW/3GSzW0Dzr6AR9Cg==
=H66S
-----END PGP SIGNATURE-----

--Sig_/JLSLO4MGfOk6rg94xHti=c2--
