Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC33EC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDEB2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfG2P3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:29:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60516 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387925AbfG2P3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:29:42 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hs7an-0005ym-DC; Mon, 29 Jul 2019 11:29:41 -0400
Message-ID: <5335b83c3371242f75abb6c92b40c665bb8f9ce3.camel@surriel.com>
Subject: Re: [PATCH] sched: Clean up active_mm reference counting
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, luto@kernel.org,
        mathieu.desnoyers@efficios.com
Date:   Mon, 29 Jul 2019 11:29:41 -0400
In-Reply-To: <20190729142450.GE31425@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
         <20190729085235.GT31381@hirez.programming.kicks-ass.net>
         <20190729142450.GE31425@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xhoRZta1p4CDAjhhG3pf"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xhoRZta1p4CDAjhhG3pf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 16:24 +0200, Peter Zijlstra wrote:

> Subject: sched: Clean up active_mm reference counting
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Jul 29 16:05:15 CEST 2019
>=20
> The current active_mm reference counting is confusing and sub-
> optimal.
>=20
> Rewrite the code to explicitly consider the 4 separate cases:
>=20

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-xhoRZta1p4CDAjhhG3pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/EOUACgkQznnekoTE
3oOjJwf/ajhjMXP9koUzmYeZd95QTTdo4qKU1rTnCPbOw2EJeuQ1PO+XoaWfG9jI
xK4Mf1ns4ypSWTut3wV3PCsi/RjWQNnbSBsEwPPVrmhivjFwWSY8GfQ6cDNnNASA
UGOd7rBvuGaDp6oJCfLHQz9lRLaJI47EHZuK28IvnWbjMY7aQyRMBnV58y0hAhoQ
HjAoSz2I4M/w37q94IVKYPKGuU+I+/g5zK6ZaY4PrBkw7hatv/yoUt6y3KoglFZY
APK3yTvtCwQQFNYdLMAXyJswmHeiLgOn/5c99NZjxU2nPv/OQ2kuO+NaXo0Cq4ac
izDJuwuoYNuCP/XfZNMLVQz5Inafxw==
=jzZW
-----END PGP SIGNATURE-----

--=-xhoRZta1p4CDAjhhG3pf--

