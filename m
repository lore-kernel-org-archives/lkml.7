Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D56C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539720820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iDOVokDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfHLFhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:37:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfHLFhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:37:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 466PkL2HbHz9sML;
        Mon, 12 Aug 2019 15:37:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565588250;
        bh=56nDGULStuFYy08/Qv3AeFa1sDuUWtlfW/0UiSMMy8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iDOVokDeNo0AH4e9iH8xqe/pW7fMaLnvrqZUzP7Z/hKIAwBDDejVez5iZhGwdQpxC
         PBJ0jwbtmmWUckrToyCNrmMLN8f/7/7OY+co6d+Ytjb2WFZBbKg3UVJel+izPE7Spm
         VtpkEHFrlilCP/ZvH2WnRS7Ivtg3D+cXJQfzrTogYNSnOGM0YKOI2eB2CRjBFD8+DD
         GuydUwiXyxLh8rPzvXCNLICwSuQ2J4KqHTxgiIaK2NqzyhAVDJvkuwHFQ7fuHS3o4W
         c+GEbib0cpiPBPoqyr+T3yPpz3AusclfgDJoKLXKFl6KR2b6WrKQIhl27utWqu/Sjy
         deOkAjjd1mzQA==
Date:   Mon, 12 Aug 2019 15:37:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add SPDX kernel tree to linux-next
Message-ID: <20190812153729.104d4451@canb.auug.org.au>
In-Reply-To: <20190812045731.GA5834@kroah.com>
References: <20190810115533.GA6302@kroah.com>
        <20190812072659.606b2107@canb.auug.org.au>
        <20190812045731.GA5834@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ommFjSvsNb6tQoHDzqUgSg4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ommFjSvsNb6tQoHDzqUgSg4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 12 Aug 2019 06:57:31 +0200 Greg KH <gregkh@linuxfoundation.org> wro=
te:
>
> On Mon, Aug 12, 2019 at 07:26:59AM +1000, Stephen Rothwell wrote:
> > Added from today.  One question: is this meant to be a -next tree or a
> > -fixes tree? =20
>=20
> A "-fixes" tree, it should be sent to Linus for the latest release.

OK, I will move it up among the other -fixes trees from tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/ommFjSvsNb6tQoHDzqUgSg4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Q+xkACgkQAVBC80lX
0Gyxtwf+OAsBnc6Y5oR6vFj8oy18hPes+Qg5erpdRM1Ww4hqrX+EOU9A1srq+pvf
67RtvfON6lZ1HydJcAvsItZtEb9IchuUw3Lykz6wiG5AAASglHMzIsYVuITpxSDs
SPVWG7GZnNly8BwzomB4nW1Yvb3KSZWI3VCTGJ9LX/JkdIGLj1iddfEekyxxXz8M
1dytbdoknz//gXvjPbr9dI/4lM5Jr8p1ttnqeOOmpDIQOn5c+S+erA0XHPV3/P8M
Ej7EmAP57tlEoG9l+XZD/PA78W3Cp3LYBMFPt/dH1ljYmIA72zG9Z/XH9ndNxl3c
+3BUZE8Ofix7FZo+EMXvUYzrNPM+cw==
=fh3x
-----END PGP SIGNATURE-----

--Sig_/ommFjSvsNb6tQoHDzqUgSg4--
