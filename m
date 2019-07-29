Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7263EC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54648206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfG2P2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:28:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60498 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfG2P2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:28:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hs7ZE-0005xz-Kd; Mon, 29 Jul 2019 11:28:04 -0400
Message-ID: <25cd74fcee33dfd0b9604a8d1612187734037394.camel@surriel.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Jul 2019 11:28:04 -0400
In-Reply-To: <20190729150338.GF31398@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
         <20190729085235.GT31381@hirez.programming.kicks-ass.net>
         <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
         <20190729150338.GF31398@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jTygDaFHWv+tndg9/HZy"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jTygDaFHWv+tndg9/HZy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 17:03 +0200, Peter Zijlstra wrote:

> The 'sad' part is that x86 already switches to init_mm on idle and we
> only keep the active_mm around for 'stupid'.

Wait, where do we do that?

> Rik and Andy were working on getting that 'fixed' a while ago, not
> sure
> where that went.

My lazy TLB stuff got merged last year.=20

Did we miss a spot somewhere, where the code still
quietly switches to init_mm for no good reason?

--=20
All Rights Reversed.

--=-jTygDaFHWv+tndg9/HZy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/EIQACgkQznnekoTE
3oNL6QgAgxNj1HjPixQ3mbrfqWGtqw7ZBZ2IXL0ePQFLsl1DEQ/YB4zOW+SCHO8a
Wc0T5JdqAvzr7GJQ/BXcAp2hXHFZcW9ATbjDGF6tEDO5+vCU304aE3Xe8eIL+7ZW
nqM8VXsC5djsV+72u9jDTdBwbNtuYcpKC025j6PBs/nhyPj+JJb2SGNPZRhQCvQI
em+AvZZVNVSRl9sJHCgaVWXQTHf0oNj3eMMO7jI0dbBTaoWbfNLX3Gasi/heGsq6
Z7vb5GY+Gu5x5AFZCr7P/NBYGmUwXPt7qMP6kaOkH0BiAAJzzCPrLgf7E896J7W0
PdEk6eriZBRp1EcBaBN7UMt6zqcsUw==
=tfva
-----END PGP SIGNATURE-----

--=-jTygDaFHWv+tndg9/HZy--

