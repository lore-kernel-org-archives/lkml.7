Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79213C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E232086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDALl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:41:26 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:22514 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:41:26 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 419814B320;
        Mon,  1 Apr 2019 13:41:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id IOGL-zbc8q-w; Mon,  1 Apr 2019 13:41:15 +0200 (CEST)
Date:   Mon, 1 Apr 2019 22:40:59 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190401114059.7gdsvcqyoz2o5bbz@yavin>
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="25pmwozcsd4oz3nu"
Content-Disposition: inline
In-Reply-To: <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25pmwozcsd4oz3nu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-03-31, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Mar 31, 2019, at 3:17 PM, Linus Torvalds <torvalds@linux-foundation.=
org> wrote:
> >> On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner.i=
o> wrote:
> >>=20
> >> I don't think that we want or can make them equivalent since that would
> >> mean we depend on procfs.
> >=20
> > Sure we can.
> >=20
> > If /proc is enabled, then you always do that dance YOU ALREADY WROTE
> > THE CODE FOR to do the stupid ioctl.
> >=20
> > And if /procfs isn't enabled, then you don't do that.
> >=20
> > Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
> > the same damn thing.
> >=20
> > And guess what? If /proc isn't enabled, then obviously pidfd_open()
> > gives you the /proc-less thing, but at least there is no crazy "two
> > different file descriptors for the same thing" situation, because then
> > the /proc one doesn't exist.
> >=20
>=20
> I wish we could do this, and, in a clean design, it would be a
> no-brainer.  But /proc has too much baggage.  Just to mention two such
> things, there=E2=80=99s =E2=80=9Cnet=E2=80=9D and =E2=80=9C../sys=E2=80=
=9D.  This crud is why we have all
> kinds of crazy rules that prevent programs in sandboxes from making a
> new mounts and mounting /proc in it.  If we make it possible to clone
> a new process and this access /proc without having /proc mounted,
> we=E2=80=99ll open up a big can of worms.
>=20
> Maybe we could have a sanitized view of /proc and make a pidfd be a
> directory fd pointing at that.

Eric pitched a procfs2 which would *just* be the PIDs some time ago (in
an attempt to make it possible one day to mount /proc inside a container
without adding a bunch of masked paths), though it was just an idea and
I don't know if he ever had a patch for it.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--25pmwozcsd4oz3nu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlyh+MsACgkQSnvnv3De
m594TxAAjp/c/+ioZ4kkBDXBVo5DcRQPv6/qMJoXgrrw8oDsyu9ckVAVZSkaG4FB
LM7XvaBZ+g2QINvBt8SvFtIQ/u7d6teG8U6JDGMX7XexGBA+tF9LDWVNQbLm6JSl
b4erFNO8TkU2NTse5GZwXtikwSTb73a2Wh64Gm3UecbCVcSqlfiyTcl/VaJi6qEQ
sptUXDyhEuVdsj0hYCoDpiL+4p9irTvyv3l0iTuZAX3I2zPFmS4eV1EeFTf35/Cp
IN1LBORiP/dpSajfa9qT5APY8DRbBsYwdrlFqPjRRl6vDJGmJJFb1YzQb0J9TfYu
XQTiMwUyY1ulYvhpQ30pXLsIeWeD5WJOG0hhT1F3mAgspSbYfeL3BFAbLGP4lnpO
5ASt6Y/0/Ge5HDLN9/NORVBQE6cA+h/xtBHu7W3jmXUHnbbEBfaasMcPNlu/E6Ca
DBwx+1qIaI+EHsbFTr3/ojz6nVE58NQP3SLHKDxrdCgx5cgi1ycTJHvZ5gY2Ol//
se8XaGf/wV63K5DY7lEGl1oZpLbV73cGVuQ7yx95fcSCwi7lgjuhBpKmmDD3EnPX
meOoswqmGii5UlXl7accFAYXh0Myonu4cU63yittocdITmBAricXmMwE1dXRlS61
kx/S7b9UdsZ9glW0jpfvTkShdRsktQ75YWYamCo3FIw4J0Tu1Wo=
=7TA4
-----END PGP SIGNATURE-----

--25pmwozcsd4oz3nu--
