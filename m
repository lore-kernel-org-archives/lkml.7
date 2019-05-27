Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC0C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3495C20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfE0QNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:13:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52746 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfE0QNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:13:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVIFp-0002HL-GH; Mon, 27 May 2019 12:13:41 -0400
Message-ID: <7d7500fc2b3128163caebf01c05438cfa3c8079a.camel@surriel.com>
Subject: Re: [PATCH 6/7] sched/fair: Remove sgs->sum_weighted_load
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
Date:   Mon, 27 May 2019 12:13:41 -0400
In-Reply-To: <20190527062116.11512-7-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-7-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OTYKBKueamPqjR5KpjYv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OTYKBKueamPqjR5KpjYv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> Since sg_lb_stats::sum_weighted_load is now identical with
> sg_lb_stats::group_load remove it and replace its use case
> (calculating load per task) with the latter.
>=20
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Rik van Riel <riel@surriel.com>
=20
--=20
All Rights Reversed.

--=-OTYKBKueamPqjR5KpjYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsDLUACgkQznnekoTE
3oOy1Af+LFmQ9yiyCrokCmZgh6M3TYVdJtUtMOsNnU13IuSPQI2R1Dvx7iMccJKS
WV848fbVYYLYv8stwZSSx6q7N97lEWJcV79HlVf2YqyM5F/upCa6ZoDf+LYdJAHD
zs5Anz0lp0Jq3SLSmq7YX0kIAd7x6m2lBAZ9Q7rlOYF3zZb4m1OMpvaiaGRj74n4
PD0nEUOqvrHVT3rtKGqnGR8KLT8/fq4hETF73W0sNBol0yqkNfeg8H8lhLVC80wj
1gcSLTXdj+mUYHLR6PUEKX0p2iFe8VnF/M6iUCjuQIFME5t4FFWXyvEyDvPZerHR
cYSUGGiQuIELkFeJVsC5R5azr1wPoQ==
=1IHs
-----END PGP SIGNATURE-----

--=-OTYKBKueamPqjR5KpjYv--

