Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA84C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A372166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KzpIvl/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfGIAO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:14:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55953 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIAO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:14:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN9D5D0Xz9sMr;
        Tue,  9 Jul 2019 10:14:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631265;
        bh=ziNY+T8PDI7aF89sjkKXpm6vcbsyURjPa7sLeAqpsYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KzpIvl/67nC3TrsV3rNLk1EriMVrxu6j7E3jitCdo3ip1heX2UdUTERICA5GnyO+m
         0fkRy8SIzAKS7towqxUe8vMZcvuvneawNCKv1IA8Nzg2Sv8OUhmhXj4fI/wCoFB4Zo
         /gQUvUM4s2hXIyw9nKjSs4rDBZ4ISHtv2VfwWGX0t4urNhilr3riwv4gYWxnQUfnxg
         A++3PE5QnTp1aqAkC0xTJ7trY1CfRA/aed93In+qgqA0jXPhB0t5l27gsIPCFlM6Co
         hrFMsolCJSe6RsAvj2otDM9zHAKEgqN59jGlyEkAhZ3VC80KmFAWg/DpHu+YbyeJIl
         HnH0dM8zkuWUA==
Date:   Tue, 9 Jul 2019 10:14:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: linux-next: manual merge of the battery tree with the pci tree
Message-ID: <20190709101424.3876cbba@canb.auug.org.au>
In-Reply-To: <20190628135511.34853c19@canb.auug.org.au>
References: <20190628135511.34853c19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z_58xQD3RFHEkQg58PqJwcX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z_58xQD3RFHEkQg58PqJwcX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 28 Jun 2019 13:55:11 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the battery tree got a conflict in:
>=20
>   Documentation/power/power_supply_class.txt
>=20
> between commit:
>=20
>   151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
>=20
> from the pci tree and commit:
>=20
>   49c9cd95bb6d ("power: supply: add input power and voltage limit propert=
ies")
>=20
> from the battery tree.
>=20
> I fixed it up (I deleted the file and adde the following merge fix patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 28 Jun 2019 13:52:44 +1000
> Subject: [PATCH] power: supply: update for conversion to .rst
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/power/power_supply_class.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/power/power_supply_class.rst b/Documentation/p=
ower/power_supply_class.rst
> index 3f2c3fe38a61..883b2ef63119 100644
> --- a/Documentation/power/power_supply_class.rst
> +++ b/Documentation/power/power_supply_class.rst
> @@ -166,6 +166,14 @@ INPUT_CURRENT_LIMIT
>    input current limit programmed by charger. Indicates
>    the current drawn from a charging source.
> =20
> +INPUT_VOLTAGE_LIMIT
> +  input voltage limit programmed by charger. Indicates
> +  the voltage limit from a charging source.
> +
> +INPUT_POWER_LIMIT
> +  input power limit programmed by charger. Indicates
> +  the power limit from a charging source.
> +
>  CHARGE_CONTROL_LIMIT
>    current charge control limit setting
>  CHARGE_CONTROL_LIMIT_MAX
> --=20
> 2.20.1

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z_58xQD3RFHEkQg58PqJwcX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j3GAACgkQAVBC80lX
0GxjXAf/U4L04TKXyCvtyxPsAmwR91YQtPvgh1kk17GKlBNGbFEZKtQOSovdNoN9
sE/LjANqN08JLD6Rj5kFx2YMsu4ummttQoWwcYttbn7DxusjU4nK3ApZAX2Ud5qx
rdfV/Ww2vWDnvRRCvX3WaAZ2WRBWTmk+23dcSg5WttKYZWgG2/zyV52V+Pu2TIsF
rF/kA8F3RWQrMOfNjMCNJFk3D4ojgh6Mjq38HIfREIR5VaVt7ZydKAYodR5h/3bh
rX+oxOYEjoUp6R8/tLQmwXZKfPjsRlMm01AcFKnCQBwzbx5CsYXEPw+ofZ1jMvdM
rILxxRhi1SveO093G/f9IcPKkBhtZw==
=Lm83
-----END PGP SIGNATURE-----

--Sig_/Z_58xQD3RFHEkQg58PqJwcX--
