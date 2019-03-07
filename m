Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211FC20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCGV4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:56:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfCGV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:56:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h20zx-0000Ld-JF; Thu, 07 Mar 2019 21:56:17 +0000
Received: from ben by deadeye with local (Exim 4.92-RC6)
        (envelope-from <ben@decadent.org.uk>)
        id 1h20zx-00006A-EB; Thu, 07 Mar 2019 21:56:17 +0000
Message-ID: <c93a7273c89c649373761f2ba26a6ef05787d08d.camel@decadent.org.uk>
Subject: Re: [PATCH] kbuild: add workaround for Debian make-kpkg
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Manoj Srivastava <manoj.srivastava.1962@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Mar 2019 21:56:05 +0000
In-Reply-To: <CABkpOEUqJWn62VZoTA5UEnbDieiYR9y3diRQhZuOVe6hOoBNhA@mail.gmail.com>
References: <1551888035-13329-1-git-send-email-yamada.masahiro@socionext.com>
         <5760e0a210c7c39b486aa932ccbe7f3f2c210d62.camel@decadent.org.uk>
         <CAK7LNAQFWWzki-MvmhDpAn46XkDAu4_EGCQotbi5qAk5oJrgUQ@mail.gmail.com>
         <788870e550cb3cecafd9db14c081ddb0225edfde.camel@decadent.org.uk>
         <CABkpOEUqJWn62VZoTA5UEnbDieiYR9y3diRQhZuOVe6hOoBNhA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-q9c6TjJS+ntCCGTvch+Y"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q9c6TjJS+ntCCGTvch+Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-03-06 at 22:48 -0800, Manoj Srivastava wrote:
> Hi,
>=20
>   Does this have any users? I can take a stand at making it work, but I a=
m
> unsure of there are enough people interested in make-kpkg anymore to make
> it worthwhile.
>=20
>   There is a man pager that might be of minor interest, but that can be
> taken over by the kernel team if they want
[...]

I assume you're referring to kernel-img.conf.  I would be happy to add
that to linux-base, with some clarification of which settings are
understood by which packages.

I take it that you don't want kernel-package to be included in buster,
so can you open an RC bug to say so?

Ben.

--=20
Ben Hutchings
friends: People who know you well, but like you anyway.



--=-q9c6TjJS+ntCCGTvch+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyBk3UACgkQ57/I7JWG
EQlN6RAAkRzm+OKmLh9eRxcev5TUquwnx7X9Qm9errUM8/cqJHbl9NfSNn7uQbjw
xp2sKQXcYFDrD+yKrc1VSI5kyRQ/mCuwlw3zobwJ/bmVA2M2H/UsAPt9CfIK36if
QVraGdnayOYqM1uHOhfjmixkT/zx30P5bzjRpOQgQYy15BN4JXiOfXWBeaWf/4Pj
Mup+EjSZ0Fa3JFrs5joNFjo0bG/RpSWQ/CQewVQ/cDU9LrVUgOTK+nnXYjkHhb3k
U3NGVDEB4b1j7qR5WIKuF1Ukht0L61rGPOECXATwtHeYBKSLslv1vIOrFnRFqT8D
9v3scJAr1W1yIWSANSdv3QndJIZ8rG2KGRh9IPz5rmlW2VR8+aMS5nPY5yOLA5EN
nL0Iv7Pbc7oWihweD6iiINNjpq9qO4NoowlzqSAEIWj/JmCMqfoLM2RNqXR/bi2V
bComH2YEC0hXnOKnf2tfyuaL/wAlYdr6gGdSI0YMBOjLvU7yjLKYApXPzBIreXbd
Pls8YMRK2aSejsrnHP8Rm+PXj54FfSzD8dliK5AHS7/Uayu9R6oMDBsF+VDKs4bF
yt+AXGa8QKMiQZkeNMrN8iY8786K2VihH00S7/ZZZm+TvM47Qsaga+DVQNrRHxCX
2JAzSW9y0nrylzlhl0PJT8yHJ8XaGwhau0oVTA5geSc60y3netg=
=+6F+
-----END PGP SIGNATURE-----

--=-q9c6TjJS+ntCCGTvch+Y--
