Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E75C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC820850
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="siKmD6SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDOBJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:09:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfDOBJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 21:09:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44j9PX5RpNz9s00;
        Mon, 15 Apr 2019 11:09:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555290546;
        bh=r1Ojfb8noqOp/FIi7NUVlBT9YAcmaNpn72OzxEGBaDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=siKmD6SYTKMjfllX491CdQqMuRvavPAPWiXUuEU4uPjvSORG4u3grOK/0LvXgkNrr
         D9j24ygyoOn3yUU9Uvvf7g9cRErjSnAlUkFcoHjSfx9ov8tCzGkw1hCJURqYWx8VEH
         2XXclKscA7L/Rm/K5mlNNH68bdoUYBvvFNIKUdPor4paZDxsSsiVcnahBR/FXwWYL5
         ZmARGibZfHDG1U3wGqqR1uOm7hMMWUDkQOKHrzSmVryRySymv71Ohy3qFNpb+AeN8d
         OOiJNHSpT2qeawz6nLgu91iaB+FaF+Iw/1wIicxDgTXqzbIaAj/MlKeP7cKkBFqRhW
         KC34Fq7j8PASA==
Date:   Mon, 15 Apr 2019 11:09:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Networking <netdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the jc_docs
 tree
Message-ID: <20190415110902.41c3c201@canb.auug.org.au>
In-Reply-To: <20190412110518.46e329af@canb.auug.org.au>
References: <20190412110518.46e329af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/On+q+vVQzapSkCpAR7cPwSn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/On+q+vVQzapSkCpAR7cPwSn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 12 Apr 2019 11:05:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>=20
>   .mailmap
>=20
> between commit:
>=20
>   9b628c6ab437 ("mailmap: update my obsolete email address")
>=20
> from the jc_docs tree and commit:
>=20
>   fa0dcb3fe2ca ("mailmap: add entry for email addresses")
>=20
> from the bpf-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc .mailmap
> index 151501c73503,e7984bb6b4b0..000000000000
> --- a/.mailmap
> +++ b/.mailmap
> @@@ -16,8 -16,9 +16,11 @@@ Alan Cox <alan@lxorguk.ukuu.org.uk
>   Alan Cox <root@hraefn.swansea.linux.org.uk>
>   Aleksey Gorelov <aleksey_gorelov@phoenix.com>
>   Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic=
@imgtec.com>
>  +Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
>  +Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
> + Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
> + Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
> + Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
>   Al Viro <viro@ftp.linux.org.uk>
>   Al Viro <viro@zenIV.linux.org.uk>
>   Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>

This is now a conflict between the net-next tree and the jc_docs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/On+q+vVQzapSkCpAR7cPwSn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyz2a4ACgkQAVBC80lX
0GyEtwf9G4Kb/zHrH1eBX6xUKmmgAOoaNYDfqlH2JHknJ2h69Vydixnlk+OJeBIx
fr1y9qnbdPH3wX8RSkKRxkVyYfoH6ru9+JSR3Li1WTvm8e7DxHXPvMobwuy13qea
tLMUzXKXz+aqss4cruHmhCSf/6TZ/auEwmzIFVBiPVetn78V3raUrItvr5QQB98A
ruqeFaq9/Pe9TVR59JRrD4JzBpVVmOZv5ng8X3FfiUDfN8E5mHJF8WTD2baTDkWd
XamYTmcFKXP65eXp4HlCx4iOa+Sb+TQr/SithJBsPnNjjIqJfhxgY5i1EkHdwDhD
hgiMWDkSeU9ujun6E9Djv982SAlb8A==
=G3pb
-----END PGP SIGNATURE-----

--Sig_/On+q+vVQzapSkCpAR7cPwSn--
