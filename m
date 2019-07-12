Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F842C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E6C20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HjnWyp00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfGLAxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:53:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfGLAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:53:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lDv92wx4z9sDB;
        Fri, 12 Jul 2019 10:53:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562892821;
        bh=9nqnT4c5xDJ2xkLnLYje3wmXodcWe5kPWN3E0U3MmtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjnWyp00LftPpNJK/I3sO4QMdYODaTxoWMx3wV5gnrW2SEQW1wUP3HviLTcbV3jOs
         TEO2B72iEQNMBEkEhZAqt6Vtu4Sd9k7NeVF4hcYOX8+6uiAvhQx8KEm7H/l9m/4dMk
         c4N0hrBzNyeG8u2UnlxBX/xuXirgkXqhJgWUb2BK5TvNASbD7PZV/vmK3/IZmLW2oe
         ZE6ZQIsbzJJHpFmqn40w45Mc3nUHNtwUHPCb8aqf58+PB0TD9kIf4odmINyqP2xFEu
         g0qOOg3gDW2tzu9kffhmYpiw78J1FffeUw7NU5imKlMskcuRthbq5BfzXsrwosX69j
         V9l9j5i0k/W1A==
Date:   Fri, 12 Jul 2019 10:53:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190712105340.1520bce0@canb.auug.org.au>
In-Reply-To: <20190701190940.7f23ac15@canb.auug.org.au>
References: <20190701190940.7f23ac15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lsCaH7KgcM/R.cV75LDzF0."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lsCaH7KgcM/R.cV75LDzF0.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 1 Jul 2019 19:09:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the char-misc tree got a conflict in:
>=20
>   drivers/hwtracing/coresight/of_coresight.c
>=20
> between commit:
>=20
>   418e3ea157ef ("bus_find_device: Unify the match callback with class_fin=
d_device")
>=20
> from the driver-core tree and commits:
>=20
>   22aa495a6477 ("coresight: Rename of_coresight to coresight-platform")
>   20961aea982e ("coresight: platform: Use fwnode handle for device search=
")
>=20
> from the char-misc tree.
>=20
> I fixed it up (I removed the file and added the following merge fix patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 1 Jul 2019 19:07:20 +1000
> Subject: [PATCH] coresight: fix for "bus_find_device: Unify the match cal=
lback
>  with class_find_device"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/h=
wtracing/coresight/coresight-platform.c
> index 3c5ceda8db24..fc67f6ae0b3e 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -37,7 +37,7 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
> =20
> -int coresight_device_fwnode_match(struct device *dev, void *fwnode)
> +int coresight_device_fwnode_match(struct device *dev, const void *fwnode)
>  {
>  	return dev_fwnode(dev) =3D=3D fwnode;
>  }

This is now a conflict between the driver-core tree and Linus' tree.

The declaration of coresight_device_fwnode_match() also needs fixing up
in drivers/hwtracing/coresight/coresight-priv.h (as done in the patch
below supplied by Nathan Chancellor).

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 1 Jul 2019 11:28:08 -0700
Subject: [PATCH] coresight: Make the coresight_device_fwnode_match declarat=
ion's fwnode parameter const

drivers/hwtracing/coresight/coresight.c:1051:11: error: incompatible pointe=
r types passing 'int (struct device *, void *)' to parameter of type 'int (=
*)(struct device *, const void *)' [-Werror,-Wincompatible-pointer-types]
                                      coresight_device_fwnode_match);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:173:17: note: passing argument to parameter 'match' =
here
                               int (*match)(struct device *dev, const void =
*data));
                                     ^
1 error generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtraci=
ng/coresight/coresight-priv.h
index 8b07fe55395a..7d401790dd7e 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -202,6 +202,6 @@ static inline void *coresight_get_uci_data(const struct=
 amba_id *id)
=20
 void coresight_release_platform_data(struct coresight_platform_data *pdata=
);
=20
-int coresight_device_fwnode_match(struct device *dev, void *fwnode);
+int coresight_device_fwnode_match(struct device *dev, const void *fwnode);
=20
 #endif
--=20
2.22.0

--=20
Cheers,
Stephen Rothwell

--Sig_/lsCaH7KgcM/R.cV75LDzF0.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0n2hQACgkQAVBC80lX
0GzZbAf+IIK26LPqifxVvuY00AX/q8lGWfwgoia+ByrQtdBWo3hM0xWDdoUwxLjp
T8IgdOy1Q2nBr8FYLVK6Y5cCgcbbI2AzK3W39g2jZ1MD9AtRZEVpXNlx/RMM4bwn
rFcNFVyVt4EjFGqJ1PfpXkBEyBwc3vwDOVeFF7xYRoXgkLh9xNH1Z1KS3iqZ3bZ6
EvrZ7lZdb5wJ8arfc2KAilcpUsbmoPqnFhudA5TyOOCX883ZqxL6lGYD5VCkxq1l
J8/b02JzlGxZI2y8SLHF74s9Y1sktVASgdlhNHop/QKopckK1n1LRZT9t7skAyPH
eb5lo2yeV+O36KY3JW/fZZIXNl6aXQ==
=NuX5
-----END PGP SIGNATURE-----

--Sig_/lsCaH7KgcM/R.cV75LDzF0.--
