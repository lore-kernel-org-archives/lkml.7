Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6820EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F61E2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfH1P2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:28:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32896 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1P2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:28:05 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i2zrd-0002Tn-1e; Wed, 28 Aug 2019 11:28:01 -0400
Message-ID: <552e6a1b7fc5656874e19d9e9cf2553b60e8796e.camel@surriel.com>
Subject: Re: [PATCH 06/15] sched,cfs: use explicit cfs_rq of parent se helper
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
Date:   Wed, 28 Aug 2019 11:28:00 -0400
In-Reply-To: <CAKfTPtCsuz7DN-NkmbMpLyNG=CqbAeONV8JpCVQmSCsd387eNQ@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-7-riel@surriel.com>
         <CAKfTPtCsuz7DN-NkmbMpLyNG=CqbAeONV8JpCVQmSCsd387eNQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pdcw+lgZJEgGvsS0YsGE"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pdcw+lgZJEgGvsS0YsGE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-28 at 15:53 +0200, Vincent Guittot wrote:
> On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > Use an explicit "cfs_rq of parent sched_entity" helper in a few
> > strategic places, where cfs_rq_of(se) may no longer point at the
>=20
> The only case is the sched_entity of a task which will point to root
> cfs, isn't it ?

True. I am more than open to ideas to simplify this
part of the code, hopefully in some way that makes
it easier to read.

--=20
All Rights Reversed.

--=-pdcw+lgZJEgGvsS0YsGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1mnYAACgkQznnekoTE
3oOjigf+OTG6zD+WWXu0mqWfHaY9Yn0q40DIc9MxyoRwxv6eNRLE2+xO6IpSgCyW
IGe7icAb7WnBt2OgZRyhqm2SLeejAzJ3KTbMIqqE4q0sw3K0yGjzTZyyIUO1OgkE
9KODyE3vb/dHlAznyuPdKlthCfzW/my2KFqeFJUwr5c2o+eX6PlN63TuGg1MtilP
i9Qp1Po5BHEyVc1E+w5u8a9dT2/JgYKj4E11JoC58vhf995t4dWI6aQWBMJwwNJB
DRUL01SSdDjrzIK/AWk3iXaBvY4sTxbNMpBaHlFNcU+/buMLOOO1SgPfgZqaM6uE
FoodS57clL5HpicEvNlgORxbAA3kbw==
=AHrI
-----END PGP SIGNATURE-----

--=-pdcw+lgZJEgGvsS0YsGE--

