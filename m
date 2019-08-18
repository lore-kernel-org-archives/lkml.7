Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E5C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6D2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHRJPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:15:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60565 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:15:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1164281267; Sun, 18 Aug 2019 11:15:25 +0200 (CEST)
Date:   Sun, 18 Aug 2019 11:15:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
        stable@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: stable markup was Re: [PATCH 1/1] Fix: trace sched switch start/stop
 racy updates
Message-ID: <20190818091537.GA24553@amd>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <20190816164912.078b6e01@oasis.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190816164912.078b6e01@oasis.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The most I'll take is two separate patches. One is going to be marked
> for stable as it fixes a real bug. The other is more for cosmetic or
> theoretical issues, that I will state clearly "NOT FOR STABLE", such
> that the autosel doesn't take them.

Do we have standartized way to mark "this is not for stable"? Because
I often think "I'd really hate to see this in stable"...

On a related note, it would be nice to have standartized way to
marking corresponding upstream commit. (Currently three methods are in
use).

Upstream: XXXX

in the signoff area would be nice, clearly marking who touched the
patch before mainline and who after.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1ZFzkACgkQMOfwapXb+vItfwCgt1zUgVSj+X6XOY0Y9fq7MikY
qTQAnRM6J0LL/fWCrL1lMCbS6lpdO+6e
=nF0b
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
