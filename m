Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A251C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C108F20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554705490;
	bh=3z3ZPW2g+wK6WT0Koy9mDAabdhEnX6dwek4U3LoLbM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FFBj4fYvPVxNhqVZVs7Yxft7PWSGmyahez1QlUMmSsS4TgmiXdvadHXggpWfhYZ/U
	 Vh8xR/CgRM08nvLDWpm3o+0e8cm3/ilMnOMY/mQe/hpPAKFJ0U6kQ6FX48R7y8T53x
	 PVxqbqEFFAG6TKkr6UmwqRtBhKBYM8vKxtLd64ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDHGiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:38:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37324 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDHGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3z3ZPW2g+wK6WT0Koy9mDAabdhEnX6dwek4U3LoLbM0=; b=K23RPJd1eoL3kcpcG1TecpZvG
        vHhLwIIowzEzi6KZIoK/G9dqYM9ub8gJRbPdAoVvTxg0pFoJaYsCU2sGc8STeVb7uW25hBjZL+sD5
        vLWQ4R6l+qp6dWgzsOjmJCfZAUJhMgz37ZTPq8KaMf6PgqcS+LSMUaLCCyamVGes91NcY=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDNuq-0003ei-EH; Mon, 08 Apr 2019 06:38:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A9B33441D3F; Mon,  8 Apr 2019 13:27:12 +0700 (+07)
Date:   Mon, 8 Apr 2019 13:27:12 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 10/20] Documentation: devicetree: spi: add
 spi-lsbyte-first propery
Message-ID: <20190408062712.GI2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-10-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <1554423259-26056-10-git-send-email-skomatineni@nvidia.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 05:14:09PM -0700, Sowjanya Komatineni wrote:
> spi-lsbyte-first optional property allows SPI slaves to choose byte
> order of little endian for transfers.

Why make this a DT property - surely it's either a fixed property of the
relevant devices if they are LSB first (in which case we should know we
can use it from the device) or it's something that the driver for the
device can just vary at runtime?

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq6b8ACgkQJNaLcl1U
h9CIKggAg+pGXgMOqakZ8c/g8PSsF9z9x/vbR2jo4tv/AmNxenu+gDCF78d4wBgB
a/2l8JORQi+knOxzUq0O7HhN8sR+lz7W45qVrc5jNLSAFPVRPSaBu9o3jxkHh5Sd
WlI4mX7d18KbnoGgJlXSU7j2FXmVrYQQgco6u259vht9zFqQCxLqUd8Gv2RwzLFL
3fiUpsU3BBp7EOE3YlMijX6Jqw76cpwmhmQP9joGwGnsUZexvBTkPen8+GSHqEtK
jBHKF0PSCcHGyvdVGJsd5g92ga3oIPrs0DaW4z/+yXTRKNkkZJTz9rX4rkHnU5ku
UmftTb8lLZibuRH4x8YdJsgLx5KvqA==
=Wt2d
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
