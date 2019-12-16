Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19028C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ED8206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576517752;
	bh=wmFneXX9KaDtw9SNcmVB31jZqkHQ/H37NUndAx1MXPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g2GKbr5+gJ41KZhc/IKOTKkjMhP4wGUIq4F/oUw3xX9xAkZcMWY7SshB1P5WUFu3r
	 snUmmcNwBdczJQC2hnsKO0w37fbL7Ev+3UVSqfU4ERfQEg7fJGnvhHwkrvX7w1ZT14
	 AtuS5Ws2j6QqZYaeQ9PtHk8/ttBHzsBVIgHtYy7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfLPRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:35:50 -0500
Received: from foss.arm.com ([217.140.110.172]:34690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:35:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8CD81FB;
        Mon, 16 Dec 2019 09:35:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66B683F718;
        Mon, 16 Dec 2019 09:35:49 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:35:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robert Karszniewicz <r.karszniewicz@phytec.de>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/1] regulator: of: Hide wrong warning regarding suspend
 state configuration
Message-ID: <20191216173547.GI4161@sirena.org.uk>
References: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
 <1576515981-77867-2-git-send-email-r.karszniewicz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <1576515981-77867-2-git-send-email-r.karszniewicz@phytec.de>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2019 at 06:06:21PM +0100, Robert Karszniewicz wrote:
> A "No configuration" warning is falsely emitted in the case when the
> of-property regulator-always-on is set but regulator-(on|off)-in-suspend
> isn't set.
> This patch fixes the warning by explicitly setting always-on regulator's
> states to ENABLE_IN_SUSPEND.

Suspend states are basically completely separate to runtime states (and
we quite often have no software control over them) so it's not expected
that always-on will have an effect on suspend mode; the documentation
could use some cleanup here as it's mostly written from a runtime only
perspective.

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33wHMACgkQJNaLcl1U
h9Bk4wf+KZvaStloLTIk94/HuOSEcaBm6v3L73m/sHSp3OAuF2+X0j3Y0KEx4puT
XdpUllNDi34v5Nuyxr4Oxl+rUOAa4ZqzuVn2r8N5e+8HHgKQrZnv1wPGDmBoXg9S
GCha/CBvHREXcsteBIu5kQiYQKwLGH68q6252v8rhMyj8oQrplqvsYpCkwZLSSxX
HdUmzSiJoAatMCArJ+VCyp9AsDc/yCC0i2zpzrVT7+zQRVFrhKiWdw9iBKqHq6J9
Q0NBxFS5D/VpPabdPFnKqpnvQB8bUiZq/wXfXKKmwXZcS4uZ1MU4mu6HDb6Cxi0h
dpTuwsmZMKcXtxOtk6tIXbH2z5uAQw==
=paIg
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
