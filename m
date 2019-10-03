Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C6BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AE420862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfJCReI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:34:08 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35092 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732907AbfJCReF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:34:05 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0E95AA1BF4;
        Thu,  3 Oct 2019 19:34:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id ZVLOBka5CkYJ; Thu,  3 Oct 2019 19:34:00 +0200 (CEST)
Date:   Fri, 4 Oct 2019 03:33:52 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] usercopy: Add parentheses around assignment in
 test_copy_struct_from_user
Message-ID: <20191003173352.ai4wbllwo6lrxjju@yavin.dot.cyphar.com>
References: <20191003171121.2723619-1-natechancellor@gmail.com>
 <CAHrFyr4GFJHQLHOi_OuDVkhuKxfnf_VkTWk6MJ2Mn1EtWhpqjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mq3doqufbzkhsyhl"
Content-Disposition: inline
In-Reply-To: <CAHrFyr4GFJHQLHOi_OuDVkhuKxfnf_VkTWk6MJ2Mn1EtWhpqjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mq3doqufbzkhsyhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-03, Christian Brauner <christian@brauner.io> wrote:
> On Thu, Oct 3, 2019, 19:11 Nathan Chancellor <natechancellor@gmail.com>
> wrote:
>=20
> > Clang warns:
> >
> > lib/test_user_copy.c:96:10: warning: using the result of an assignment
> > as a condition without parentheses [-Wparentheses]
> >         if (ret |=3D test(umem_src =3D=3D NULL, "kmalloc failed"))
> >             ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > lib/test_user_copy.c:96:10: note: place parentheses around the
> > assignment to silence this warning
> >         if (ret |=3D test(umem_src =3D=3D NULL, "kmalloc failed"))
> >                 ^
> >             (                                              )
> > lib/test_user_copy.c:96:10: note: use '!=3D' to turn this compound
> > assignment into an inequality comparison
> >         if (ret |=3D test(umem_src =3D=3D NULL, "kmalloc failed"))
> >                 ^~
> >                 !=3D
> >
> > Add the parentheses as it suggests because this is intentional.
> >
> > Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/731
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
>=20
> I'll take this. Aleksa, can I get your ack too, please?
>=20
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Aleksa Sarai <cyphar@cyphar.com>


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--mq3doqufbzkhsyhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZYw/QAKCRCdlLljIbnQ
ErZYAP4heG3krz9cEVZdwR0992zolXZYYA3cb+gwBXtyntW4tQEA7oYTckHSxzrw
2x9+2UkmgGKl+HPHYP3tiwp6I40UOQg=
=IFPY
-----END PGP SIGNATURE-----

--mq3doqufbzkhsyhl--
