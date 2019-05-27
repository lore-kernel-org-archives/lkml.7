Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8177AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDDF2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE0QJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:09:24 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52688 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0QJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:09:24 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVIBe-0002FI-JQ; Mon, 27 May 2019 12:09:22 -0400
Message-ID: <719dc34ddead383f511e8092d34f03b8b39e9fd2.camel@surriel.com>
Subject: Re: [PATCH 2/7] sched/fair: Replace source_load() & target_load()
 w/ weighted_cpuload()
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
Date:   Mon, 27 May 2019 12:09:22 -0400
In-Reply-To: <20190527062116.11512-3-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-3-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-q6hS1EoOvyAnlvZXONQ2"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q6hS1EoOvyAnlvZXONQ2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> With LB_BIAS disabled, source_load() & target_load() return
> weighted_cpuload(). Replace both with calls to weighted_cpuload().
>=20
> The function to obtain the load index (sd->*_idx) for an sd,
> get_sd_load_idx(), can be removed as well.
>=20
> Finally, get rid of the sched feature LB_BIAS.
>=20
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=-q6hS1EoOvyAnlvZXONQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsC7IACgkQznnekoTE
3oPpsAf+JT7blZJbRbAiZNjcI5C2d7ojGNQzk5BMwjrYxjkSptvPpn/Dy63BDwU9
xcRG2aCZ7H2ekanDfZBrnETMQmxnl60LS6BxoT/G9arR0uNzpC78aSz/p//WYYN4
hH66GWjAWKQX+n7SfRiFrVRNzuSiLWeWoggbhwb5eOjbbGvdwdnDzmpDZHI1tmZy
UoV8c/2+flNlc644Pk+md5rl1sB0Yuxvi07eYNTRqLKnuldUkLZbGBuc94KinMLo
EXsAlxvyHvkNbz6iFM/veqPFSioFHtNzYW0NMFCEEUua0i5tAU7lYa4SgCpWWVMD
n+IH3QgS6WfTUrSyW6plfgTxpMKqGg==
=5Sgu
-----END PGP SIGNATURE-----

--=-q6hS1EoOvyAnlvZXONQ2--

