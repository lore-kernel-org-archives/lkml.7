Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E425C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039042133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDKLvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:51:52 -0400
Received: from shelob.surriel.com ([96.67.55.147]:57934 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:51:52 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hEYEk-0000Q3-UT; Thu, 11 Apr 2019 07:51:22 -0400
Message-ID: <e1fc2c84f5ef2e1408f6fee7228a52a458990b31.camel@surriel.com>
Subject: Re: [Lsf-pc] [RFC 0/2] opportunistic memory reclaim of a killed
 process
From:   Rik van Riel <riel@surriel.com>
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     dancol@google.com, mhocko@suse.com, jannh@google.com,
        minchan@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        kernel-team@android.com, rientjes@google.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, hannes@cmpxchg.org, shakeelb@google.com,
        jrdr.linux@gmail.com, yuzhoujian@didichuxing.com,
        joel@joelfernandes.org, timmurray@google.com,
        lsf-pc@lists.linux-foundation.org, guro@fb.com,
        christian@brauner.io, ebiederm@xmission.com
Date:   Thu, 11 Apr 2019 07:51:21 -0400
In-Reply-To: <20190411014353.113252-1-surenb@google.com>
References: <20190411014353.113252-1-surenb@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EhA/ljhQjzQ1y1msvysd"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EhA/ljhQjzQ1y1msvysd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-04-10 at 18:43 -0700, Suren Baghdasaryan via Lsf-pc wrote:
> The time to kill a process and free its memory can be critical when
> the
> killing was done to prevent memory shortages affecting system
> responsiveness.

The OOM killer is fickle, and often takes a fairly
long time to trigger. Speeding up what happens after
that seems like the wrong thing to optimize.

Have you considered using something like oomd to
proactively kill tasks when memory gets low, so
you do not have to wait for an OOM kill?

--=20
All Rights Reversed.

--=-EhA/ljhQjzQ1y1msvysd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlyvKjkACgkQznnekoTE
3oPNQQgAs0Uab4UlWgiiD7o0gAjFu9zNhtef6Q+Tk1qFZDMnzCeQcQgFr9c4iRXN
YA7MqnAcKQ6mzle90nxueQHEgz067Eh9AEnnkzxnUEL7OmPsm7p/LKobNAelX86F
aJD2Ohpsaz4wDODe4je4iK2cK7pkQ5zkYn25+lm8MO5Ei4rDXLXTdTqwtHNompWG
V/64CxuTdeHiZa8HFrN2u+1SB0BUN2+kAJlfkkatfiDIUqyWNtN3oaQrK5/eFxXr
GnBrInkKVfr5+L2JfiCcC3fasbhQi4Z1g9HqQ7rxaT1QHziDMDhDp0g1ssR63nKr
JnFMfXOPt3pXbyfNAJB1ZOCk4xF1rA==
=JzJl
-----END PGP SIGNATURE-----

--=-EhA/ljhQjzQ1y1msvysd--

