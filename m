Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDFEC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8481821882
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfI3BNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:13:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36100 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 21:13:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iEkFA-0005C3-KS; Sun, 29 Sep 2019 21:12:52 -0400
Message-ID: <df9fc32955789e7fcd01623433faba8d2f446b6e.camel@surriel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
Date:   Sun, 29 Sep 2019 21:12:52 -0400
In-Reply-To: <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
         <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2AVNAWhLoNHLiOt8ttgM"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2AVNAWhLoNHLiOt8ttgM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
>=20
> Also the load balance decisions have been consolidated in the 3
> functions
> below after removing the few bypasses and hacks of the current code:
> - update_sd_pick_busiest() select the busiest sched_group.
> - find_busiest_group() checks if there is an imbalance between local
> and
>   busiest group.
> - calculate_imbalance() decides what have to be moved.

I really like the direction this series is going.

However, I suppose I should run these patches for
a few days with some of our test workloads before
I send out an ack for this patch :)

--=20
All Rights Reversed.

--=-2AVNAWhLoNHLiOt8ttgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2RVpQACgkQznnekoTE
3oNfggf/WBHfPWe8ErJONlgEHEoT5xpDMS8PsFn+p720AyAAYR7n+U+qfNF4/VWl
UsBOX/dGfDo7XeSI4TmtWwrrcbF0Qr6uyScCRrhRRQ/oB9qfHCyCWRATkEHjBpmQ
YntJJ2fGDfZoRYy189dIcVVdFXDkJK046XwqMTi1NstOQOjMw8drAJp3uLoM7Hn6
RaqEaG1MUMpvIHfW5AMGCHqedIjUXdc4/+YJJBeOTQ7PfOcHP6sGVkeDBCXCnSzB
+KCQk4gEg8Q6uJuEk3L+62MZdzPXcd8U5ERU7we3VN7+BMffHN7QrxD1NseFBWil
nLI2XRqjWZ6tlRCaRSYsKRcXHQJQhw==
=gOeM
-----END PGP SIGNATURE-----

--=-2AVNAWhLoNHLiOt8ttgM--

