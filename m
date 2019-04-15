Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C7C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839072075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfDOUHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:07:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40477 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfDOUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:07:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BC81880317; Mon, 15 Apr 2019 22:07:39 +0200 (CEST)
Date:   Mon, 15 Apr 2019 22:07:47 +0200
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
Subject: Re: [PATCH 4.14 04/69] x86/power/32: Move SYSENTER MSR restoration
 to fix_processor_context()
Message-ID: <20190415200747.GC25908@amd>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183727.431075450@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20190415183727.431075450@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-15 20:58:22, Greg Kroah-Hartman wrote:
> [ Upstream commit 896c80bef4d3b357814a476663158aaf669d0fb3 ]
>=20
> x86_64 restores system call MSRs in fix_processor_context(), and
> x86_32 restored them along with segment registers.  The 64-bit
> variant makes more sense, so move the 32-bit code to match the
> 64-bit code.
>=20
> No side effects are expected to runtime behavior.

Again, this is cleanup, not a bugfix.
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly05JMACgkQMOfwapXb+vIsCwCeIbYgP+sW+IsNPVbawFZOvsTk
9bwAoKd0+XOD++SsxxlE/SHWckpB5Y48
=5Rz3
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
