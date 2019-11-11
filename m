Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211B620659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKKNY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:24:56 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34426 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfKKNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:24:54 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C9E161C100B; Mon, 11 Nov 2019 14:24:52 +0100 (CET)
Date:   Mon, 11 Nov 2019 14:24:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, stable@kernel.org,
        Chris.Paterson2@renesas.com
Subject: patch in 4.4.201-rc1 breaks build (mm, meminit: recalculate pcpu
 batch and high limits after init completes)
Message-ID: <20191111132451.GA1208@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This seems to break our build with particular
=2Econfig. (cip-kernel-config/4.4.y-cip/arm/moxa_mxc_defconfig).

commit df82285ab4b974f2040f31dbabdd11e055a282c2
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Tue Nov 5 21:16:27 2019 -0800

    mm, meminit: recalculate pcpu batch and high limits after init completes
   =20
    commit 3e8fc0075e24338b1117cdff6a79477427b8dbed upstream.



Quoting Chris Peterson:

> I've seen a failure this morning with our linux stable-rc build
> testing.

> Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1
> Arch: arm
> Config: moxa_mxc_defconfig

> Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/=
95016985
> Failure: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/9=
5016985/failures
> Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/34697=
4180

> All other configurations that we build were successful.

> Kind regards, Chris

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXclhIwAKCRAw5/Bqldv6
8oFXAJwLGUettz85/zedw5Yxg7iUyMSEowCfQeReBPpITdtD59Dcz43EM/NmN/k=
=Krw7
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
