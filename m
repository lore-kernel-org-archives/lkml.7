Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B1C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1FE2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfFSPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:55:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41988 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:55:18 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hdcvX-0005mW-6q; Wed, 19 Jun 2019 11:55:11 -0400
Message-ID: <ec72421264eadcfde3491076ed4e7b60d08ad44a.camel@surriel.com>
Subject: Re: [PATCH 1/8] sched: introduce task_se_h_load helper
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
Date:   Wed, 19 Jun 2019 11:55:10 -0400
In-Reply-To: <9e75dd03-23e5-8ab3-8f5c-789b2581b3a7@arm.com>
References: <20190612193227.993-1-riel@surriel.com>
         <20190612193227.993-2-riel@surriel.com>
         <55d914d2-fba2-48c0-e7ff-3c7337c8cf8e@arm.com>
         <c8c3a78884be6c1b3a5e0984750ed8968230c976.camel@surriel.com>
         <9e75dd03-23e5-8ab3-8f5c-789b2581b3a7@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Hns3IAshFzQkBUV3/YoC"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hns3IAshFzQkBUV3/YoC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-19 at 17:18 +0200, Dietmar Eggemann wrote:
> On 6/19/19 3:57 PM, Rik van Riel wrote:
>=20
> > That would work, but task_h_load then dereferences
> > task->se to get the se->avg.load_avg value.
> >=20
> > Going back to task from the se, only to then get the
> > se from the task seems a little unnecessary :)
> >=20
> > Can you explain why you think task_h_load(task_of(se))
> > would be better? I think I may be overlooking something.
>=20
> Ah, OK, I just wanted to avoid having task_se_h_load() and
> task_h_load()
> at the same time. You could replace the remaining calls to
> task_h_load(p) with task_se_h_load(&p->se) in this case.
>=20
> - task_load =3D task_h_load(p);
> + task_load =3D task_se_h_load(&p->se);
>=20
> Not that important though right now ...

That I can do.

I might as well do that while going through the
rest of the series to merge in the bug fix that
I have for the performance regression, and the
fixes for compilation with other config options.

Thank you for the suggestion.

--=20
All Rights Reversed.

--=-Hns3IAshFzQkBUV3/YoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0KWt4ACgkQznnekoTE
3oN1uQgAl8/y0j/qN7nIABc3VO2EBqzbnCCJol+xEM2LkXVEQ5LNGlChRdf3COwS
QbOMesZhHu7Ugia8F3AqxVOUTottcEIOF9BIaf4/1v+WD4Jns6593XTr3gnd+Nhy
2/HL0+itu/1uKLls+BQiLZatz6eHGNAxgzOTeGZEytVhJgNrOgxudg45SnDVGIwI
G2QbPbT8HHI/hDEZkH+CGs3oBML76o/Qf78p7Z3XGiIIG/g3v6gkmv6kXUvPkrF0
yt+KxBzYomF2zjSyLKkQi7IZH1IQJcXKzKVqMXHSbPAbjyIil0oTX+5FqWUy07Lm
IYiLEGqZDllbBFfKii0gJKdzrKImQQ==
=6KI8
-----END PGP SIGNATURE-----

--=-Hns3IAshFzQkBUV3/YoC--

