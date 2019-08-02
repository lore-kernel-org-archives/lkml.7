Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCCC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40631206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="lHdDpSlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392304AbfHBLFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:05:14 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:51437 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729311AbfHBLFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5K7Qo9L17o0/PSIv3rUFl7w3E/K9IJf30Sp9E3V6WDo=; b=lHdDpSlDb6djzTf7Ly+7MUNoZm
        +EAzQTeFpVoGjA+kOYyFu9GGQ2GAnTlqv/E60CENbLIgq0EgURCeBroJxzuXxpS9tU3DTeABXVNwc
        7kwIXrMIG/4jWmPxENMJPHrxcRKKPHUxs/t0La3Oqf382PC7V8nd8GAlwB6GFNXOO7MDBJYIgfLIZ
        qoLThz7YeBon2GAeJukCW9+UTXohdUdI/leBcL605Jv7MaUt4LiEUvEhsW4ixMYVhZ3AJND2tgNIA
        0uzaSEI8wnIYF5V920QMoTeKkrV3Hvr4yAN26hfhNPIOLBhX2IGLfG4WT3/aBGs0ZG7MIUMXcx8rz
        wQQhql4w==;
Received: from [37.204.119.143] (port=45400 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1htVMj-000NcY-SW; Fri, 02 Aug 2019 14:04:54 +0300
Date:   Fri, 2 Aug 2019 14:04:52 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Message-ID: <20190802110450.GC20574@cello>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru>
 <20190730161940.GA15798@kroah.com>
 <20190731222359.GA20574@cello>
 <20190801092020.GB19329@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20190801092020.GB19329@kroah.com>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the delay, yesterday was rough.

On Thu, Aug 01, 2019 at 11:20:20AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 01, 2019 at 01:23:59AM +0300, Arseny Maslennikov wrote:
> > On Tue, Jul 30, 2019 at 06:19:40PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 25, 2019 at 07:11:53PM +0300, Arseny Maslennikov wrote:
> > > > If the three termios local flags isig, icanon, iexten are enabled
> > > > and the local flag nokerninfo is disabled for a tty governed
> > > > by the n_tty line discipline, then on receiving the keyboard status
> > > > character n_tty will generate a status message and write it out to
> > > > the tty before sending SIGINFO to the tty's foreground process grou=
p.
> > > >=20
> > > > <...>
> > >=20
> > > Why is this really all needed as we have the SysRq handlers that repo=
rt
> > > all of this today?
> >=20
> > Different use-cases have different needs; SysRq is targeted at a differ=
ent
> > audience; see below.
> >=20
> > > > The "most interesting" process is chosen as follows:
> > > >  - runnables over everything
> > > >  - uninterruptibles over everything else
> > > >  - among 2 runnables pick the biggest utime + stime
> > > >  - any unresolved ties are decided in favour of greatest PID.
> > >=20
> > > This does not feel like something that the tty core code should be do=
ing
> > > at all.
> >=20
> > Yes, this selection part is quite clumsy. In defense of it, one could
> > argue that we already have the whole n_tty implemented in kernel-space.
>=20
> One could argue that :)
>=20
> > One way we could get rid of this is to display a summarized statistic
> > for the whole pgrp: pgid, oldest real time, cumulative utime and stime,
> > cumulative memory usage. Would this be more acceptable? Are there any
> > other ideas?
>=20
> Given that I really think you are just making something up here that no
> one really is needing for their workflow, but would just be "cool to
> have", I say do whatever you think is right.
>=20
> And there is nothing wrong with "cool to have" things, I'm not trying to
> dismiss this, it's just that all new features come with the "you must
> support this until the end of time" requirement that we must balance it
> with.
>=20

To be fair, the kerninfo line itself is intended for the user's eyes; it
can't even be programmatically read by anyone in a Linux system except
pty masters, so I don't feel it has to be particularly stable, since
changing its contents won't break anyone.
So IMO we could still tweak something about it after we merge this.
Of course this cannot be said about the signal part of the patch series,
which interfaces with processes and is a proper part of the outward
kernel API, thus subject to the kernel's policy.

> > > > While the kerninfo line is not very useful for debugging the kernel
> > > > itself, since we have much more powerful debugging tools, it still =
gives
> > > > the user behind the terminal some meaningful feedback to a VSTATUS =
that
> > > > works even if no processes respond.
> > >=20
> > > That's what SysRq is for.  If there's a specific set of values that we
> > > don't currently report in that facility, why not just add the
> > > information there?  It's much simpler and "safer" that way.
> >=20
> > SysRq is intended for the person either administrating the system to be=
 used in
> > emergency (e.g. f for the oom kill, the famous s-u-b combo also comes to
> > mind) or debugging the kernel, and it indeed does a much better job for
> > those purposes.  In both use-cases mentioned the person has access to
> > the system console, where the sysrq button handlers produce all their
> > output, if any, and to either a physical keyboard / serial console or to
> > /proc/sysrq-trigger, whose mode is 0200 (writable by uid 0 only).
> >=20
> > The use-case for this is different: the ^T-line as proposed by this
> > patch is for the user that interacts with a system through a terminal, =
who
> > wants to be informed not about the whole system (sort of what SysRq-t
> > tells you), but about what they run on that particular tty.
>=20
> Ok, fair enough, although if you just add a new sysrq option for "what
> is running on this tty", would that help resolve this?
>=20

I see at least two problems here:
1) sysrq is not accessible by unprivileged users (and here goes the
   whole idea of sysrq being designed for different purposes, etc.)
2) Even if we fix it and somehow allow unpriv users to do the equivalent
   of `echo $letter > /proc/sysrq-trigger' for a particular letter,
   there still are UI issues.  (yes, UI issues are better dealt with
   outside the kernel, but that's not the point) It still has to dump
   info to the particular tty (let's remember, console is unaccessible
   and shared to the whole system), that is a novelty for sysrq. There
   still is the open question about how to make a VSTATUS press trigger
   that sysrq button in addition to signalling fg pgrp without shoving
   this bit into every other userspace program.

To sum up, this looks worse to me than integrating with n_tty.

In general, the main appeal of the feature is in it being activated by a
single keypress handled by the line discipline, from any tty.

> > This is much less about "why does my system/kernel seem to hang?" or
> > exposing low-level internals (registers, hrtimers, locks, ...), and more
> > about "is my SSH terminal session unresponsive?" and "I ran a command,
> > it doesn't finish, how's it doing?".
> > e.g. A user might want to know if their SSH connection is alive without
> > interrupting anything, while having no access both to SysRq and console,
> > and no one in fg pgrp actually handles SIGINFO.
>=20
> If you have access to a tty, you should have access to sysrq, right?
>=20

No.
SSH gives you access to a pty, which doesn't seem to handle BREAK; the
BREAK SysRq activation method does not work there.
As Pavel correctly noted, if the user is unprivileged, they can't use
/proc/sysrq-trigger as well.

> > SysRq is system-wide, whereas this is per-terminal and only cares about
> > one tty which the status char is pressed at and its foreground pgrp
> > (most likely it's the foreground shell job).
> >=20
> > I hope this is clear enough.
>=20
> It is, yes.  My big objection is the crazy code I point out above, as
> well as the "create a totally new interface when we might be able to use
> an existing one" that you need to convince me is really required :)
>=20

The signal part (patches [1-4]/7) is not really new, since we've had
Unix-like signals for ages.
(You've probably meant the [5-7]/7, but there's no such thing as a too
detailed explanation).
The compelling reasons for a new signal are:
- it provides asynchronous process notification, as opposed to e. g. a
  POLLIN on a file descriptor, which is not noticed by the recipient
  until they poll(2);
- to make use of the mechanism, an existing app does not have to be
  rewritten in a certain way =E2=80=94 a signal handler just gets called, i=
f the
  signal is not blocked =E2=80=94 so it's easy to use from applications.
- it aligns well with the current practice of the line discipline
  relaying user requests to processes via signals.

As for the line: before I started writing the patch I thought a lot
about how we could move the status line logic away from n_tty and, when
^T is pressed, have it notify someone in userspace, who would look up
all the pieces in /proc and write() the line to the tty. Obviously this
approach should be much more flexible and easier to maintain from the
kernel perspective.  One candidate for this could actually be the tty's
session leader (most often that's the interactive shell).

To be convenient, the feature needs to have at least the following
qualities:
- the status line has to come first, since it's the only invariant; this
  way it's easy to visually find if needed and just as easy to ignore
  otherwise;
- the reaction to VSTATUS has to be as responsive as it can reasonably
  be and as the system load allows. (btw, SysRq does well in this
  regard, but the drawbacks outweigh this, see above)
The only way we can secure the first point is to signal a process, wait
for it to get scheduled, wait a little more for it to compose and send
output, and only then to signal the pgrp and be done. This is
potentially slow and might lock up the tty's input receive queue for
sizable amounts of time. What if the session leader opts-in to do this
and then ignores this kind of request / never responds altogether? This
gets messy fast. So we can't guarantee the second point.
If we focus on responsiveness, we can't wait for processes at all, so we
ping them and be done with it. This means no output ordering guarantees,
it all gets interleaved and, consequently, less readable and less useful
overall.
Further tweaking the protocol gives the risk of making it too complicated.

So I gave up on the idea and went with this patch, which ticks both boxes
mentioned above. Of course, I'd love to have an ideal solution, and a
pony too. :)

(Or perhaps I'm thinking inside the box and missing a clue and someone
reading this does not. This is a public list, anyway)

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl1EGMsACgkQ9dQjyAYL
01DGFg/9EBepEaQmqLdWaczAJcvHnDDAXSgR3U+hDHJM7RBqroz6At87S1eL15NH
S0xx7d0JD6S5ARfcAGNR7SbkDhF7jpTJDwBm4g+Yzty/awPZ/9NpOSqK7qalzWU2
rLWMwAWjKJwO6GciEQxFjBKgeblSuHijbNVHPMkOwAoMRS+4ywQh4qVHWc0mSesc
w5IffG7sphmDWHc8BJxnQL/CVn0jcApt0ny3z021fwiLFIMBnarcZBtTI9axHfrd
sWLUPup2RcABqRAtTVk+mYhIS8ajpgcjlwJrgQAH54EzKYU3GfnThsbEE4xUyNtc
CSW6eawn9zNHLFmoOevZoYOZZ9Xn924vvXXQYzqxPcsXgmQgIA+xGCaqhMPIZBN/
yRBOY5mszbzlAfUMAsDjEg2sfUUj0H+zpJzlz7a/Ex1ZyfEA0EzK0A38pS6fchc5
ceTI/6Pb6Vg9+roNgH48Yxpq9X101PJFO4qhrv9E1a9vPTx2ERjMGVEL+MS3MVBT
gnMOvVRH9englf/UQlOZDuZjt1Rdo7+gFKYD06zelBcyUfLC+5Lo5fcGI9CQXvOf
u36nF+w8YIY3+T76MheIHluX1kmJvPK2QRpHb1Mz8WMw2wKGtctKBg+CanlWWaOD
Ho1vkyE3a+TDzvLlYH+4q8u/2F+zCNoiR/0ic7AqEfb3bW7ErHs=
=txBO
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
