Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C77621883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfIBRrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:47:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51096 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfIBRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:47:49 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i4qQc-0007E3-4d; Mon, 02 Sep 2019 13:47:46 -0400
Message-ID: <9b5ce5b9b5404fb955d6f55a246f3971cedb06cf.camel@surriel.com>
Subject: Re: [PATCH 08/15] sched,fair: simplify timeslice length code
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Mon, 02 Sep 2019 13:47:45 -0400
In-Reply-To: <CAKfTPtBddg=_cDU7YDnk19uUjtSP+82fE7Yb28KPrSctimGNdQ@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-9-riel@surriel.com>
         <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
         <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
         <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com>
         <2a87463e8a51c34733e9c1fcf63380f9caa7afc4.camel@surriel.com>
         <CAKfTPtCAU7bT3sJ_FPexqKrfFzd8Yk0hVTEB5Da=+VbqPViXpA@mail.gmail.com>
         <2d3af2a8b6a433ea44a4605fc8b43bd0758102eb.camel@surriel.com>
         <CAKfTPtBddg=_cDU7YDnk19uUjtSP+82fE7Yb28KPrSctimGNdQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PLyN8MxfQTCvRx0FvTWn"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PLyN8MxfQTCvRx0FvTWn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-02 at 09:51 +0200, Vincent Guittot wrote:
> On Fri, 30 Aug 2019 at 17:02, Rik van Riel <riel@surriel.com> wrote:

> > I would be more than happy to drop this patch if you
> > prefer. Just let me know.
>=20
> If i'm  not wrong, this change is not mandatory to flatten the
> runqueue and because of the possible impact if you would prefer to
> drop it from this serie

OK, will do.

--=20
All Rights Reversed.

--=-PLyN8MxfQTCvRx0FvTWn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1tVcEACgkQznnekoTE
3oNftwgAkftA1vPMK0kgSsybNa1IA9tj1ZPXbhXsmCoJAWDR6HdkcH0mTF5VB5fP
q0Bz/dJH/RB/CcAWeDO8PhjTBTq5mjAHY9VZ82JzKHqdjvWeXBBS7aplGBAMD3VM
dmSwS/mJ1XDEI+OEK+Wo1iaBLAoKViEkChxrvEAKjNnDyup1Lkg3jIrGqHBFg+IY
7Ex6lNYLy2575MBGZfPPiSNM0Oy+GW1xlWXC/jL/2r2BCFlu7gKB4z56vOrm2/1Q
/4AVhPJtLPMeLxJlWaj4r3rBl+Y/cf2z5Vgp2YJtIOllvyU9+EMuR32LwECU+Q6N
On4VtCde5nje3NzT8Cw9g3OM4kElmA==
=lqk0
-----END PGP SIGNATURE-----

--=-PLyN8MxfQTCvRx0FvTWn--

