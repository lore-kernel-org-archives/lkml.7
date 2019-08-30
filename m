Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BAC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7044D2341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3PCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:02:04 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50176 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfH3PCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:02:04 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i3iPL-0006pL-6U; Fri, 30 Aug 2019 11:01:47 -0400
Message-ID: <2d3af2a8b6a433ea44a4605fc8b43bd0758102eb.camel@surriel.com>
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
Date:   Fri, 30 Aug 2019 11:01:46 -0400
In-Reply-To: <CAKfTPtCAU7bT3sJ_FPexqKrfFzd8Yk0hVTEB5Da=+VbqPViXpA@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-9-riel@surriel.com>
         <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
         <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
         <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com>
         <2a87463e8a51c34733e9c1fcf63380f9caa7afc4.camel@surriel.com>
         <CAKfTPtCAU7bT3sJ_FPexqKrfFzd8Yk0hVTEB5Da=+VbqPViXpA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1cm7ri3PMAtO68E1OP46"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1cm7ri3PMAtO68E1OP46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-30 at 08:41 +0200, Vincent Guittot wrote:

> > When tasks get their timeslice rounded up, that will increase
> > the total sched period in a similar way the old code did by
> > returning a longer period from __sched_period.
>=20
> sched_slice is not a strict value and scheduler will not schedule out
> the task after the sched_slice (unless you enable HRTICK which is
> disable by default). Instead it will wait for next tick to change the
> running task
>=20
> sched_slice is mainly use to ensure a minimum running time in a row.
> With this change, the running time of the high priority task will
> most
> probably be split in several slice instead of one

I would be more than happy to drop this patch if you
prefer. Just let me know.

--=20
All Rights Reversed.

--=-1cm7ri3PMAtO68E1OP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1pOloACgkQznnekoTE
3oMoMgf9G3CzXr2Yjj4ri4V3/EKyeQ2NMMnm7mbNPCuBvopRHJubKB01vZMR3ZT7
hYoyoab1egyAPUiBmobv4sgQRFI83Snf/ZyenWrU0X49LBFsYevZSyKFr+fY8Hac
hdWaTOQe6qDMTs0MNcL0+qzzfAweBI7g0babqzYzAuWvUGlDmqcdLRmqG1ixf5Zl
e9zuLe99KseYZmfR+RNy9CXJT1k1pPpo0AoKzQA8WVEfxTAWlyKKaxdS39NezVnY
lLziwMQYv+1F80z4hJKj+MietlT/VkU6dTLzxj1U9CYKcpB/fAs+Dr1fX2RaCbPT
WYu2uXk7z7YQa8MHoLuqM+cPAO+tBA==
=YYvF
-----END PGP SIGNATURE-----

--=-1cm7ri3PMAtO68E1OP46--

