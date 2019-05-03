Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C0C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442A9206C1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="haScTnaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfECW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:26:43 -0400
Received: from ozlabs.org ([203.11.71.1]:56713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfECW0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:26:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wmvJ4Cbsz9sCJ;
        Sat,  4 May 2019 08:26:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556922400;
        bh=mvdC9PkuK3vAxC9I/LgUnG5QKbAod+fjoqmyqnpZHG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=haScTnaMIIVCn8nEBD9R0watwu/zI8g0rvePKEfSkJ7FGW20lH4PY1kVXlKuo2V/o
         f4okSgUAebCzegCEFLtOtfSG5Mn7y+4f1zDRN773PBy+kraMQr8stua6s1lZe4m4AT
         JjrVVN+NitvUq6IUM57IfLqNt0WWdoX0gSfHIbgwexY9pX4pNDSm3udcwJMShPcsyO
         /Q1UwIa5CI99B7x/akZNfPRqTFgxGt6LWoEYqjSZEcVqY+Iv35tLdslLlwrl07HHbX
         nviIigWnhDix+K6dlYI/zKdRUgmQBnE8jwHTJQ0p/EFlqwUQmA4V9IF6si5c1wWmW1
         fS5qPm75LJVLQ==
Date:   Sat, 4 May 2019 08:26:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>
Subject: Re: linux-next: manual merge of the vfs tree with the orangefs tree
Message-ID: <20190504082634.6f78a061@canb.auug.org.au>
In-Reply-To: <CAOg9mSSGUiCoeecpdLs-8-TAMkVDubHK5jG87dGseV4gkGRiOQ@mail.gmail.com>
References: <20190503111510.6e866e3b@canb.auug.org.au>
        <CAOg9mSSGUiCoeecpdLs-8-TAMkVDubHK5jG87dGseV4gkGRiOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2IlGFZ=ogMBV774+e4=+kt8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2IlGFZ=ogMBV774+e4=+kt8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Fri, 3 May 2019 13:34:49 -0400 Mike Marshall <hubcap@omnibond.com> wrote:
>
> I noticed the conflict too when I added Al's patch series to the orangefs
> tree we have on next. I understood Linus to say he'd fix the conflict the
> way you did during the merge window. I guess that means you'll have to
> keep fixing it on next until then... I hate causing trouble, let me know =
if
> there's something different I should do to help...

Its all good.  I use "git rerere" which remembers the conflicts I have
fixed once and fixes them automatically the next time I do the same
merge.

--=20
Cheers,
Stephen Rothwell

--Sig_/2IlGFZ=ogMBV774+e4=+kt8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzMwBoACgkQAVBC80lX
0GztzAgAnZiH9dzA+04iUsXDwzAq2LEaP+Ssd4oLtGy7w2IiizC4jrg4/1F50ZxB
52hW5YkohsJfHj0/aSLlifXztvTnT4yIHcNDxcIFNkV3ISw2eVcfolJQL88I8Wcf
TEPf6jgUbcipodTfVK7kKVPweyMf0xCDxtZerivvs7BOzDgXlVVM774qmJAGeuJR
zb53TvWHtvCaiHeCdRZ4go5fhJhdzu/Gel42o4/gqHCiGzKzabVK7JpMxGFmUEV3
aAauzCc1QxZKe6V89AAr9YJYicKvHYc6KtKz7od9cym2aKIqTEMSwmrujsamNTVh
oulnM6F/2593DFbTEIgpHs8Yo5utpA==
=wZCW
-----END PGP SIGNATURE-----

--Sig_/2IlGFZ=ogMBV774+e4=+kt8--
