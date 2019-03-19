Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4952146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553000282;
	bh=NFCLKBs9iJn/N9j1xH2sTW9luHMOgL20jf/3zOYC2Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aioz89jqzMcvDrAFuo4TtrGxzh7/TCqsdOuTVGl635AzvwWRVFCahGV2jl1J2htyW
	 3btpYtAl3RkPobV6f5ysq//Rx4D3i3/Xx/AGsTkTnh5R03SQpl6Dh28HMDHNgs76/u
	 +KKQ+Va5FOjBcVY26ip0Ef7BytDxGs3a/NOjVsHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCSM6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:58:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCSM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NFCLKBs9iJn/N9j1xH2sTW9luHMOgL20jf/3zOYC2Iw=; b=guAx8QjRBVN8Y1Xf9VEa2xwsX
        48rloH0xhYqP++/DGjTz1PsTJgY+bgM17XYPiuXzApSTekO3t1aKPwq3X66mLFf9SQhbgOLiuolOK
        wry2sVFqBrsCbunmsYP6NCV9lsRGJmjSmBx4haRIQYNHiX/Svl27SZkVALNOiwQ9KVkNY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EJU-0002ww-RL; Tue, 19 Mar 2019 12:57:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 62C0F11288DF; Tue, 19 Mar 2019 12:57:47 +0000 (GMT)
Date:   Tue, 19 Mar 2019 12:57:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: idma64: Use actual device for DMA transfers
Message-ID: <20190319125747.GC5514@sirena.org.uk>
References: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
X-Cookie: PURGE COMPLETE.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 06:39:30PM +0300, Andy Shevchenko wrote:
> Intel IOMMU, when enabled, tries to find the domain of the device,
> assuming it's a PCI one, during DMA operations, such as mapping or
> unmapping. Since we are splitting the actual PCI device to couple of

Acked-by: Mark Brown <broonie@kernel.org>

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyQ50oACgkQJNaLcl1U
h9BWoQf6AikcRK0ln1GJY2lTfUMdPnWYgLla9DdKl8DY9TMEK8UIvOJLkOPFkkgZ
8MBJdiL+2II3x3nDJmkz+LgVghlFukCuHRTEHjcY4fKeFX5Dbqcm0/KQhgJTD0NW
XrHhGP7Bm1FIyC9q5fSsTnpmiKyVsizCmShnC0/rqPfihoC69a7KQJ7L9PxTyQkT
Sg7nq+Qo2JqE18YiI4YRrqOlnfQ7Ref1yf5zxViZwH2UEFFhnjJT/PcBrun2o2zc
rlBbnNRpHo/8qJEvhjwG9A8ulx5Ofvvj3v8pa9AR5R2iFU4EzVSeVCZhQXEBk5ak
gvQD1TxaTtRxk33YEyZBR7RElp3wZg==
=yBp4
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
