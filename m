Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930CEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D352064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gmBhFcDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDJE5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:57:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfDJE5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:57:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44fBjW1gNJz9s70;
        Wed, 10 Apr 2019 14:57:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554872255;
        bh=Btrdz7i7x5EOKLR+Lg27ae02lPlFzwufJT+E8BqDjZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gmBhFcDCw4iiQBt8UbvmcdVqJwm6iiG5ce2x1uhxBGKUGTke7ztrOgqXxR/Nvsa6N
         6WyqbpfbpAjGUobjrAj9BVUaTnL07M59dQyRneZXFj1J6WP3WWnXh9WrXcp3V0Jckq
         vCNB1Ta6OVcoGUirWCNw9mF1/u7M63+cOLVi660Ow0UmrsDW+jzRJOVqPm1NyCor3y
         tDxdgEUYkqy+GeYSOb0/Uy/X4a768MLDxf8QjD+7Omi2u29KfdWi2Q61XwksR+gfLe
         IOJGJKWk1Z1Q2kBHgY6hN4dSP9oy/P16sOHJqEprhw6XVrBu+Uq9OocfE/iRwn9hKa
         T+eShoVsAGirQ==
Date:   Wed, 10 Apr 2019 14:57:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20190410145734.150e881c@canb.auug.org.au>
In-Reply-To: <1554869059.3208.0.camel@HansenPartnership.com>
References: <20190409162749.7eb6656f@canb.auug.org.au>
        <20190410112138.178aa7bd@canb.auug.org.au>
        <yq1tvf6myp6.fsf@oracle.com>
        <1554869059.3208.0.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wbmrv9PJSc+XgRhNyovFeHs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wbmrv9PJSc+XgRhNyovFeHs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 10 Apr 2019 06:04:19 +0200 James Bottomley <James.Bottomley@HansenP=
artnership.com> wrote:
>
> On Tue, 2019-04-09 at 21:33 -0400, Martin K. Petersen wrote:
> >  =20
> > > > I have reverted that commit for today. =20
> > >=20
> > > This has now migrated to the scsi tree. =20
> >=20
> > I have a fix in my tree but I haven't pushed it yet. =20
>=20
> It's upstream in both trees now.

Thanks, it'll be in -next tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wbmrv9PJSc+XgRhNyovFeHs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytd74ACgkQAVBC80lX
0GwAxQf9G/Oe1vx4RmBGQbAqqUzUf9qqKv56OZYl2ZlDh8RUkobpvr4IhSDcRpiQ
IYIGdZpmIhMkJY8J5775ZHl0VOazURYYoF2QfHCR4OUaj0HIrDinHHvk8a0XX/7C
Gxs46pST9T4OnZ8NvdBpw71zZRVRtQefJBBSZCYsQuy8kIwt7+4YGciUMWFEX4Yn
g+Kp8LCB7g3Oh4JzMQT2sj5SlP6kS01ysKS5qJFhMMn3jFH0iNZw8u8fek/pnwwu
F5klR+nqHBHdK45c/vYT1efwrfHPTZnOaaAyb7H4yGPYdClCHoRlhJRJvROg8jtz
sJm69uav7e3I9EOaq/KdvNWltzxwVQ==
=g+UW
-----END PGP SIGNATURE-----

--Sig_/Wbmrv9PJSc+XgRhNyovFeHs--
