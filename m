Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3341C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB5F20679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="hIUQiUYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfG2K4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:56:23 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:42647 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387424AbfG2K4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KhDc0y3uqAsWa5PYel9fH/ttSxd0IlvtLtCn7+kzD+g=; b=hIUQiUYJS6l8mNK6X1i6x9OtN7
        nlKtUuF0eBYFegEIhnp3w9scJf/FCDoFi66i4Mw0yTB2XylZj6filLde44+goR1fcyFDonKn8zEOs
        kFsKCs67vmLoll+xmvAJ//cql/KwTfQ3RhPzh97o5kkNlflrTA1DXCQRTBS5iF7ROY8mXT/8EO6Ja
        pBrme3KTIF5wLlsx3nxlj2a7xslxVurx/5NQW53nkjiiv8kVrA95SGhwbPSsVB9NuDa2eY/+1tDip
        beKZnZtiED0JuQPvb3E+nXC0Jrnl88G37fCyfN1gzDL30Y5nYr4T+Knkt1rRbG+Gac2QZNHxsVhVF
        ja7jngmQ==;
Received: from [37.204.119.143] (port=58278 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hs3KA-0008RA-78; Mon, 29 Jul 2019 13:56:14 +0300
Date:   Mon, 29 Jul 2019 13:56:12 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Message-ID: <20190729105612.GB25742@cello>
References: <20190625161153.29811-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 0/7] TTY Keyboard Status Request
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2019 at 07:11:46PM +0300, Arseny Maslennikov wrote:
> This patch series introduces TTY keyboard status request, a feature of
> the n_tty line discipline that reserves a character in struct termios
> (^T by default) and reacts to it by printing a short informational line
> to the terminal and sending a Unix signal to the tty's foreground
> process group. The processes may, in response to the signal, output a
> textual description of what they're doing.
>=20
> The feature has been present in a similar form at least in
> Free/Open/NetBSD; it would be nice to have something like this in Linux
> as well. There is an LKML thread[1] where users have previously
> expressed the rationale for this.
>=20
> The current implementation does not break existing kernel API in any
> way, since, fortunately, all the architectures supported by the kernel
> happen to have at least 1 free byte in the termios control character
> array.
>=20
> The series should cleanly apply to tty-next.
>=20
> To thoroughly test these, one might need at least a patched stty among
> other tools, so I've brought up a simple initrd generator[2] which can
> be used to create a lightweight environment to boot up in a VM and to
> fiddle with.
>=20
> [1] https://lore.kernel.org/lkml/1415200663.3247743.187387481.75CE9317@we=
bmail.messagingengine.com/
> [2] https://github.com/porrided/tty-kb-status-userspace
>=20
> v2 <- v1: removed useless debugging bits.
>=20
> Discussion of v1:
> https://lore.kernel.org/lkml/20190605081906.28938-1-ar@cs.msu.ru/
>=20
> Arseny Maslennikov (7):
>   signal.h: Define SIGINFO on all architectures
>   tty: termios: Reserve space for VSTATUS in .c_cc
>   n_tty: Send SIGINFO to fg pgrp on status request character
>   linux/signal.h: Ignore SIGINFO by default in new tasks
>   tty: Add NOKERNINFO lflag to termios
>   n_tty: ->ops->write: Cut core logic out to a separate function
>   n_tty: Provide an informational line on VSTATUS receipt
>=20
>  arch/alpha/include/asm/termios.h         |   4 +-
>  arch/alpha/include/uapi/asm/termbits.h   |   2 +
>  arch/arm/include/uapi/asm/signal.h       |   1 +
>  arch/h8300/include/uapi/asm/signal.h     |   1 +
>  arch/ia64/include/asm/termios.h          |   4 +-
>  arch/ia64/include/uapi/asm/signal.h      |   1 +
>  arch/ia64/include/uapi/asm/termbits.h    |   2 +
>  arch/m68k/include/uapi/asm/signal.h      |   1 +
>  arch/mips/include/asm/termios.h          |   4 +-
>  arch/mips/include/uapi/asm/signal.h      |   1 +
>  arch/mips/include/uapi/asm/termbits.h    |   2 +
>  arch/parisc/include/asm/termios.h        |   4 +-
>  arch/parisc/include/uapi/asm/signal.h    |   1 +
>  arch/parisc/include/uapi/asm/termbits.h  |   2 +
>  arch/powerpc/include/asm/termios.h       |   4 +-
>  arch/powerpc/include/uapi/asm/signal.h   |   1 +
>  arch/powerpc/include/uapi/asm/termbits.h |   2 +
>  arch/s390/include/asm/termios.h          |   4 +-
>  arch/s390/include/uapi/asm/signal.h      |   1 +
>  arch/sparc/include/asm/termios.h         |   4 +-
>  arch/sparc/include/uapi/asm/signal.h     |   2 +
>  arch/sparc/include/uapi/asm/termbits.h   |   2 +
>  arch/x86/include/uapi/asm/signal.h       |   1 +
>  arch/xtensa/include/uapi/asm/signal.h    |   1 +
>  arch/xtensa/include/uapi/asm/termbits.h  |   2 +
>  drivers/tty/Makefile                     |   3 +-
>  drivers/tty/n_tty.c                      |  70 ++++-
>  drivers/tty/n_tty_status.c               | 337 +++++++++++++++++++++++
>  include/asm-generic/termios.h            |   4 +-
>  include/linux/sched.h                    |   7 +
>  include/linux/signal.h                   |   5 +-
>  include/linux/tty.h                      |   7 +-
>  include/uapi/asm-generic/signal.h        |   1 +
>  include/uapi/asm-generic/termbits.h      |   2 +
>  34 files changed, 457 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/tty/n_tty_status.c
>=20

> Date: Tue, 25 Jun 2019 19:11:46 +0300
Ping.

The series should cleanly apply to 5.3-rc2 and to tty-next as of writing
this email.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl0+0MwACgkQ9dQjyAYL
01CceRAAxHmrLCcZw6xWtjgyTLTvK2ktb1A5NKNpAErfPmBihjA7Vn5k9QBBegyL
uRv95D/Hoz1LSXP7rwaQvKdH00S/ZlkHFHdw6hH7Q4gE6lN9L3jJoFY+lX9/9Oqw
BCa94zOedislJIgRqPfs/OicYaSpHndNStfej9tFvhk43q0eULS+f9jxDsrO85BY
nFbV2ECs3rd6ujT7tZj1Wc/NhViz0BsPDpfwassNov8Ik/L1UA5KPh2N8ezapGr4
uP0K6YbDXfxQI2ivI2wB4d9BwNlAunDw0reVK2ENKw8vhWrsMbj9mLUexcaEJBbs
nXxh4x7QdviSFmlgV0Jl/8Jwih4tijDuCcakV5IG2WPDSy04rKGJZeNvKDrVn2By
GhHIqy7YTo7WLkRRM/Q24pG9wM5XX3TKemN4wIfkBsB+ZalxWtkWqsuOo1ftMBxk
OUPl7PR25wUpKXGXVVzNB1rSvUHNaZNEe5tUSeOpMuhSNrI31EylxJOBNtm0yNsc
lEpNNERaEo3hBWt4PCbXZk7J1xSAPMUsTnzz3ClwBGcLsd8DovajnRLNeN56ar00
uS/iSwCug8f45CQy99KsCbQfw0vpO1IPAIkmse7uYrERxSMmRCqkksBAcOmgJzoV
i67Klay9PfUBNJyX3OLEAuOadYXdi7a4b0G7/BNMo7VH7IM4yq8=
=hAzz
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
