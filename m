Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72B21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KwRqgmL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfEUGSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:18:54 -0400
Received: from ozlabs.org ([203.11.71.1]:59621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfEUGSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:18:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457QZM4WLCz9s1c;
        Tue, 21 May 2019 16:18:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558419531;
        bh=SuBwJKDTGP7KYtBjVkNbXLyRMgBwO02+o7PQrSVQYg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KwRqgmL7WS8FBV1q/vQLp0uA51cdrtFglwxqCAW0lihEoluD8qKRVmzmrROBP+UCq
         eyPz60XZBUTPTKHzAYA/oL3tL5qhtJdFjSRUHtFwioHE7qg5nz0jPNhcgXlmVlknb7
         fIiJUwvIPeAyOfl1GCAh9r+INQspc+o2umqoG4ylMr2whXP0xFzokNBa2Oz2qYFxHS
         38B9q9831PyKw9CZhN+UEsAO/nnnDfBCvZU1VXtWNScFw2DK5S26J5tjdPH/2j71eS
         Uj/oAzGwqVdd9eTg1Gmk9TNOMzyL3z0KhDE53Ee6xyWqoKXVR3toW9LpCFtsFRh3eZ
         who9iIWZkngDQ==
Date:   Tue, 21 May 2019 16:18:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for May 21
Message-ID: <20190521161851.49dbcf95@canb.auug.org.au>
In-Reply-To: <CAK7LNARngiQTT2-Y0pFFbENiqAHsy0_6AvWsMRhL9Fqwo=gb-A@mail.gmail.com>
References: <20190521151402.19f22667@canb.auug.org.au>
        <CAK7LNARngiQTT2-Y0pFFbENiqAHsy0_6AvWsMRhL9Fqwo=gb-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hg6h6SYoJ4msJF0GufiSt7s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hg6h6SYoJ4msJF0GufiSt7s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Tue, 21 May 2019 14:48:21 +0900 Masahiro Yamada <yamada.masahiro@socione=
xt.com> wrote:
>
> FYI.
> Commit 15e57a12d4df3c662f6cceaec6d1efa98a3d70f8
> is equivalent to commit ecebc5ce59a003163eb608ace38a01d7ffeb0a95
> which is already in the mainline.
>=20
> The former should be dropped, shouldn't it?

I have dropped it.  I assume andrew will take it out of his patch queue in =
due course.

Andrew, this is:

  15e57a12d4df ("kdb: det rid of broken attempt to print CCVERSION in kdb s=
ummary")

I dropped most (all?) of the rest that you have sent to Linus, but this
hit Linus' tree via another tree.

BTW, Masahiro, please trim your quoting to just the relevant bits,
--=20
Cheers,
Stephen Rothwell

--Sig_/Hg6h6SYoJ4msJF0GufiSt7s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjmEsACgkQAVBC80lX
0GxBjAf+Lfpbc1nCiMviu5YVgp/1C8ZUE1lBN4B1Pv6eDB6RUy7EoKd09Owr9/a8
jF0hEcwGtB8zx2lUIvxfwFnZAJomRD4Yif1TNHI5yyuf1hH45ddjI+4ZkmTIBmN/
vkJHDEq4sYgUxcy8RSVWhYufYC4DRAI/kXnjbqOkc7T1gzLDzOiswsMyw047YkPi
QJgoRQg4rDFLZCGJjO/3MqIWIx3y2lsZS0Tm+gxHRBqL1YTpR8AviunwXkhwmJAJ
QhBshQssvkRdF+YyxJMfHG2wZxHbT2FJOYGvk6VVRLPrOPlFfwRB5Iy3N5BQ1W6K
JWLADeQK2USVxFrG2L0XSkrjW6rPyA==
=kCQP
-----END PGP SIGNATURE-----

--Sig_/Hg6h6SYoJ4msJF0GufiSt7s--
