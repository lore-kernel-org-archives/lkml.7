Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7589C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9B206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="YNRcI223"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFITkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:40:36 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:51469 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbfFITkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8p/3fZK/s1siWzfplSSPQ/g/MO+2LfS3DPis0BGpLYU=; b=YNRcI223fkJN7t1Pb8LKFiecM9
        Tn9KLa0DFTWmfb0pwMHYgcsz6KFIgV16Ptsd3MTp+MFwRzi4AQbK8k31oUFnkVO9bplHaIDODz7fi
        jRpQYXvBfU7nZ+ITq/wgft+RB7sjts0CuPHDLW1j2x87yxDqJFBF8WZw2PWXle6q4oMSFYJ9FFWm0
        9+s0yqFZnhcmsSv3roPE+fhpxQGRdpt8wUyB/udU30nXDmI5la8D41xiamwBoFZvImub0/x22F62q
        o8CmbnWZL6aA9vkriqsHmUaUv6si4V27qenD3Gejtkaf6c5DSzQswHNf1HCpTwlzZtozz+ucRePAz
        LfSaPunQ==;
Received: from [37.204.119.143] (port=60196 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1ha3fx-000F41-8V; Sun, 09 Jun 2019 22:40:21 +0300
Date:   Sun, 9 Jun 2019 22:40:14 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
Message-ID: <20190609194013.GA3736@cello>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190609174139.GA11944@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20190609174139.GA11944@xo-6d-61-c0.localdomain>
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


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2019 at 07:41:39PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > This patch series introduces TTY keyboard status request, a feature of
> > the n_tty line discipline that reserves a character in struct termios
> > (^T by default) and reacts to it by printing a short informational line
> > to the terminal and sending a Unix signal to the tty's foreground
> > process group. The processes may, in response to the signal, output a
> > textual description of what they're doing.
> >=20
> > The feature has been present in a similar form at least in
> > Free/Open/NetBSD; it would be nice to have something like this in Linux
> > as well. There is an LKML thread[1] where users have previously
> > expressed the rationale for this.
> >=20
> > The current implementation does not break existing kernel API in any
> > way, since, fortunately, all the architectures supported by the kernel
> > happen to have at least 1 free byte in the termios control character
> > array.
>=20
> I like the idea... I was often wondering "how long will this dd take". (A=
nd in
> case of dd, SIGUSR1 does the job).
>=20
> I assume this will off by default, so that applications using ^T today wi=
ll not
> get surprise signals?
> 									Pavel

If any of isig, icanon and iexten is disabled on the tty, the signal is
not sent.

Any application that wants to handle raw terminal input events itself,
e.g. vim, mutt, libreadline, anything ncurses-based, etc., has to turn
off the tty's cooked mode, i.e. at least icanon. This means those
applications are unaffected.

The commit messages of individual patches try to explain this in detail.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAlz9YJYACgkQ9dQjyAYL
01B86g//b0V6wV6Ji1V6fDtnZkzYr2OFFnXyiPE0n9s5AW5Pw8NH9HPnHDS+evy3
lNo9ekbQllTmzNkUw1NPvWqZqRoAj/uhOa1cf6nJcl+c9MsniwlDUgsZIfNg0jT5
1YHcd2yZxCWsxX5i+vg+jgxLmGUwg3stgxPpvDMO+azGtiTOT0sP2nOXoKfTxLD/
A/SqvOFH5TlXaLr0hKGr5fJ57PHCZtE1AnRCkjALN1Pd4t2+bwzLl1z7uqHUab9N
YZCWUB9P0U2czW2jyUca1iTVBt64HivjfIpw+3kzLnPjHCcFsLluOkZXFdHtSyH8
nDXDnXirYLRzF5ub3MmZfSn4AMsyXOyHd1S4YjGkDqI2/f5ob5c4npiKmxiVJUF2
5oJrnGOU2EMfS2aVvda93cufgAGs8Sh8Ya08iDI/9PbEjVgSw23MCj/+s4hMMnlj
IifEQX1MK2+1YmtXIjftq9w15Uso8uALuHDRqfvYZNNAYJ2SHhYHDNa33VUnkFlw
WOUYmB2eEe702lrM1LH06fs8kLnyVJcKCcpzE7j/9edHCE0usBXdroOva+tmoARY
Sa10W6olY/ZQbvUw7n0iCVVR02NU5QqnnJPEqEUdWe+GSmw1fFXPSBRh8rLaEp4p
BNyno6JADz8XFefPe9KWZvePNKTBoDAnF2o4XIaVTRlZRevQXuQ=
=DN1s
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
