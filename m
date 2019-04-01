Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F08C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4692133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDAPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:13:55 -0400
Received: from sauhun.de ([88.99.104.3]:52084 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:13:55 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 02E3F2C7BF4;
        Mon,  1 Apr 2019 17:13:52 +0200 (CEST)
Date:   Mon, 1 Apr 2019 17:13:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Message-ID: <20190401151352.tf7ljaqpzic6hlj3@ninjato>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
 <20190401112109.GB12232@hirez.programming.kicks-ass.net>
 <20190401115414.hxrqqjujvwczdafz@ninjato>
 <20190401134224.GD12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5q7udkjw363natoy"
Content-Disposition: inline
In-Reply-To: <20190401134224.GD12232@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5q7udkjw363natoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Looking at kernel_restart_prepare(), we set SYSTEM_REBOOT in normal
> context, specifically it just did a blocking notifier call.
>=20
> So no, you'll have to combine the two.

I see now. Combining the two is still readable, but I'll abstract this
away into some 'i2c_is_atomic_xfer_mode()' helper with proper
explanation. Thank you for the input!


--5q7udkjw363natoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiKrAACgkQFA3kzBSg
Kbb9fhAAgdxtR0YZkUVqgbe0pJ84u9zEPK81oMzK0wiWAJDrE+loguZeKFd2rsYd
Yn5ovyhRmkmXqBgMug/iR7mhmj/+IX6TAF0VJMuQce7liMApUqJB7XHVnDUdHLaZ
Jpb1w3VN4JjUPEdp3eRKPR4ECzScz3MLV1voP8LMjHP0q6kyWxN2GdecmRH7LyjY
Q++GClmliiPhRosMtEd6yBf921rMzQTYYvt//zWXBauofv8cyZlhce7b31tQl5Pb
uiNidBTG9otaRUjxbcNHYwTM3NFGv7fwTwljhksHpU5XxdDmDEV3QdBCKu1GVvZw
EnK/nPpVUNzOta9+wMDQyt48VYzFzO/iLrxZqr8fc+HtKolnawdETIA37ZJ389XT
wEcVVPZibe+PFBf3iiqBeBpWUIyyo3ruX5R38g5Wn0zWX7lfxHn8ZTYu6Fz6NF6f
Z98/HFIYDzWTU95JFIYTogJHhybZGBPLUaGXcCXzAZ3lE7HsmboM5uPZ0WKtoWrf
B9AzsHaNewBnNEHCDbApE/4CrActL82mN3xJ1vUVSEL9+l6pFkzs3wLzNJfmYgFg
udS+a/biNW8HrfthNpu5pwqF6WteelT56fJVMklXo5hEH7ou+IOBBVrmgbZL5oDO
I44J68uuTC4L18ekouyY0Znzr/LsDRfSOvSm6nmBzz7Fh5CTBro=
=FYTW
-----END PGP SIGNATURE-----

--5q7udkjw363natoy--
