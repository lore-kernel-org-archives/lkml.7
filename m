Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4151CC76196
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212A620665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbfGPS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:56:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46498 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:56:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 304EA80593; Tue, 16 Jul 2019 20:56:38 +0200 (CEST)
Date:   Tue, 16 Jul 2019 20:56:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Get rid of unused flags
Message-ID: <20190716185648.GA10400@amd>
References: <cover.1562854650.git.amit.kucheria@linaro.org>
 <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-11 19:51:25, Amit Kucheria wrote:
> The network_latency and network_throughput flags for PM-QoS have not
> found much use in drivers or in userspace since they were introduced.
>=20
> Commit 4a733ef1bea7 ("mac80211: remove PM-QoS listener") removed the
> only user PM_QOS_NETWORK_LATENCY in the kernel a while ago and there
> don't seem to be any userspace tools using the character device files
> either.
>=20
> PM_QOS_MEMORY_BANDWIDTH was never even added to the trace events.
>=20
> Remove all the flags except cpu_dma_latency.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0uHfAACgkQMOfwapXb+vJRpgCcCE9t/fdfV6fpDv/gchk5E7g9
qhwAoKUmdMWsShK2uX5HYwRgtGCfzlTu
=IZXP
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
