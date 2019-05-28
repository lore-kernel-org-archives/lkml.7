Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2FAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B200217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N1rRezHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfE1V5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:57:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfE1V5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:57:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45D74P3fWJz9s5c;
        Wed, 29 May 2019 07:57:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559080661;
        bh=X63D2HiDSSgYemceoeABbUEoxHvV1nckjW17ym5koUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N1rRezHYgSVQJQU1Z4AkEw3DUYoHztFPCxCs0Xpv2CvwoKPl/+MDn5IFWS7+CpKu7
         5suDMFE+6a5yHgI8Zy9Y54h5B8/dRveNtuyRGZxSOBOky1HpRITQ+FGaawX20BrFr4
         PuYqFdlttU9KX3VCQNySIa8z4SRHLPXGmDMZsMgQZhMrKHSPo2TqLXDessV/JX346h
         frV+RFQoi2hVzNG4cxWBgpdsiUxiUQSbYj6ST3vAV/LWQwlFT4Vq/IrE2e3nRjV03z
         AlGZHMwQn+Sc1rzGBFt60LViW16sD2tnC3YD8ZCnNtSMsAxOKZ9SOx0DY8gKM4UWR0
         z+Zql1pT6B13Q==
Date:   Wed, 29 May 2019 07:57:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: linux-next: Fixes tags need some work in the sound-asoc tree
Message-ID: <20190529075740.3bffa68e@canb.auug.org.au>
In-Reply-To: <20190529075614.150b1877@canb.auug.org.au>
References: <20190529075614.150b1877@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qH529Lk_BOdN1y00vVOLvmz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qH529Lk_BOdN1y00vVOLvmz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

This should have referred to the sound-asoc-fixes tree, sorry.

--=20
Cheers,
Stephen Rothwell

--Sig_/qH529Lk_BOdN1y00vVOLvmz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlztrtQACgkQAVBC80lX
0GyRggf+I3JxPVuptmsSMb4YYn37Lqc0iPeYevJ69ggmjuqoW016svAyvQChlZix
Jp+4blIaadmbp/gu9pDZTDGaQrCA7Q7Lj98xD7Fpnpin82smwI188nR1+bxUQLxj
KM7ZcbnJQL9mBW/BeDQ6dVDhVFPGJ+ZjaguCuFvj4yq0iDsWrGVxpG4pd9z7R1pb
UPtJ7MKqZOjZoSMrpmLuqzmzDycb+j1bvxCGRu5vw8CPJOtixBAHJQrjpSYqKt6b
n/pB+eKMLChNiPBcroDUZrVUPpmeqF8JUmSx5hhJZYf0YYOcFefJLw1p680G8kYT
zjAPSyoN8IvO74zMRUyca9QUNXp8Sg==
=J4eU
-----END PGP SIGNATURE-----

--Sig_/qH529Lk_BOdN1y00vVOLvmz--
