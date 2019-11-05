Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08410CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8500214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gAJaJ2CU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfKEC2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:28:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfKEC2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:28:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 476YW24dTjz9sP6;
        Tue,  5 Nov 2019 13:28:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572920910;
        bh=YuJJBevMNH24b4uO51gTHuzv4G0CuabsCvDy05//4G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gAJaJ2CUmC8oVMi3iZd4UuUGVzzkiiNQMPrsXzgInOcf5vTK6PCoH0M3jH0oB2DSZ
         cqlwtiK2JwK/8mKn3tJTOi1xOuN7U22jmyyLsj0w/Thi/UCMKJtDthPtiaxGm9gI8n
         WGYqldv2Od2Xru0tBYyx/1a/PgOTbkgBXMyAQt9gR5+ZMr6dlaNdTnRiOdol8qxz5N
         /1sXBJVv7Cw4FS5iqDlGkjQgS4U6fMu7E5w3Wq/mjk59iWEzIHD0tt6U+Zx9syAHHQ
         5o/l8EZE8PPpnel3QPNKyOyDbfH0wM0hmjnphJ4OKKM7zYxR1qSTf8t82Ys/tmxlSw
         J3NTzMpXhGJVw==
Date:   Tue, 5 Nov 2019 13:28:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20191105132830.398ef72f@canb.auug.org.au>
In-Reply-To: <20191105022109.GL22766@mellanox.com>
References: <20191105121704.72edfc76@canb.auug.org.au>
        <20191105022109.GL22766@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+7MuN0yjWrb+Xp4mTNcejU6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+7MuN0yjWrb+Xp4mTNcejU6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, 5 Nov 2019 02:21:13 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> The rdma for-next tree is right as is, the xa_erase does not need to
> be the irq varient here.

OK, thanks.  I will fix up my resolution for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/+7MuN0yjWrb+Xp4mTNcejU6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3A3k4ACgkQAVBC80lX
0GxCbAf9HXkvSzM6mNfwu8YhrZ+9IGEOrbb1MO+Mv2zZWJqc0GKDIb4rnxKrZ7AZ
g3S2cElxSh8vyqvCH0Yv1XlryzF+3EH+m8g0DkhpmBSYPCLOdDuhARqGIb9YtU5z
ExNFxdF5PDp0paSMTOkjJFBipNsvFSv1IC3XFuMbSB+tc5G4ZE1YBEUp44Lwvq4i
RN0iNgcEI1Or1w5UhDPL7ZyIgz5qJUmOwmbD149xc9+2iuGWp/ICruqRAglp7AGG
mEVB+nHpPvrhEqANuKED7xVrk8T/ZnCiBRjayys5EpXQzNaTlKmzEKo2MoMH12t5
Vu+GvrusRHORlAZrFPXR/SdVGCWgIQ==
=kQLu
-----END PGP SIGNATURE-----

--Sig_/+7MuN0yjWrb+Xp4mTNcejU6--
