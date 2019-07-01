Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD1C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67B206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L3hN91XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGAV6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:58:51 -0400
Received: from ozlabs.org ([203.11.71.1]:40639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfGAV6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:58:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d1V01j0pz9sCJ;
        Tue,  2 Jul 2019 07:58:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562018328;
        bh=9J0wwKydLgdI3bsqjijZAdXUoxwhwPYQ2053nI3tnlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L3hN91XZRsdQqfWVL7zYEK3pnSJM8qpspiiepWvLgqdVCzA1jU4Yog/AliLeI6i+Y
         /5Bp2leJ+XfNGxRMMy/KBZAlBWrfqAZAzztgw5H3diDvZ0IFA+ZuB2lVQhFBUPa024
         6HXzrbPVhuIbIVwHGXLFti3FdqJEAq5DP2uTVAV2X2rzeu/bEmCh5evOofQjP4L4DS
         rr3oajdyjPWufgIUv6nIDCIkL/Um6CmqbdfCwBytyetQEYthULIlgbqTaHp25FuSvD
         Q0Xbmtz6j4LRaUPMTqrkjwwoO2k6BB6a6ml3hHOTw5HNkoPmyLcv15oSIzDsH0AFDN
         hLc++z5Mqd1pw==
Date:   Tue, 2 Jul 2019 07:58:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190702075846.6f373a58@canb.auug.org.au>
In-Reply-To: <20190701200418.GA72724@archlinux-epyc>
References: <20190701190940.7f23ac15@canb.auug.org.au>
        <20190701200418.GA72724@archlinux-epyc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3IQtb/CvFm.9JjvfO5fLJ=s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3IQtb/CvFm.9JjvfO5fLJ=s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 1 Jul 2019 13:04:18 -0700 Nathan Chancellor <natechancellor@gmail.c=
om> wrote:
>
> It looks like a similar fix is needed for the vhost tree because of
> commit edcd69ab9a32 ("iommu: Add virtio-iommu driver") interacting with
> commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with
> class_find_device()") in the driver-core tree (my patch is attached).

Thanks for noticing that, I will add that to the merge of the vhost
tree from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/3IQtb/CvFm.9JjvfO5fLJ=s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0aghYACgkQAVBC80lX
0GwPnwf9EmXJg8/6H7wzvSSvMfy0MgctHyI6oXQHJfUwuL0oar5P3pWr4yamQlY6
l52vQ4E5A3FAeI73GVP6Na8NRYQU0ZseB2ghuUXz+vpgdLkvw9dSSSjUBQNTUGOe
fD4EN+mYXgnK4ptuA3H1e7Yhf6fYHmbo3nkx/vsG2eu6y3FFVroQqLRlClb5ODHx
474YMfpV15jeT0sCkURNuNb31f0kB18Yj06kF2FevOxT87Z3oozSfYWXjdqP39Va
GUyMRUKMwGsadVN1jIhPUgq0YvSIKnZSKD0RHMzS71kkR5OYHyobWR5BDlZUNHhz
kT5AYqsAhZXA4ZlPAe99DRk1IHoaYA==
=/zz9
-----END PGP SIGNATURE-----

--Sig_/3IQtb/CvFm.9JjvfO5fLJ=s--
