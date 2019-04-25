Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01A6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB86206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfDYTqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:46:09 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:28184 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDYTqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:46:09 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 674304CF59;
        Thu, 25 Apr 2019 21:46:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 3e0jGezFJOCG; Thu, 25 Apr 2019 21:45:43 +0200 (CEST)
Date:   Fri, 26 Apr 2019 05:45:25 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path
 resolution
Message-ID: <20190425194525.5d66uzfqfxmorx2n@yavin>
References: <20190320143717.2523-1-cyphar@cyphar.com>
 <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
 <20190325130429.dbrgjxnvq3w5cpb3@yavin>
 <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
 <20190424153806.64qkkmkudzodxnz2@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgp24gaplbeperzh"
Content-Disposition: inline
In-Reply-To: <20190424153806.64qkkmkudzodxnz2@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mgp24gaplbeperzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-04-25, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-04-23, Kees Cook <keescook@chromium.org> wrote:
> > This series provides solutions to so many different race and confusion
> > issues, I'd really like to see it land. What's the next step here? Is
> > this planned to go directly to Linus for v5.2, or is it going to live
> > in -mm for a while? I'd really like to see this moving forward.
>=20
> Given some of the security requirements of this interface, I think
> getting it to live in -mm wouldn't be a bad idea so folks can shake the
> bugs out before it's depended on by container runtimes.

Scratch my mention of -mm, it should be in Al's tree since it touches
quite a few of the namei seqlocks. My point was that it should live in
someone's tree for a little bit before it goes into a release.

I will put together a PoC of a resolveat(2) variation of this series and
re-send it out with both versions.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--mgp24gaplbeperzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzCDlUACgkQSnvnv3De
m5+dTBAAkJaalB1ZAlNLaIBqNJeW7q7mu/h9lSLPEiXvdvYaaX7vsxdRP+qw733+
70e5zLtSp63rWZ+C1qC+X29jPP6sqxoYIbSrufbpBGXFl0DqWh2bdibbyJ0OfMgl
uWQRnlzgKF9OsdXWHUOe6vyaL5OrBYM27mgCZ0DRzOrULUbTcYn2C3iYFI6sIwwq
9i58pEVwTosNB48fvvmP97ANjZrdpIfovNCELQJL//uQTGTRIYc31lRn5bxJw31R
kZAO9hv2khQZnBQmiB/AntAnYzAjOeaT1I2EgbO4eDXmb1VOzBlO7VzlkPDy34Wj
EiyVktScI1Fr/ckbyQ2f0HJVXwYIE6Qh7kodot8ZY3BcYQUpptW6BTffvU7qqra8
LUScCOdgyOf4A3iTJM3/HdnWkTCOnbbwMHQf97sQlJN3+SnBelrz++bQ8d4Pnlci
IXDQkTvaJPzmehd8iBEfqdoSb5H0ipxmIr1OZgdvBskQ1X3zRMhemSKfGU2umC7p
Dt5qTpiuwmMdqN/mzb6rd/OQCiww3vHaPWn0cY9ppPQyaqn5M7vVd38B0sJ2RfRm
n7ojrJ6Hrl3Tl30N0LXlS8EXTEF2gOFznn/beWig+SIoF1WRBX+YdD+N03h940C2
/D7ioE/0fOukT/9ZM4Aco28Y4b2GLI36jlmEFGSDRzzwuEtb4UU=
=niPy
-----END PGP SIGNATURE-----

--mgp24gaplbeperzh--
