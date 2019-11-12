Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB65206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLBpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:45:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbfKLBpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:45:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF631AC68;
        Tue, 12 Nov 2019 01:45:17 +0000 (UTC)
Message-ID: <84ccea513e4ff21bdd374af01574e4bf04946bb6.camel@suse.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Phil Auld <pauld@redhat.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 12 Nov 2019 02:45:13 +0100
In-Reply-To: <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
         <20191031184236.GE5738@pauld.bos.csb>
         <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZsTu4C/KBLte9v9VjR6R"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZsTu4C/KBLte9v9VjR6R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-11-01 at 10:03 -0400, Vineeth Remanan Pillai wrote:
> Hi Phil,
>=20
> > Unless I'm mistaken 7 of the first 8 of these went into sched/core
> > and are now in linux (from v5.4-rc1). It may make sense to rebase
> > on
> > that and simplify the series.
> >=20
> Thanks a lot for pointing this out. We shall test on a rebased 5.4 RC
> and post the changes soon, if the tests goes well. For v3, while
> rebasing
> to an RC kernel, we saw perf regressions and hence did not check the
> RC kernel this time. You are absolutely right that we can simplify
> the
> patch series with 5.4 RC.
>=20
And, in case it's useful to anybody, here's a rebase of this series on
top of 5.4-rc7:

https://github.com/dfaggioli/linux/tree/wip/sched/v5.4-rc7-coresched

This also includes Tim's patch (this one
<5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>) and is, for
now, *only* compile tested.

Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-ZsTu4C/KBLte9v9VjR6R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl3KDqkACgkQFkJ4iaW4
c+7m5w//aGiX4TRS2rKI4xA7E32sBx9oS/QbqVtLBwVL2fB4lWDMCcRcI2r2q040
dboG+MDJAX226GEK8+o5YZLBaxuVo4tO50CnQq9W7CfjWVCBfO86kSIbHwx6zaKl
cDDXf+mRko+OD3izrKCAdFki1S8BcRCNUNs86QjiCk0yarEgoO8kPeNYTYpmK54g
9zne3J3lzzI43MNK25dS5sf+xWn1F8Oa+TI8g4fodYA4+hAhCEphkc2nQMcxsxr2
IImAa+RQv0ubKZ2suMRnbaPYYjLq8YSAxtywuoqpxc30jbb8HQdH4Q2Titj/AI25
HpacQn5yrMHvdHFX+0jzt8uBjLUOvSTN5Ja2PktGcLY/AJcmP+iiM3EUiT8i+TU/
Xc0OdKoTB9TgKNDD242S5J6x6wag0GT/C9RndqNL5hKpLapU4ibNTRmbxYI0CfFl
LRkitfDUyZo9FRasMLUCvKY8psH6Qn/GK9EDomZNY5HyV21q4N7KuDtKAKuD1BMi
gSPiICZVAxd1DvUgkwS3xBv05EhZDoWXvj3YId7GYn2XdKijw+kvP3iEwc7yJMFZ
wL69uN1uG8ij3bYQuXsywBvrU0spfV+kRfwJTsKcY5kE0OmYsLyYjT9cHFCufz/y
AMcY5pSTUPnlz/Kur1Y2716ts0xz5wHCqlZYn3urRUjKCPBSANE=
=Ohgt
-----END PGP SIGNATURE-----

--=-ZsTu4C/KBLte9v9VjR6R--

