Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B9FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FA32081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfE0QKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:10:53 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52716 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfE0QKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:10:53 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVID6-0002GO-2w; Mon, 27 May 2019 12:10:52 -0400
Message-ID: <e99dd79e39babc807c59fcaa8f8a5aebe7323c83.camel@surriel.com>
Subject: Re: [PATCH 4/7] sched: Remove rq->cpu_load[]
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
Date:   Mon, 27 May 2019 12:10:51 -0400
In-Reply-To: <20190527062116.11512-5-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-5-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3C5cbkrEVw6Fd+HoCPP+"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3C5cbkrEVw6Fd+HoCPP+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> The per rq load array values also disappear from the cpu#X sections
> in
> /proc/sched_debug.
>=20
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=-3C5cbkrEVw6Fd+HoCPP+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsDAsACgkQznnekoTE
3oMhSwgAwPA9cm9wurd2+ptkLzCjIYXB475HO/YaqZhyHvr6JkKYL+Cjv2zAJ2nK
WtIb7HZQEhETPj+QCLP4VHU9pyuJW9ne559VzyQn5oZIG88X+fLYhc46inWwpefe
TGNFtLdaz/0RXfx8mKkfF41D8PKIGTSg0Fji4ID3UYdD/b0rL2R+a+/CQSlXzcMr
VGLkyHsMOeGrENVtJ/iLFsV9cjZ5eTLPJmZyZHpD+q68GnIroGNsBYlFQZHM7Sou
VHXzv+q5w+M+xfPEAuZBPV3uJpwIdD3Dd4Kuf+Gdn9mM0o+3d5WzJfs0yb5LxosI
zlhECI1vo9x21UN9hj6v6mV5H3Aqbw==
=Z51Z
-----END PGP SIGNATURE-----

--=-3C5cbkrEVw6Fd+HoCPP+--

