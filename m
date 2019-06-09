Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0777EC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74BD206E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="IyAeS95x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfFIU4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 16:56:35 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:16306 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729637AbfFIU4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 16:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OJHA/ztj2Mefp9KTnxgvWqb7CJ2Zz+U6e1UeukWwwkg=; b=IyAeS95x09kYjxICmLDMpH0/z0
        PxsU+ukRTdzwLKHbzq3dIk7JFcjgLYJvxWgmpdfQVljipwoyPsP8ZuSFAZJ4NpQm6ZHgIue6uVGel
        8EWdNU2GioogFMojEad3hyHuL3qnkG+GI5HbopuxxO/AzNHIs/B+pb6bk3vXwJ7vSl/iwCiH2LGv4
        82PaVJsj5rzb3+L569NGITAkweXOf15lXzr3/zARA3EmBdw5AUqv8lcCjurf4Ubwgh5UN7GRj9pag
        CZuU9DZ+hNoyLZiC5VDDLvBb2//s/Uv+PpBPrG1PjfQDK18nascY6iul049H21oShU2UVUUb7pugo
        85thOULw==;
Received: from [37.204.119.143] (port=60738 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1ha4rN-000Oz8-MR; Sun, 09 Jun 2019 23:56:13 +0300
Date:   Sun, 9 Jun 2019 23:56:10 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
Message-ID: <20190609205610.GB3736@cello>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190609174139.GA11944@xo-6d-61-c0.localdomain>
 <20190609194013.GA3736@cello>
 <20190609195132.GA1430@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20190609195132.GA1430@amd>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2019 at 09:51:32PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > > This patch series introduces TTY keyboard status request, a feature=
 of
> > > > the n_tty line discipline that reserves a character in struct termi=
os
> > > > (^T by default) and reacts to it by printing a short informational =
line
> > > > to the terminal and sending a Unix signal to the tty's foreground
> > > > process group. The processes may, in response to the signal, output=
 a
> > > > textual description of what they're doing.
> > > >=20
> > > > The feature has been present in a similar form at least in
> > > > Free/Open/NetBSD; it would be nice to have something like this in L=
inux
> > > > as well. There is an LKML thread[1] where users have previously
> > > > expressed the rationale for this.
> > > >=20
> > > > The current implementation does not break existing kernel API in any
> > > > way, since, fortunately, all the architectures supported by the ker=
nel
> > > > happen to have at least 1 free byte in the termios control character
> > > > array.
> > >=20
> > > I like the idea... I was often wondering "how long will this dd take"=
=2E (And in
> > > case of dd, SIGUSR1 does the job).
> > >=20
> > > I assume this will off by default, so that applications using ^T toda=
y will not
> > > get surprise signals?
> >=20
> > If any of isig, icanon and iexten is disabled on the tty, the signal is
> > not sent.
>=20
> As expected.
>=20
> > Any application that wants to handle raw terminal input events itself,
> > e.g. vim, mutt, libreadline, anything ncurses-based, etc., has to turn
> > off the tty's cooked mode, i.e. at least icanon. This means those
> > applications are unaffected.
>=20
> Agreed, those are unaffected.
>=20
> But if I have an application doing read() from console (without
> manipulating tty), am I going to get surprise signal when user types
> ^T?
>=20
> 	     	      	      	     	      	     	       	     Pavel

As of now, that application will indeed receive a signal that is
guaranteed to be ignored by default.

This is similar to SIGWINCH, which is default-ignored as well: if the
terminal width/height changes (like when a terminal emulator window is
resized), its foreground pgrp gets a surprise signal as well, and the
processes that don't care about WINCH (and thus have default
disposition) do not get confused.
E.g. 'strace cat' demonstrates this quite clearly.


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAlz9cmUACgkQ9dQjyAYL
01DiLg/8Cdt57FGiYnFdFUmPdCyKxLZO0UgRuqJbBGCmjFsGXF/mS1R0Qb+UPmWk
5dFRRhixDpGMFkSSnk179OJkHWBmDUvtV0FMYCyp0CkGCG5YcLxVfYG7fcaVWiQN
qt/HZ1G1q6EAI5eLVOKHKA1N8h599rbJjZYH6j7le9W20DjN6LphexUp6HZ7IsF5
B1KslK5hNfSVAs9GZ9XMAptrcbJ4OusvLJJNfacKwoIrBMmAXkTIx32jxndbkeAn
U5F5Vs0hyjmnboOBYTzF5NGF8/PPPtVwXnu00FjpM+Hz+3pc9SEfbS4r4h7QiG6R
emKrGX/mTLeQcyk8XPtmInVqpcG5dWGhxeOu/H92ZpRzCl3gnUSzJr5/DFQrYa4T
1B0e1Vp5pGbEHS8mY1TwrXe/BldIkumiESjeaNkqqhDsBEla7xxGM2Pj7F/7DOIn
FYVOFNQ4kqxaGspvd1qzpwVPV4sVBDlQDYqkQu/l0c52MW8z76zDr7cwWnc0bevL
iETVpoQm0WQNbZWj4N2RSNLjwr9LgV4xpG9vLVUyOyXq7aIRQy+4EqhwIXUaL5uj
OLLKjs/LB3sYNUfm/qsS2FhA2QMKXo2SQMoFLAsrWv3mAZGXIHTbun5BtGMwYMx0
pBNC888Vvyn+4VgqZ6jp4ho2Lul5Ga9m7s/4/wso0lGe+QAbK88=
=phyb
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
