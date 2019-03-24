Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8303C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED2D2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfCXWPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:15:13 -0400
Received: from sauhun.de ([88.99.104.3]:41044 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfCXWPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:15:12 -0400
Received: from localhost (p54B33218.dip0.t-ipconnect.de [84.179.50.24])
        by pokefinder.org (Postfix) with ESMTPSA id 9966D2C0114;
        Sun, 24 Mar 2019 23:15:10 +0100 (CET)
Date:   Sun, 24 Mar 2019 23:15:10 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bich HEMON <bich.hemon@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c-stm32: remove extra spaces
Message-ID: <20190324221510.GC6934@kunai>
References: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
 <1551885100-22207-2-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <1551885100-22207-2-git-send-email-bich.hemon@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 03:11:51PM +0000, Bich HEMON wrote:
> Remove extra spaces before colons.
>=20
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Applied to for-next, thanks!


--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyYAWkACgkQFA3kzBSg
KbYuuA//YID0MnGq+dDjMUdq9oeama+qE/P4HVb/BjYwmXTSI3u+jGwZV09CJ+A8
bAqoZfuV/qd+oAhFF+b5UHyjxnnmchjSmWMrj+f3ep2Syod+WmmYFx+pxXKSNCkk
FIJgQJEsPHyHZ7+blLBLkxNsb25ShlxvEGMNtHsJ+60uKmQIXyNHWuhNZCpzSDqN
vEVKTXPz3KLaZCjyF8XT238NTRa9Mx1Gmy+yr3Y3X1OkwY7XrVA7Gwu3NlG7qYCX
MevYlgBJzRTBMMXLisKBFeqZkVmh6kD5/sNToT7Gni57h3QmuRVf4LXuxwfbm8KH
Awavv4mm2qeAVkh65ECoAgWj5nkdKKAjlVFFPwOFlezsAU7i4oZhp0BIOAGwHeSi
2+PCXoWxNPlJVXlXy+prNBZR4DWULWajvOUmUObNbT6tIc7pDvgFmTadB37hec3O
jLadj8GBMjA6PB3j5g0uICFVryNuSdy7ur5V4ucWcFaaMnRtDE/vvbw5ukUsTUH0
2BIZc1myD6mU3wFvB/a8KH5pLL5Pq8JzN3Q/iLa8F7zwoY51P7D8S6M8bkWSHnZm
PKBrx6LJ3OQXPuscFxDImxBXBesCZuVv/AcmHRsh18XUksnhyKx/1sVBxebLVOc1
vBcpxBFHFXfVH9bOpvQF6DkClfcKLz1KF4SbnUY/MSjtYpuiwpo=
=LKzU
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
