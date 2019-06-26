Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3B521670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="JdbL0h3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfFZNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:50:07 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:39415 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbfFZNuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q9rA/NfcGBQU65ajNFj9+Mg9uUBNenWP09+IQ0w822s=; b=JdbL0h3Qa5tGTc+cDi9syiZzmv
        8hR5pwh81hv9AMS/ddTzfy+i0cfTRTquL0wz9rKm0AkH/8ibFfFtkMzrtwLyII5kkm6hf4BDc9SwS
        yxZu72hIR4Uqf4p8T9j6W+IcpnYp9+Lqou4LXAFsFbYPKHSox/pcqzxSYQGCsP70qFkfl5E/ezUG8
        TFBhpreLF5okYDNTgTRG8iQ7bfDGT08Px5Dr0J1J4264nBp8xxTjwkigmJTgU2RxCtA16zdVd0uad
        x1p6X1HCE5fT0dF03i4OsAWym19br2LajYz2cMJ8/A1Hjsf3idDPIxD/H71gy5HBWuLWAtIp56rsD
        zX+tFHAQ==;
Received: from [37.204.119.143] (port=58022 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hg8J2-000KTm-6M; Wed, 26 Jun 2019 16:49:48 +0300
Date:   Wed, 26 Jun 2019 16:49:41 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Message-ID: <20190626134941.GA3668@cello>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-5-ar@cs.msu.ru>
 <20190625213215.GB3116@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20190625213215.GB3116@mit.edu>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2019 at 05:32:15PM -0400, Theodore Ts'o wrote:
> On Tue, Jun 25, 2019 at 07:11:50PM +0300, Arseny Maslennikov wrote:
> > This matches the behaviour of other Unix-like systems that have SIGINFO
> > and causes less harm to processes that do not install handlers for this
> > signal, making the keyboard status character non-fatal for them.
> >=20
> > This is implemented with the assumption that SIGINFO is defined
> > to be equivalent to SIGPWR; still, there is no reason for PWR to
> > result in termination of the signal recipient anyway =E2=80=94 it does =
not
> > indicate there is a fatal problem with the recipient's execution
> > context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
> > termination requests.
>=20
> So this is a consequence of trying to overload SIGINFO with SIGPWR.

Pretty much.

> At least on some legacy Unix systems, the way SIGPWR worked was that
> init would broadcast SIGPWR to all userspace process (with system
> daemons on an exception list so they could get shutdown last).
> Applications which didn't have a SIGPWR handler registered, would just
> exit.  Those that did, were expected to clean up in preparation with
> the impending shutdown.  After some period of time, then processes
> would get hard killed and then system daemons would get shut down and
> the system would cleanly shut itself down.
>=20
> So SIGPWR acted much like SIGHUP, and that's why the default behavior
> was "terminate".  Now, as far as I know, we've not actually used in
> that way, at least for most common distributions, but there is a sane
> reason why things are they way there are, and in there are people who
> have been using SIGPWR the way it had originally been intended, there
> is risk in overloading SIGINFO with SIGPWR --- in particular, typing
> ^T might cause some enterprise database to start shutting itself down.  :=
-)

Only if that enterprise database:
1) has a controlling terminal (a strange condition for a daemon, IMHO)
2) that terminal has the status character set in the struct termios.

>=20
> (In particular it might be worth checking Linux ports of Oracle and
> DB2.)

A quick google got me this document:
https://docs.oracle.com/cd/B28359_01/server.111/b32009.pdf
It only ever mentions CHLD, CONT, INT, PIPE, TERM, URG and IO.

I have no real experience with neither DB2 nor Oracle DB, though, and no
way to get hold of that kind of software, so I don't know where to look
further. If we'd like to be really sure no one's hurt we'll need someone
with actual expertise here.


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl0Td+cACgkQ9dQjyAYL
01C+9Q//QnhdAMuhEYr16Lcyx+FX+ZuTVpxDBHa6pogsPcLTd0K+J4XxxPp2+jC/
blxZ91l6mqNHkoESH7zXRyiZSHigh2HeFyymiE+89qtkf9ZO387f3vRjOtyu+UAz
jOujhiWETPCrUb1Yfw6tzCHP4odH7mnTaIydNw7OYuWyyIvkRQXnv0HQJalouzqf
F5hxr/1F0gMTomIr/dgc7bunQGFt3CzshZauHtdAPe7rainc3vbVvNqRHi9zJkL4
rkqK+S9Z++l3+EP/K4rgFNU2sQ12wgOJKMR90cuRN+tnfEZp5hOZcsDlr6LWA6tD
9BH7J5yCP8oNCecksvjDN49ZriS8aEoA/P6ojyjgVKDK5HipvCY+5LojaHjzDL23
7PmWi7VY9JVHkmFM3bCoU1oX4iVTh5CnyBj593M96S+wcR0i+v7j9o8J8rtd4rwk
Y9uM16BI4EcC+nNGefMS3e+qPVTn94WuzjH4myCTgGJPsO7wVZ4EYwBhioFT2tCs
EeHXbVVcZiwlPVp+mb4ZDO71hhpVYsrxOFYAXPGHAyeXwtoXbYxIJoOUROqxN7LV
qrZylTRi0ItP2NQpDMWbX9XcqOGcEs5+vlouLE/Hneoqkzx50xPFxdpjnthplCUN
Dm7MxjPFqgdfHW4W0jfxITJrMX+vkxsrrSM1ClYE8lw06FHfV2A=
=fn7K
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
