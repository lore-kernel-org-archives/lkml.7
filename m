Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1413C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B091B20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L1zwo2Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfDPGxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:53:00 -0400
Received: from ozlabs.org ([203.11.71.1]:34713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfDPGxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:53:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jwzs24ggz9s3q;
        Tue, 16 Apr 2019 16:52:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555397577;
        bh=LGTeO9ELlP2NFCk/KyjOwYoj7ablS8buG8s4m7Ermsw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L1zwo2Je4GJSln3X6QPXXfU/evLSh7Z1dPVuB+j6yuzNsgnnk/uWZIk18owXZUx11
         q59G2dpqCnnQW4g2RSW9tKnVGC2uHUAd16bVzswlAFvy6bAKtUDSiu45GJP7ZDJfu0
         hxJHnTGWBvKEoZT636DCIhstLgsbPzC3iQ6rrjxKzcfe66NIeJg1ujVCWeMND95JiK
         Tyzj7Zr4BN4Jm4Ns2QhrGeO88/awUdU1YT744PfFFYZv/Kp9deHMeFvDV8ZXef792Y
         Tkdt+NDrh6e4c66nuD66MPX4ToqKc+heecqrzmwYyFBd81RpcQ06nntHAd5yzKj7Iv
         NF+t4AF45i9BQ==
Date:   Tue, 16 Apr 2019 16:52:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        George Spelvin <lkml@sdf.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190416165256.1fbf2445@canb.auug.org.au>
In-Reply-To: <20190329133914.45a4a255@canb.auug.org.au>
References: <20190329133914.45a4a255@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XYLkmfGc2/zB5gjO9VQDMAM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XYLkmfGc2/zB5gjO9VQDMAM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 29 Mar 2019 13:39:14 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> lib/list_sort.c:17:36: warning: 'pure' attribute ignored [-Wattributes]
>    struct list_head const *, struct list_head const *);
>                                     ^~~~~~~~~
>=20
> Introduced by commit
>=20
>   820c81be5237 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")

I am still getting that warning :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/XYLkmfGc2/zB5gjO9VQDMAM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1e8gACgkQAVBC80lX
0Gyr2Af8CgFxfluH1FgLdb+1E9LjxKmQbweuEQV2/GXQ6ipMQ/P5h3gzQcwA0mXs
USAXvqcjF8bNVNEX7azE/yFJIvbmXZCWzArrl2hGrVhg88nx45dljHHQ5mhgymPk
V538RoJXEGRWkvtJ+mMCJokwq529anFfco8I+82yxFGexf+wC988TLkvyLqyxTv+
cNRYT8u/QaLbQqmp8SB7bKk7SfMGDpZqrlCaRiIHtdF3aP1Zs38mDYEDZ6AP/RoD
NG6na2yT2tJUz2BVXvy1ixHKV+/evpnkKxA4PX2dmgCkoBteu+oeHlieoDlf1ydB
KFDTt34JomAYSadnL1yHHvJelq5KqA==
=blY6
-----END PGP SIGNATURE-----

--Sig_/XYLkmfGc2/zB5gjO9VQDMAM--
