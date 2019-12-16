Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D7C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D878206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576517140;
	bh=bBBiotfOFrlazG9N0s8XOUkiF0Hy12FNzxT6IZn2waQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iAKhHEtQIT2ugYvp+6RsLyWdHKbzY4ey+vP12CDnBMUKLtnQVWJ066O0wEorgF2BT
	 0DdoYnBytIP2+d7MKyRXF7GpfZwNJPpIJbFgHt1N2ls+d3DDdXJ/Gf70DwTaJQ/YTv
	 G1GrgQOftl1cfsZHKjmBDzLR5fAwynZBxkfk45pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLPRZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:25:39 -0500
Received: from foss.arm.com ([217.140.110.172]:34416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:25:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C031FB;
        Mon, 16 Dec 2019 09:25:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4BEC3F718;
        Mon, 16 Dec 2019 09:25:37 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:25:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robert Karszniewicz <r.karszniewicz@phytec.de>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 0/1] regulator: of: Does always-on imply on-in-suspend?
Message-ID: <20191216172536.GH4161@sirena.org.uk>
References: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 06:06:20PM +0100, Robert Karszniewicz wrote:
> Hi all.
>=20
> Just to make sure; the oftree property regulator-always-on implies that f=
or
> every suspend state, the property regulator-on-in-suspend is implicit? Wi=
th no
> other side-effect? Reading the documentation, this is what I interpret.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33vg8ACgkQJNaLcl1U
h9Agjgf/eTBhT1IRc0gwy0fBe070mHfYubFS6opXT459S3ZMYFS/Gl4syA1p1BjN
wmFuNHxQepJpHXtS5VmyJh+RRLRftF/4uiWrAyFhS+WLd2GYRiIPdhiDJtH1Pqi5
ltehB/e1Nn0KAJdOD4lOck7ComjME9l0PaJcv/n7b0pDwYyQA0BdUdFDndsn0pdX
dtVvFdBSJ5+Vc1PJfDtUE1srRssacaC9LKnfpcFsudTIst9TfRWw5iEKt1SrAi9B
uvW5BTRzW8lCpXMJlBLSPGhTtuWj8Y0S+wxMC8QsRynUBFly5ZCgVr21B3WuGCoa
Hyp3xGDVtgvQ53/cgcM6Gm2dkJjSHg==
=K9AB
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
