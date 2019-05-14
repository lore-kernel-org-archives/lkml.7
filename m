Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75095C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0DD20645
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QLIGT2dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfENBDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 21:03:38 -0400
Received: from ozlabs.org ([203.11.71.1]:51009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfENBDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 21:03:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452zvq2pN8z9s5c;
        Tue, 14 May 2019 11:03:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557795815;
        bh=Urw5YQ2Mp8lY6ri+4KnFDoKr3Yr5Tot3sZjD+tdIaYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QLIGT2dJ1bV+qIq7a01t0jR+w96mIM28BFzR0cgngJv8D9AmkwWIrF7VXlEZRJw+N
         5uyYEhi5hBXXx0yZIISYr7sP/UZdOmoMxfS7csrZQhQjiagEb50nonl5eSefhB5oTZ
         /sBETRbADVerjvmohhnlkJEzIb7q5n0nP88FUo2N2QRzaVk/f36Aj9wYL0XYiFUl5B
         NDMyFfY1fH6JnQd32WngVMeRmAnExEtQzZpvFSwxbE2zXz20btQr2K+eecSJjc0ltr
         PBwOjJNbrZ6WoIe1b3CergsQ+6Jza91BXfL+9y53DkwPScLwvxfJ50UncnAMQzqs7o
         tr7itTwm2FLCg==
Date:   Tue, 14 May 2019 11:03:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
Message-ID: <20190514110334.424cf0be@canb.auug.org.au>
In-Reply-To: <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
References: <20190514100910.6996d2f5@canb.auug.org.au>
        <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5BQ7GiXSJF5T3Uj/S7ohPa1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5BQ7GiXSJF5T3Uj/S7ohPa1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

Also, this:

On Tue, 14 May 2019 09:40:53 +0900 Masahiro Yamada <yamada.masahiro@socione=
xt.com> wrote:
>
> > Mind you, I have no itdea why this file was begin rebuilt, the merge
> > only touched these files:
> >
> > fs/ecryptfs/crypto.c
> > fs/ecryptfs/keystore.c

Its a bit annoying that the module was even being looked at given
nothing it files depend upon had been modified.
--=20
Cheers,
Stephen Rothwell

--Sig_/5BQ7GiXSJF5T3Uj/S7ohPa1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzaE+YACgkQAVBC80lX
0GzpoQf/caGdA8WFtsZ9ghTTbdiRa0Myjrpol829RHpwJ4CBGPNn1Bq1Dag9/3Jq
RmgTEoRbiZ2Gxnfi8UDnPewSiK8mXHUH1AJxBqdY7Dll7JvaiLqpyaKL/3zoH57e
qtizru4sfkk1ZfFZuwJ8GnZMfi+UEGv4+973iJ9g9cstP4VADqq8rHd3VrKf+rKc
lSGZmLsIQBKLqm7SMKh1O+jXDdWxA1Zw1yrGwk1Ze2GvchTiCIuY1XK+Kd5+201J
knvUWVH5mLoyI8u3dGn/1NHDDSdKUREy8nTbNwq7tNcZpgOMMo/9QIjCZc/T3ecy
fYYVg0KYzWlVSGmiojcgsMOIMYivJg==
=/ylh
-----END PGP SIGNATURE-----

--Sig_/5BQ7GiXSJF5T3Uj/S7ohPa1--
