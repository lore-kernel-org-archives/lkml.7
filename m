Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D1C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEB220854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfDOUH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:07:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40444 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDOUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:07:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6D990808B5; Mon, 15 Apr 2019 22:07:18 +0200 (CEST)
Date:   Mon, 15 Apr 2019 22:07:26 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 03/69] x86/power/64: Use struct desc_ptr for the IDT
 in struct saved_context
Message-ID: <20190415200726.GB25908@amd>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183726.883542005@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20190415183726.883542005@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-15 20:58:21, Greg Kroah-Hartman wrote:
> [ Upstream commit 090edbe23ff57940fca7f57d9165ce57a826bd7a ]
>=20
> x86_64's saved_context nonsensically used separate idt_limit and
> idt_base fields and then cast &idt_limit to struct desc_ptr *.
>=20
> This was correct (with -fno-strict-aliasing), but it's confusing,
> served no purpose, and required #ifdeffery. Simplify this by
> using struct desc_ptr directly.
>=20
> No change in functionality.

While this is nice cleanup, I don't think it fixes real bug. I don't
think it is suitable for stable.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly05H4ACgkQMOfwapXb+vI8vwCgpFPRTxX1otqogabjtE4mQxQ6
7REAoJafCSaqi+UbR69IaTdzovq5xZtA
=gtHO
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
