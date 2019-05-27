Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12014C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E3C20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfE0QMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:12:53 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52734 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfE0QMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:12:53 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVIF2-0002Gz-21; Mon, 27 May 2019 12:12:52 -0400
Message-ID: <e98182c01e5428e014ea6d59c827faabc649a6f9.camel@surriel.com>
Subject: Re: [PATCH 5/7] sched: Remove sd->*_idx
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
Date:   Mon, 27 May 2019 12:12:51 -0400
In-Reply-To: <20190527062116.11512-6-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-6-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FEAA1fWYI/MkdAoQ4TLb"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FEAA1fWYI/MkdAoQ4TLb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> The sched domain per rq load index files also disappear from the
> /proc/sys/kernel/sched_domain/cpuX/domainY directories.
>=20
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=-FEAA1fWYI/MkdAoQ4TLb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsDIMACgkQznnekoTE
3oMIRQf/QdCHuUBx4HQRuiYPeWUoIGyye+7dN69nBS93R8quGH0bTj2RbAEaOE3n
aVy0Lt94jYevh13iu4B9fCnYn0pw4+tzihQxBY+t/xpK4di6XWT/AenmjNqJlg69
fjJAAXKlQF0+9BOKeCY2JxiRbwvbUtKQnQybnk3W6cGEhwjKpUySnlAEetT5gnUi
umd0essZbGzMgu0YJVcGEiTFfqQ8KWKgUYQ4mLAEAjAGe20XjHDiBhsmt7hbdc0H
ObYFZ9DOemalhzJbpJn70ryubSV5nGCVJJ/mr/jDc3qZhmWF3SckPOtRtboUd4+i
Xk4uhPlxvDwjNcuF0brIocGIRBCW8Q==
=zTgr
-----END PGP SIGNATURE-----

--=-FEAA1fWYI/MkdAoQ4TLb--

