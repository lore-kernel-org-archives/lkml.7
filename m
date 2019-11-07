Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C64C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D0C2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zac4A53N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfKGKiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:38:08 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfKGKiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:38:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4780H0101Vz9sPk;
        Thu,  7 Nov 2019 21:38:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573123084;
        bh=EuCQWBJu7VcB6YgIibTf/Kk620zrgZzJsosDpaxvqdM=;
        h=Date:From:To:Cc:Subject:From;
        b=Zac4A53Nv8XNqQ4sZ8/pK61XgOySwnxndE/EDPi9MccC+O98Zdgvg7AiPN/1IE9i3
         xT5kBCIUO2zJmh7aAKK32TRXwO30xS9t+6+gwTMwHqW0PXU9gJVs7ArgZE2HswmWGr
         dg2rQ8zyI+ptFHDMcXr4kvr5rCf3TLvpZXxQunK+7D03MPRvNhXx8+YoxsYaP5KA98
         99MVXL4cSSWH7l6/oVxGux+GXVT3GcouTghoAU0GpawbOGoJ3PByLXLZTL8EPGz7BQ
         0G6RodfBjhytJ8a/8jpTkMhTrAR45avbcbKw3eLNGs+IV1Bi04CSATMUl9EXsfqaAs
         CMeRt6dGcETcQ==
Date:   Thu, 7 Nov 2019 21:38:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the xen-tip tree
Message-ID: <20191107213800.02ba8bbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SPy0IXJ7vjzuzfT3wDsAJ6w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SPy0IXJ7vjzuzfT3wDsAJ6w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  68a7cae93bf9 ("xen: mm: make xen_mm_init static")
  34fbb76d009d ("xen: mm: include <xen/xen-ops.h> for missing declarations")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SPy0IXJ7vjzuzfT3wDsAJ6w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3D9AgACgkQAVBC80lX
0GxZeQf/YpWL5o1rsY+ESuow6Wssv+5TsmAYRd+CUjXVj2292BIhNqkPJJuv8nQj
G5UOt2553CBCEH99G4RTPKg9oHluBEeD25zmofWEp2Z9W4mGBtojPt/UojfIkX+8
+rrL8dnza2KcLan7+GUqioYM5VwVYoAffZS56SbirF0S8EDOySl1ud1QR6AYSTR7
NIglQ/U6AmZ/NPqXE11//JBQU+gXtVY5sg84dO/F+NO3FA1jNTmpv8ZdN/V0W/55
dh+A0Yi9Ju0Oxbwp9a9XRAQa35a1tjzfo+cRBXuCg/Drk7PWEnvLUmSJzsY22xP1
PagcVpaE5XnbCHhQHRYt46gVQPIz5w==
=PtIn
-----END PGP SIGNATURE-----

--Sig_/SPy0IXJ7vjzuzfT3wDsAJ6w--
