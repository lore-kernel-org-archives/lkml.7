Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E608C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471FE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfDOT7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:59:43 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:43070 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbfDOT7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:59:41 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B6D7DA1059;
        Mon, 15 Apr 2019 21:59:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id HDcyg6PzSmvR; Mon, 15 Apr 2019 21:59:25 +0200 (CEST)
Date:   Tue, 16 Apr 2019 05:59:11 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, oleg@redhat.com, joel@joelfernandes.org,
        dancol@google.com
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
Message-ID: <20190415195911.z7b7miwsj67ha54y@yavin>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brclbup35wtexg3g"
Content-Disposition: inline
In-Reply-To: <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--brclbup35wtexg3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-04-15, Enrico Weigelt, metux IT consult <lkml@metux.net> wrote:
> > This patchset makes it possible to retrieve pid file descriptors at
> > process creation time by introducing the new flag CLONE_PIDFD to the
> > clone() system call as previously discussed.
>=20
> Sorry, for highjacking this thread, but I'm curious on what things to
> consider when introducing new CLONE_* flags.
>=20
> The reason I'm asking is:
>=20
> I'm working on implementing plan9-like fs namespaces, where unprivileged
> processes can change their own namespace at will. For that, certain
> traditional unix'ish things have to be disabled, most notably suid.
> As forbidding suid can be helpful in other scenarios, too, I thought
> about making this its own feature. Doing that switch on clone() seems
> a nice place for that, IMHO.

Just spit-balling -- is no_new_privs not sufficient for this usecase?
Not granting privileges such as setuid during execve(2) is the main
point of that flag.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--brclbup35wtexg3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAly04o8ACgkQSnvnv3De
m5+CNw//RzlU3ndiqW/T6p0030NS9m+xPmKEXXhJtL0OfrAMyZC+LPvYQP36Y39n
F65TblOFVMVuCsel6+ykbkuozhlihWy/24JuP3tnQ44H6kaTH++xDjnSkxie9iHy
dujGieK7T5lK0oEo/Afr3SiX9/0aTQrbrnNn6dZtwDWP6uMVldmGJGtBPMvlP9nS
UYryLbHYoi7LQ6yN5O9cjrl89LC/PWdNpq1I6iv95Zm/HvrCHOxsPYZclc9Ssh9r
jfiyM3tNlwqvKfWwopeQt42qjhCgZl5OKZ2ilr3ScyHFVQndIyqGWGv42Y66gnJk
pytKvX9/VTUX/BqTnx7G8sIovkTYbvYwu76YGr637pT96JDzhvzCLmphu8pS8uGY
1XIo/Vpj5+HK+YOUjpe/h2R1nsooZp+HF9trhV3kLDB7dLIDBxxF563Qvra6Su/t
6mv/nOc0aqKT9ovk20xbiXZjFah1wexgQo4FwFijHpUCySHvRUgZgaBORvmG8P+g
/pF+xsV5n8aizXxrr8JksLl3jNDY+Yejd9tH0nXwC6KS2J176FTVSUN3U/CZV+34
A1sdMutiEbqehRS05yVQDelMOvEogX8/aWsq+QLNFRmW1FKZuMNDXFz4u/x5JL2T
pvPANIX6oGOt8VrbD6Du6xaGCD6DftobShTB1xmeZ1MmX8z6Jjs=
=4433
-----END PGP SIGNATURE-----

--brclbup35wtexg3g--
