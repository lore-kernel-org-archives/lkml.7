Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1CC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FD321530
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GwZ/vVL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfE1Bnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 21:43:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfE1Bnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 21:43:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Cc7X5srfz9s3Z;
        Tue, 28 May 2019 11:43:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559007817;
        bh=oSAUCdsXrwBpxO6SXoSycFX+BjSh/Yzn/OxmM7fGB78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GwZ/vVL9ghZoFBUQHhe/lcKFf7m8mU0IFT9HQ2+OXPxBw/oaP5uRwGapAOOTdfb4h
         7dNSVUcGC7BY4KDTbWs07J9bXMoSrAarXxXD69xUthjiYQlNcwautFdSHWac6Y9i1e
         wJ8yino+sHKHfaE6HloY06TkgXAhk51f22bYStVSWXKMKtyMedH6ztRgt7OvNrCKC9
         kXn316729q/iykpupwitOKdQqhjoyYQsq6Q8RVAF/Edv+o2p6tuC3r6Zjc+NXM3tEN
         z/F7qGcC5yVoXnp7Fo3qDokyjlYVp2VA3Gwgj73uOo1ook91IRjme/DHwmCM+smPn/
         sHSzHjqJ0tgcg==
Date:   Tue, 28 May 2019 11:43:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190528114320.30637398@canb.auug.org.au>
In-Reply-To: <20190522100808.66994f6b@canb.auug.org.au>
References: <20190522100808.66994f6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ibMx_bKOKGX3xtWWDe/Ioda"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ibMx_bKOKGX3xtWWDe/Ioda
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 May 2019 10:08:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the scsi tree got conflicts in:
>=20
>   drivers/scsi/hosts.c
>   drivers/scsi/libsas/sas_task.c
>   drivers/scsi/scsi.c
>   drivers/scsi/scsi_error.c
>   drivers/scsi/scsi_ioctl.c
>   drivers/scsi/scsi_lib.c
>   drivers/scsi/scsi_pm.c
>   drivers/scsi/scsi_sysfs.c
>   drivers/scsi/sd.c
>   drivers/scsi/sr.c
>   drivers/scsi/st.c
>=20
> between commits:
>=20
>   457c89965399 ("treewide: Add SPDX license identifier for missed files")
>   09c434b8a004 ("treewide: Add SPDX license identifier for more missed fi=
les")
>=20
> from Linus' tree and commits:
>=20
>   026104bfa591 ("scsi: core: add SPDX tags to scsi midlayer files missing=
 licensing information")
>   5502239e73e6 ("scsi: libsas: add a SPDX tag to sas_task.c")
>   5897b844b7f9 ("scsi: sd: add a SPDX tag to sd.c")
>   95b04a2ff9c7 ("scsi: sr: add a SPDX tag to sr.c")
>   50a1ea5bebbc ("scsi: st: add a SPDX tag to st.c")

I have now got more of these conflicts in

drivers/scsi/libsas/sas_init.c
drivers/scsi/libsas/sas_internal.h
drivers/scsi/libsas/sas_scsi_host.c
drivers/scsi/sg.c
include/scsi/libsas.h
include/scsi/sas.h

--=20
Cheers,
Stephen Rothwell

--Sig_/ibMx_bKOKGX3xtWWDe/Ioda
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzskjgACgkQAVBC80lX
0GyXSAf+Pf763d98+SPy9OOkwWytZPNe3WTxdCOWUbqZJcYLCjVCy1HcVqHf+h30
G/jnXEmqJpGKNL8+GJ186i55eAq6anTwZm4FgFgNyAU5WSnmq2xNpoqgoY+oFkK/
QKHmcJQzBu8Rtb6uKAGaE17eaY6XP8Fjvrqjo2aECNZ20QCOLZUEkTuJcNYN3f+s
0KVe2+e28rF75cw1Ue46F6BC21vWOu4DdZlLulSpcJW//w7U0UkS5IwvKSCWQJ7R
EeorzmTa32dt4av3iPZMNjYIpS4+R4skxDJPUsdSjox7dtJacS2f4QndFBVth+VQ
mHkJwmW+x+u8AmpyG9x6or6SZGTgiA==
=0fj2
-----END PGP SIGNATURE-----

--Sig_/ibMx_bKOKGX3xtWWDe/Ioda--
