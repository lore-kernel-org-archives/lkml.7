Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8500C206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FICrb9z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbfEXKlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:41:37 -0400
Received: from ozlabs.org ([203.11.71.1]:57047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390312AbfEXKlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:41:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 459NG51r9dz9s6w;
        Fri, 24 May 2019 20:41:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558694494;
        bh=ZgWKFfxHvwpM8Wtk7Zc4j9EyrdKEfULQCXmeKuMZL2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FICrb9z1efYrymNjagrBKaXUcgEciJG4KmwVwjWqcw5giDjWLEn1E6pIaIJGZxtxI
         nHaLOXkwWWGUDgMhE4MRg5JamsL2CuIE1cCNw4YGqJIhu/MmARgEJKKPakiUV0WqB8
         uYPaQb08uACB+x/E/2W0EUBS9P4+APcrop+km4tr69LGExxpbBYxv9OoGSZaG54Eyo
         30ArngiFovzt0QFTagPSOQdFRz6BX/kuA/QgdcRb36QnEgAkADF2UcqadpLqVUNV7R
         ABQlUX9QEJ+lPrVo3i+MBfUAAAbVVbG02h2Q8VEfjLgrcwf0igZiQ+wK2V//3jw5ID
         zqSuCiJinV/yg==
Date:   Fri, 24 May 2019 20:41:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: linux-next: build failure after merge of the drm-fixes tree
Message-ID: <20190524204130.35fd2b63@canb.auug.org.au>
In-Reply-To: <20190524201548.2e8594a2@canb.auug.org.au>
References: <20190524082926.6e1a7d8f@canb.auug.org.au>
        <CAKMK7uGSfOev71DKF+ygRjU0rMWcrW3rL7-=Xhbwdm9STUWntQ@mail.gmail.com>
        <20190524201548.2e8594a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=wMrdjYPpv2SAVt7Y0+ABtL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=wMrdjYPpv2SAVt7Y0+ABtL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 24 May 2019 20:15:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Ah, in the drm-fixes tree, the definition of  is protected by
                                               ^
ASICREV_IS_PICASSO

--=20
Cheers,
Stephen Rothwell

--Sig_/=wMrdjYPpv2SAVt7Y0+ABtL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznyloACgkQAVBC80lX
0GxJbQgAj0dhFiXefIMEVotDJekVsFhb6aKrghhuZ5tUdUEO2J3VmCpA/kRwUPQj
NgfgVp3d6uOl8WKJvzKxmeH8XUQ+fr13I2rO6ltRKIODWW5Hs+iAHd5lp3EkWF9M
OFNuM2HuUFV+HIymiD6Nq1Jx8uElzK0lwlCi1LarO3Zeo4orB1B6/TdxQvXuOVTD
xXLaAM5hvuFF0e8SicPturJ16laxlfH1snCI8gtjmxol7KG1QGWQyUi+Bf3MfQQk
9tOWZ9Y5Yz3Kz8SOInDpvrEXm14nQ7OWP/n6FLVxCo0UGsL3vkJdaOyCqcr1ojMb
ZIndbfGIyM2VomQ8oZhTaC3kAjc0ow==
=rVue
-----END PGP SIGNATURE-----

--Sig_/=wMrdjYPpv2SAVt7Y0+ABtL--
