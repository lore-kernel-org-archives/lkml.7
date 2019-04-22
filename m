Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF9EC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AAC20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e+3kQonw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDVFjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 01:39:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDVFjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 01:39:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44nb4l5l7nz9s55;
        Mon, 22 Apr 2019 15:39:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555911591;
        bh=5gXmPWSkXyOLYChjl6b8S8muQNAnO0yX3ZyMpGazfSc=;
        h=Date:From:To:Cc:Subject:From;
        b=e+3kQonwGrzxDA9M5KI97a7dweLNQYKaWwf8id67/8ag7ImTaEItuapQrghja1FVM
         qrkNYgh2YQRLlVzonl/hYk+qIFtA+5svb5NQnBACL7wXBmsH8ExXpg6G8kt+H7VmPW
         usf8HTc5SkoyZO5yuxhpuQV8Wnz39Vq946uhJyuR3xb+qZJGsJAClGIk8/U+O8PD6+
         lsnR4RhCQC4oRv0L/f8pusi61hPzom5AabOP4GzeJGBu8DjHhPP3Lh4ZXprregqwm9
         C/aFp0TLsRnQaY2hc/1dfKoTB5YP+ivD5hojWyiDXfNKgcTMT/XHHrNkuZqPlVwLHi
         IbvW68OeT3ZAQ==
Date:   Mon, 22 Apr 2019 15:39:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: linux-next: Fixes tag needs some work in the powerpc-fixes tree
Message-ID: <20190422153950.4488fd7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M8qfRr2dOHX9cZdNwPpP24Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M8qfRr2dOHX9cZdNwPpP24Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7a3a4d763837 ("powerpc/mm_iommu: Allow pinning large regions")

Fixes tag

  Fixes: 678e174c4c16 ("powerpc/mm/iommu: allow migration of cma allocated =
pages during mm_iommu_do_alloc", 2019-03-05)

has these problem(s):

  - the ", 2019-03-05" is unexpected in a Fixes tag
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

In commit

  eb9d7a62c386 ("powerpc/mm_iommu: Fix potential deadlock")

Fixes tag

  Fixes: c10c21efa4bc ("powerpc/vfio/iommu/kvm: Do not pin device memory", =
2018-12-19)

has these problem(s):

  - the ", 2018-12-19" is unexpected in a Fixes tag
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/M8qfRr2dOHX9cZdNwPpP24Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly9U6YACgkQAVBC80lX
0GzuwQf/Tg5k2+JLzmQv71XXAvomr8zCS4BkJSMEjYmBlJU/n+QbiamyueqJX3Wb
PHYZQaPROrgZ5zCwuqpNA529ZUXvmRWtNWYVeEMz830VRtJzfapi6IsRlhRUkClU
jSH0joMAHnasT5Z13IDEBUaFY3UaDrXL8fTBu3OUwrUB8ei730wLg9nJKoeVHrLl
zWmAodxzHVK4sDKBJcDDSqEedL7lHancj8ATWuspJ2zAOaMRWQ8hJ3lobmahWBV4
TRVKLMLCrF5FVIUprbdsNARk2r0UPTHrVNIET6faU0rmaHp5nP5xcyY5qN3+1kbB
7kdAjVR69dc4fcGFwQ/GUaaik/4usg==
=0q47
-----END PGP SIGNATURE-----

--Sig_/M8qfRr2dOHX9cZdNwPpP24Q--
