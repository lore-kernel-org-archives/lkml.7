Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7758C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A42087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ru1MUqoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGJVge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:36:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJVge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:36:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kXZ65JdPz9sNF;
        Thu, 11 Jul 2019 07:36:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562794592;
        bh=OaAnz/RVw+I/YJctNPLpUhEMbGQ9pTYYQ+kZS1gDLAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ru1MUqoyYdVSO3pKwnbcfnubc9YOgxQdJKzY/WRS0h58RnVjfA+MidcfeDkXgKFbf
         obU/ZLvwbyY1/CsriaEAM8AYr16P4yL4e5Pv9Iq0z1jNsVvGrInNZNytz4pAIAMVHz
         Z014xK5wkMBA0nVf/8nUn0O9arF5fqn+tiwGtTkgQZYWmTqCjZb/XuVfGA1AJADc/L
         UL+wmc1F5Y/SIy6uLbtnywlqQ9ejyA8Ucv/9jR4smZl3bD4mapQ5nIpv0hVgRqnUsK
         g5koKfpl72goLqKWgbz3kxZetzik/Iwgrx/WTXTfcS7xIcsMeSDzvJnfwlUF0nLNze
         d9TZxr+VEVmMA==
Date:   Thu, 11 Jul 2019 07:36:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc1
Message-ID: <20190711073624.58d7105e@canb.auug.org.au>
In-Reply-To: <3fae69d0-2a7e-107f-e054-d2bdef924704@embeddedor.com>
References: <20190709182010.GA32200@embeddedor>
        <20190710141526.2f905572@canb.auug.org.au>
        <3fae69d0-2a7e-107f-e054-d2bdef924704@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uwX+SwAOiB6AfqG=Iz1.1CU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uwX+SwAOiB6AfqG=Iz1.1CU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Wed, 10 Jul 2019 13:14:10 -0500 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> At some point during this development cycle, we reached the quota of zero
> fall-through warnings, but people continued introducing such warnings. So,
> it seems we are now pretty much ready for enabling -Wimplicit-fallthrough
> globally. Before it turns into a never ending story. :)

Sounds good to me.  My mail was, I guess, just a heads up to Linus that
he will see some new warnings in his test build if he merges your
tree.  Thanks for addressing them.

--=20
Cheers,
Stephen Rothwell

--Sig_/uwX+SwAOiB6AfqG=Iz1.1CU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0mWlgACgkQAVBC80lX
0GwCsgf8CK3xceP0cb2vdoIpYbmhwKLUebd/zkP/zhBdEi85dxxTD7nwRr+beDU+
Za+hhv2HIBr9lXtXXW5rpbVF01EAVEE4x7jm8ur/XM+A61X9BoEl45jqfdtlxe8v
BTz950uJzdCOUP5j0h2vgCgt+EV5A0VdDAAAjwsQccGCq1kQCLsvETvhEgIMqhbo
vkAW5oqGwcW8jojkZ5/3oG47vq7r3mHzznjnylxJ72vRsKU/drZO4XCAZDBUSzlK
NIa6peHZaNo2QCEPyyHBHHP8Iti5fgOdaMRgxZEZVgD2XIJBQRzGZ39jmFI8iiCS
IKzZh92Xg7facwA1FjJHR+FK2c6jpg==
=CijY
-----END PGP SIGNATURE-----

--Sig_/uwX+SwAOiB6AfqG=Iz1.1CU--
