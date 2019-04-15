Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744FC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C2420880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfDOUEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:04:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40199 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfDOUEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:04:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 18A1380537; Mon, 15 Apr 2019 22:04:45 +0200 (CEST)
Date:   Mon, 15 Apr 2019 22:04:53 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.14 05/69] x86/power: Make restore_processor_context()
 sane
Message-ID: <20190415200452.GA25908@amd>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183727.581656002@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20190415183727.581656002@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-15 20:58:23, Greg Kroah-Hartman wrote:
> [ Upstream commit 7ee18d677989e99635027cee04c878950e0752b9 ]
>=20
> My previous attempt to fix a couple of bugs in __restore_processor_contex=
t():
>=20
>   5b06bbcfc2c6 ("x86/power: Fix some ordering bugs in __restore_processor=
_context()")
>=20
> ... introduced yet another bug, breaking suspend-resume.
>=20
> Rather than trying to come up with a minimal fix, let's try to clean it up
> for real.  This patch fixes quite a few things:

5b06bbcfc2c6 fixed theoretical bug; rather than porting it to stable
than fixing it up, it would be better not to port it to stable in the
first place or simply revert it there.

Thanks,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly04+QACgkQMOfwapXb+vJGgwCfXqUXWgPm5NBq7Ai1ZpsoLhgl
icsAn1TgPzftTqlhIi8HgPhxW83hu1XY
=Bewa
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
