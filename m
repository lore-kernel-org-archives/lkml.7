Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B320821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GiXAHf5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfDPVSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:18:03 -0400
Received: from ozlabs.org ([203.11.71.1]:56565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPVSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:18:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kJB01xvlz9s9h;
        Wed, 17 Apr 2019 07:18:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555449480;
        bh=HdKhmrQPyP46jx9ir4DYnSUSdv9O8EE1v1gLlxuHH0w=;
        h=Date:From:To:Cc:Subject:From;
        b=GiXAHf5xVCkYn1x28Y5VThohBQNWekwWQzxDqsO6M2mKwJ5z4n0VaoPJ+EwPu6PQ9
         BZppdYSmD29G7ZBdE0iDEggaM6inWH5UeXGgcKQAl3PQ6qdL1M0cMCqhzWbpt1yxIJ
         DI5Om8xZT80D1rweczXBYXWQqq0BqPRTzj6sv20AwxNs5QtOn92tNj5txfSMOiGfMW
         HpFLfsQykbwVXaBUsIgbcvUdQnGlyWd+iK/+eTl9hnyDiSV0tBEtEIOshZG1EHPMrk
         bYg5G8uacIS43W8hkYVIdn7X7wqTJTbYLpOeCf2qKXith1L79mniclKIC7LAWeD46B
         x96uK12iks3Ug==
Date:   Wed, 17 Apr 2019 07:17:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: linux-next: Fixes tag needs some work in the drivers-x86-fixes tree
Message-ID: <20190417071754.0fcdef3f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ax4i8/oG68w.a6eeHy8nS9N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ax4i8/oG68w.a6eeHy8nS9N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  57f634b76a95 ("platform/x86: dell-laptop: fix rfkill functionality")

Fixes tag

  Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM c=
alls")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ax4i8/oG68w.a6eeHy8nS9N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly2RoIACgkQAVBC80lX
0Gwd4gf/XK9fWs+FiqliM5SmT/5Vmdo6F6jpasC26Atf0Y23x5FTwX1zLO8EEaF4
WGLIExQaJ8mzIl2ktJpVxVK3sZZIOeu6bL7wupz+QqqDhz6kZbB86sHv7SmnkdXk
3ttr8/nmmGgW9tJTBn0iP9rAjAA0rel6wA/Ki2sCoS9xNMg8+taN3eg7Kh+kQDuM
HO/QxK+3iwx/gY+KpGuw7R8+1e0JpNKgtT9RWXrvnsRA2TDD+Z2LVAfLfxmK8miW
0/bQQCgOTmmH/N+Ouzlevk8Qft4r8Mat4PEadFmKL/RGcwirFvRsbkgitQOqpjsx
pZ0CRSo9FbqagCYQcCIgmPHXq/Q+cA==
=1Lar
-----END PGP SIGNATURE-----

--Sig_/ax4i8/oG68w.a6eeHy8nS9N--
