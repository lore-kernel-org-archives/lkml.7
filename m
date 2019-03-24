Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1676C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FB12133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfCXWPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:15:17 -0400
Received: from sauhun.de ([88.99.104.3]:41060 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfCXWPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:15:16 -0400
Received: from localhost (p54B33218.dip0.t-ipconnect.de [84.179.50.24])
        by pokefinder.org (Postfix) with ESMTPSA id 9045F2C0114;
        Sun, 24 Mar 2019 23:15:14 +0100 (CET)
Date:   Sun, 24 Mar 2019 23:15:14 +0100
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
Subject: Re: [PATCH 2/2] dt-bindings: i2c-stm32: update optional properties
 for stm32h7/stm32mp1
Message-ID: <20190324221514.GD6934@kunai>
References: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
 <1551885100-22207-3-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <1551885100-22207-3-git-send-email-bich.hemon@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 03:11:51PM +0000, Bich HEMON wrote:
> Add STM32H7 and STM32MP1 in the list of compatible socs for each
> optional property.
>=20
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Applied to for-next, thanks!


--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyYAXIACgkQFA3kzBSg
Kbbubw/+Ki4GDhj9P/Q6W14qePiI/EiVawfSSa0XJykeeQC8SdW3hZNA3Ok5FkZ8
veAim3LCNHuzGFD4CikYk0m+KlerKd+yQ5vDQGAWad1LVlnBlz8adz0gcbvNICWG
2dYAtSvj+zwGHEWq8Wd1SliIuIrkxvLUtCBmRBkIfomKBUfl65pFfjc/Oin0rjF+
/bMexh3B2APxNtdb8wp416Vbm8z7+cAbl42ePnvc9/RQVeqaVQh4oNF1/nQK2jQz
XPUZNGV7yOUy3Sune7C9LgbM4Eiz/INzPI+3NI/2vd4Hg1iS3T6Svws41R1svFXA
Hvb3be4MfWBMpcvXb0QZ7kwXcMKKYr0N5jmPm50ieVnptcHEuu6bBEYbiTQpB7Gi
A/4Z9T9VDGda/6hJKbs2s3pIzCExph9FQV1ycGLDoMD0prdeLb9CFXDQ1EOHlXrW
7w79Y2ZJqCAaCE3OAq+27YLlqF1Gx6hRd4vCsXjrZQvOLXvLP8CQlDp6U1bUNyKY
JrfpZMhRYEoBXaRIN0Q8ACTVTYvvGSzAUHNmn2BdKa5ODWdQ7VNZMfeAxQYYfkcO
/2CfjBuJOspkTPsTICq55utoB4zhwX8RG1TFkgP28nCpjSVM1ZZdGhStNpKirJI/
ocKT12HDdbE5JHI1mGrIVc/Pnl/U45tm1BlaihI490ZKcUGpd/A=
=it3W
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
