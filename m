Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C0FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584AE263F0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559577792;
	bh=NEjaGkA9YxQ6dXSF1iP/n1zuClUGkSikmg2LBf6HDhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kReBsG5RimcSqYiwJxb29Xw/v3KqRom6b4nnYa8fW+tHr1f8ZT+9tiLEM8kjjYPbU
	 rXTaImuP9taViWYyn6MwBDty9vf5e+qJ3Wk8o4o5oldzYSL/SbvL3hfkWcj7NorAGu
	 rP6QXjQaB8OvdpWL90uTFhxgMS5PZZqgOVGMmIFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfFCQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:03:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfFCQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dp+gjvYWRdgHVkhbmlVJAz1zWAjzq79b6MVJC60iFPQ=; b=FpJ9y5ceJuqEha547Jxv6YK28
        kmLIzpgGEwfBWgLJxR+bDcoU/9yBoB8F6sJMbCGVjiGD/hFzQcCot81TqlMSPn30bS4kFYyiD78Cg
        kQh7kbX2j117vXP8+2lR1gMrMfGyqVNEdKmqnbK5+E+XG44MMlrz6f+ArPKvJkmVhl+VU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXpQG-0002Ic-E7; Mon, 03 Jun 2019 16:02:56 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 76257440046; Mon,  3 Jun 2019 17:02:55 +0100 (BST)
Date:   Mon, 3 Jun 2019 17:02:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 09/57] drivers: sound: rockchip: rk3399: Use
 bus_find_device_by_of_node helper
Message-ID: <20190603160255.GA27065@sirena.org.uk>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <1559577023-558-10-git-send-email-suzuki.poulose@arm.com>
X-Cookie: Been Transferred Lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 04:49:35PM +0100, Suzuki K Poulose wrote:
> Switch to using the bus_find_device_by_of_node helper

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Acked-by: Mark Brown <broonie@kernel.org>

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1RK4ACgkQJNaLcl1U
h9DAowf+PJhFFfev/hfXmzrc3lXbYtKrtaH2AWJctdLKF8NITVZYeDac1/YxdWQZ
5oRw2NhJAxlhj1xrtMxh0q5H1HezivdBiEqifu404MMnn83vnT7hSG4slSXSPkk6
PlokK0cvaie6gRvPpAMUOrmwixP6akITU4/yOH4PjWbBRedHAkc6NSd1y7IKloiI
NOmQoX4KZi1PBhxjcKaj2P0B8G6E45TUTHKGYxtl8n0c4vwUXW1u23Kf/MKaINtr
6vUDoOzBkZEbkNfchAEUCnU6WUYSTXrTWagVWpWRT0Af4y/QfuW04vsAM/4Tmwx1
vy+cJ2wV591mNPb95PYauA7DMmnLcg==
=wwku
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
