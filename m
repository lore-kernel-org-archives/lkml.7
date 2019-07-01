Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2529C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B91206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MmeeUBje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGAVxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:53:42 -0400
Received: from ozlabs.org ([203.11.71.1]:40139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfGAVxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:53:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d1N16VTKz9sCJ;
        Tue,  2 Jul 2019 07:53:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562018019;
        bh=zb3FI6B9lUVRC7qGc4Qeb71LaxjV6fLHHoxCV4G5SvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MmeeUBjeAW0+3r4JxF3mtJhh5HE5gtV2bIM0B8mPNL7jg1eRrbcLaxN2n/KuCp3Bm
         ogScBWaGrUw03lBbdz4zt5biVKE7oUI+xJjnFqBDCcZxJ/oBsRABX2W/9OdrV1q2qy
         fQwQiotrgUJr7NH3wES3xzTZSCfm7zwyM/07EmbwdXNlJFuLKpQfpiQP7TkbpEeNOL
         XSQE6yHXCWTirdR+hkOl3VNowaz6LaTX42JgQvCTh3NPkAQlHKFLlrvW49rqrYr23D
         f1GtsrOb/NuQEmb2tEBfSn2760PZZed+IMiZhRom7Se+/TV7oECCwg3J0BNiniOcYR
         Gc3LoHsX302gw==
Date:   Tue, 2 Jul 2019 07:53:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190702075336.65c38f86@canb.auug.org.au>
In-Reply-To: <20190701183940.GA67767@archlinux-epyc>
References: <20190701190940.7f23ac15@canb.auug.org.au>
        <20190701183940.GA67767@archlinux-epyc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/45gcK0K5nz/Y.CMkG2vV7fs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/45gcK0K5nz/Y.CMkG2vV7fs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 1 Jul 2019 11:39:40 -0700 Nathan Chancellor <natechancellor@gmail.c=
om> wrote:
>=20
> The attached patch is needed in addition to this to avoid a build error
> about incompatible pointer types (in the commit message).

Thanks, I will add it to my merge resolution today.

--=20
Cheers,
Stephen Rothwell

--Sig_/45gcK0K5nz/Y.CMkG2vV7fs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0agOAACgkQAVBC80lX
0Gww3Af9FA+nds9Tai6eb3VQux1btT8YOEG7eadoT0PnYJVIddGcnpHiULZOpn8o
7BN+oGyIVcIWAY9pKJLqGnrZxYSKC87zXcgnaEGM5AVFNioldedhKS0L8LnR5G+L
2HXbHfXRTrKgcm9CtC8wIPtogZvC2AGiM42ennCbgjkHx+/bE8bwtwu2eSnI8KKo
ZvUxU3pK5s2Gk0tc5JfoIIaB7Ge+WX/KT16vLhW0670qvIap41w8hf6/IPE2sGjq
KIMAL/7saV+LBOitwrRM2PO2YwswZv+xGoUFIGj4v04fBP3j6Vz4Suc7QadPVLtP
kyEu3lNaM2kJMaGrJhheRU4L8eMkTQ==
=7pbL
-----END PGP SIGNATURE-----

--Sig_/45gcK0K5nz/Y.CMkG2vV7fs--
