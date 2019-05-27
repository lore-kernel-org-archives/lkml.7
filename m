Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640FAC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BD52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfE0QJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:09:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52674 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0QJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:09:12 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVIBK-0002F0-PF; Mon, 27 May 2019 12:09:02 -0400
Message-ID: <05db73c0c4594d8428e30f15b09e6ae8c0da4e07.camel@surriel.com>
Subject: Re: [PATCH 1/7] sched: Remove rq->cpu_load[] update code
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 May 2019 12:09:02 -0400
In-Reply-To: <20190527062116.11512-2-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-2-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cNrPoMQaGz8ZPHR4bhZP"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cNrPoMQaGz8ZPHR4bhZP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> With LB_BIAS disabled, there is no need to update the rq-
> >cpu_load[idx]
> any more.
>=20
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=-cNrPoMQaGz8ZPHR4bhZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsC54ACgkQznnekoTE
3oOznwgAhyYzNT+IZaxzQR0GnIRvA6zvgAFnYavgEJ4u1Ho+/yN2A/j2zO21VADa
4ePmUcF3t92Wje8kymUGTVpkJWhWDuH9g5KVo9Y9xRI3EIaZ+I0mTIG/klukiRYh
kwBTwyMl/RHt00b6FqLn238Ld+jiICE/6IY3QzT0ZFLGAQyh8Vjg5mCHmH2RJAHa
htfX71wMTevL3/3w3T+FBYUFo0pm77mqGzGVWHOwnViJbbkv7MYmEgZFi/vd9sJ1
bfQw3ICb2CYq1XafP/o+buN0LVeVJtP+iwiqpbK28ga9ukNpJVApt0TrUdKvrAyx
LcQZxqb1cWcwHR5NO0AGmBX0AVX57w==
=ML4Y
-----END PGP SIGNATURE-----

--=-cNrPoMQaGz8ZPHR4bhZP--

