Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C38C606D4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E86E2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OTAcW/C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfGIAR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:17:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIAR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:17:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jNFH2W5cz9s7T;
        Tue,  9 Jul 2019 10:17:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631476;
        bh=lp21XVmr94RjmaXIYaqt7yfBze2ly3TCDE+T5re+5rY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OTAcW/C4AuMBkOT91yjFKDVktQnNCZIWuO3fyWgqUnxNq9esbXVFKu18N81zL0Vx9
         ySXZkRfdYTIc9ilLZ5P9yECpCLZGqExgeveA1XGAvle2FgPivDl9VnGa6HeWTGDt+s
         V/4Y4+SrKCurleHkd6MVaEKWMVISGQtPVkXTMD7GmJorbf7rx9wPmzrCri49U89qXR
         GdFHfo1eybKCpgV1M/9FPCFIpwDCmU2MilISzsLPfKdhszhFwEGhfakXx9ldtp9Uyg
         kBA0QdM2SyvI3sz+kXu9Em9ysB5j6+XP1+avjDvbod+t89NN55Vy8zfleE+Z0kYZyO
         Ozvy008cKMlMA==
Date:   Tue, 9 Jul 2019 10:17:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Len Brown <len.brown@intel.com>
Subject: Re: linux-next: manual merge of the tip tree with the hwmon-staging
 tree
Message-ID: <20190709101754.1836ac73@canb.auug.org.au>
In-Reply-To: <20190701171524.774dfc75@canb.auug.org.au>
References: <20190701171524.774dfc75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xsNrBZ8CSrMvZiWfq8.boU1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xsNrBZ8CSrMvZiWfq8.boU1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 1 Jul 2019 17:15:24 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   drivers/hwmon/coretemp.c
>=20
> between commit:
>=20
>   601fdf7e6635 ("hwmon: Correct struct allocation style")
>=20
> from the hwmon-staging tree and commit:
>=20
>   835896a59b95 ("hwmon/coretemp: Cosmetic: Rename internal variables to z=
ones from packages")
>=20
> from the tip tree.
>=20
> I fixed it up (the comment fixed in the latter was also fixed in the
> former) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/xsNrBZ8CSrMvZiWfq8.boU1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j3TIACgkQAVBC80lX
0Gz2PggAkIgVKxBWr7Dq+tRDT6iulMKeirJtBRN2V+WAhx03NcljBfmYx6u7y4tW
6XHNt2Pn5WTKukkWKbI7oEGuVS3ohKyCRjfqRUfXV8KMZLnpAvJXqcwbeCMSTLcr
OXlKaEKLLMN0YDXAjIT7dLfj/Klj+O3InTCgCyVtVJ5E9EaIqVPFj5X7Pkdd4l56
WklOfzbK0HQ1d7j1wVZSh697W6eipJOdKtLAHNdAQOeJ8YeTa4pCLvoZb3NmryWG
SdmIgWZ3o2H3SAZ589VWFZpDQlQ6dpRSNLpYKso2iA1DATlfQOblOhRlcWBf9p+Q
S+B/drAnWPyMHQrp2Mvd6CkoVCGYUQ==
=MoZU
-----END PGP SIGNATURE-----

--Sig_/xsNrBZ8CSrMvZiWfq8.boU1--
