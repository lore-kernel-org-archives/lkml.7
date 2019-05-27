Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF1B2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfE0QKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:10:35 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52702 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0QKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:10:35 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVICn-0002G0-2I; Mon, 27 May 2019 12:10:33 -0400
Message-ID: <26b598e342d34bbd1c2b65f9aaac0fd7a0d63860.camel@surriel.com>
Subject: Re: [PATCH 3/7] sched/debug: Remove sd->*_idx range on sysctl
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
Date:   Mon, 27 May 2019 12:10:32 -0400
In-Reply-To: <20190527062116.11512-4-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-4-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DRuyszJJMMUUjWdjmzcP"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DRuyszJJMMUUjWdjmzcP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> This reverts commit 201c373e8e48 ("sched/debug: Limit sd->*_idx range
> on
> sysctl").
>=20
> Load indexes (sd->*_idx) are no longer needed without rq->cpu_load[].
> The range check for load indexes can be removed as well. Get rid of
> it
> before the rq->cpu_load[] since it uses CPU_LOAD_IDX_MAX.
>=20
> At the same time, fix the following coding style issues detected by
> scripts/checkpatch.pl:
>=20
>   ERROR: space prohibited before that ','
>   ERROR: space prohibited before that close parenthesis ')'
>=20
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-DRuyszJJMMUUjWdjmzcP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsC/gACgkQznnekoTE
3oMX4gf/QoT1HjFvxTTqNtVLIq7X7yNsX4jjwPkCAV9dCuesW0piCV2Guq7mfeJt
lmwzufN2K9VUN87P0nmCH1SIlYn68ucJUWVVfd5XGJpq24nEz2V2gGzunuk++++i
kKu3JDh0rBclkoE07iMH8SF24YTsZRR3D5hmwr+0/hYqKGo0/YBVkyini0gENrsc
q3xBsgQ4UOWgc6BtsDGQM2Ur/1EeaKciuMbiRFXD1btmvGuZtREd+63dUMKnOanN
wrkmX7BsraVVtCCrR16pHMU2q8dPTovmcuXrK9SM3HQjR2wxYIVZIZZnFdaiFu/h
16ywgGF0wouFylkX/UKlLAEtxKClBg==
=hDFH
-----END PGP SIGNATURE-----

--=-DRuyszJJMMUUjWdjmzcP--

