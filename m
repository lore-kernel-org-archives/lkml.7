Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4DC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBCB21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569429925;
	bh=fhs9k7FdCaf3ch97oov/IXh/ex3MLes/Q6xhgZoPvM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KgNN3V0k/tcnZJlpllmXJlD51LwFBjX5K2wBdBHI7RTD/FqlBXWT/1EQI3Z4PwZqe
	 Z+Vdz5FsmGsmYeKAQzVMAGdRgAOpzPAAeCQR6zIdam7qWMAB1qWPW6BQzseugWbBLy
	 YDufvpSfatUUrc0iUIFnStfvmkuQ9Dn6UIxnTDNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbfIYQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:45:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391916AbfIYQpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7y+HfIZ6ZjSCuJsrId/50nzQ9enIfiTTA4qGihG5qEo=; b=kM7JA2BVrkhFNP8duNWma1lCd
        qAV3mCDY4C9l9QxA9CXWUFF6/KgGjr5Yf9dPzjRfPrCW5JjsVxx9uhlz7gMv5cduRMOhjPWo1hCJb
        WAE7nP6ewnGD1JPcoaHXq0XacFJinWB/kqc7WS06YMh1vjCSpDQ8GHfXJ1eBWQlZgpFkA=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDAPn-0007tC-NN; Wed, 25 Sep 2019 16:45:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8574BD01BD1; Wed, 25 Sep 2019 17:45:17 +0100 (BST)
Date:   Wed, 25 Sep 2019 09:45:17 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
Message-ID: <20190925164517.GI2036@sirena.org.uk>
References: <20190924110547.14770-1-lukma@denx.de>
 <20190925091143.15468-1-lukma@denx.de>
 <20190925091143.15468-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xzV2nyj/vUZRUtI2"
Content-Disposition: inline
In-Reply-To: <20190925091143.15468-2-lukma@denx.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xzV2nyj/vUZRUtI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2019 at 11:11:42AM +0200, Lukasz Majewski wrote:
> This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
> in the slave mode (like NXP's dspi driver for Vybrid SoC).

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

That said I'll handle this this one time.

--xzV2nyj/vUZRUtI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2LmXQACgkQJNaLcl1U
h9AX+wf/YRDipet4jypZCYH78t9sIO4yBQwRzjv9DLVcymB1XijNG10pbEZJZ2jt
kMBpgC6UkBZGYB8UygjYvzMdenYZgbzSa0rV013H2GaWwVzInVdPF0xJ6/uDvVak
9CZD+ZzYg3HqCBOPvzCXa2kPVvc2KmCJttjRB37QXaGzrEWEvSjbaSfszL2dIuk3
E3xCNU6Y+noyIjwSmrKL0WxSHwdUx4ldAaOWdPFdAL14+yGNMQbTCXwP3WdC35DB
tRaO09BGacJvbP3SVVTvr4EGG6Qi2oFYEHaUpCWMtSJWYwzxA4YGNc7FgqCiLaO0
MzP6qGgidGi4lPuWomspXMyRPUBKmg==
=QKDX
-----END PGP SIGNATURE-----

--xzV2nyj/vUZRUtI2--
