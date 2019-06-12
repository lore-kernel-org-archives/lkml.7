Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895DCC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2992080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437035AbfFLKVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:21:52 -0400
Received: from sauhun.de ([88.99.104.3]:58188 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407987AbfFLKVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:21:51 -0400
Received: from localhost (p5486CACA.dip0.t-ipconnect.de [84.134.202.202])
        by pokefinder.org (Postfix) with ESMTPSA id C66992C54BC;
        Wed, 12 Jun 2019 12:21:49 +0200 (CEST)
Date:   Wed, 12 Jun 2019 12:21:49 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bitan Biswas <bbiswas@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>
Subject: Re: [PATCH V5 4/7] i2c: tegra: add spinlock definition comment
Message-ID: <20190612102149.gebnmuwbrrziqina@ninjato>
References: <1560250274-18499-1-git-send-email-bbiswas@nvidia.com>
 <1560250274-18499-4-git-send-email-bbiswas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="syrdxohe2neenpi3"
Content-Disposition: inline
In-Reply-To: <1560250274-18499-4-git-send-email-bbiswas@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--syrdxohe2neenpi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 03:51:11AM -0700, Bitan Biswas wrote:
> Fix checkpatch.pl CHECK as follows:
> CHECK: spinlock_t definition without comment
> +       spinlock_t xfer_lock;
>=20
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Applied to for-next, thanks!


--syrdxohe2neenpi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0A0j0ACgkQFA3kzBSg
KbYnUg/8C6Ikq70WXseSBxacKWo08CyoMd+yd+W09dKxaYPnxLrfazUxkPYTTE7D
4VLEzeBcMDujgklma9uKQQOqFdjf8v+pDUoRaQYiOCQiNY+WWqrClAD0oj404gfN
z8/JgE6yM6Bc9WAYMBc0Dr8cTk0kmjb6BqHLw/t/89vb6C8egqDgNIzMJZUA8j+o
34GgAI14Nixh2b0beKnxIZmvD8XgaThurpwhyEY02klL+wuaDz5cJGR2Cg/7JBQL
VR8YdfSg1VcznYWhfQNj5rxSWdkCrSGhcli34d6ySj7/K1xEtodp6gr4N1fSSuED
gCp6mNNSre2UmiCMyW+8DNo4Hf4tao80MJQXzulXNs5iYWfy+aVgJ68LnJeiLElY
tGhz6/zvXbkFMWwaHkrx2L9Y3+z/ANF8dSAO215IjibnfkefuCvPBZ5lmoqlI5R4
vUJERgxd7HAFQgVOzsj3AUnm5I1L9n0mb4xjwVYZxpHCdRQutawdZV/hDMJR01vu
ryYDRisv+6vfBQuxeJ8T53aV9ABOwYf9cuEn++bKkFhE93zllGk1zmPRYywNlZUd
7gqeSkGMmrEU3ChN/ajnaKigRJsFjYBl8r0kE/ApYC3PMptnQ7oU1sGIMqmVXI+B
hj0QunKsplmbpx9PikzCMGWzPRAWMZkmfDhPiSfBVODZihuIL6o=
=KqxX
-----END PGP SIGNATURE-----

--syrdxohe2neenpi3--
