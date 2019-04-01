Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC8FC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D62520857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104992;
	bh=3pU95i7q7PU2lCLcalusXRsqYipduxfSR93YFICNWWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WMU9DYiYmW7HPwDQkPNEqgZEVUkv4hYEAm8tdOkhZhgUFKo50FTw7L6xV6s2fEUc0
	 C+fGVgU8EvJh7SgLfefPcKLrKOfOTmCi+WTZSCxRDbvei9DwJnmh5sykpFWxOn/JUq
	 68QBkxoGNWXWQ0PBBXSaxOPH4l8xMRUOQAoeegII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfDAHtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:49:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37420 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbfDAHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3pU95i7q7PU2lCLcalusXRsqYipduxfSR93YFICNWWc=; b=SymJcD6AvRrWMVWnOQ4Zlix/+
        dfZ9L+xKQRwO4MtB6n1idP9JT1VwjOLMseFUTtrBUxbWkXGMT4oGjr+c5V4fK/6SjBolpX0WLlAAz
        C3xebMRazmW4Ku8lqBiwQwHHoFkKOiJg4+S9+c4mNESsRw6oi9ipTDfoKIJLhBeYIVahw=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArhP-00088S-KF; Mon, 01 Apr 2019 07:49:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3F63F440082; Mon,  1 Apr 2019 08:49:40 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:49:40 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is
 reset to its default
Message-ID: <20190401074940.GL2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:45PM -0700, Sowjanya Komatineni wrote:
> With SW CS, during transfer completion CS is de-asserted by writing the
> default command1 register value to SPI_COMMAND1 register. With this both
> mode and CS state are set at the same time and if current transfer mode
> is different to default SPI mode and if mode change happens prior to CS
> de-assert, clock polarity can change while CS is active before transfer
> finishes.

This is a bug fix so I'd expect it to be much earlier in the series
before any of the new features.

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwpMACgkQJNaLcl1U
h9Bpygf/TbdkEy6Q+FfZhGR0lmQSqgaXu3RXuS1Vlv74EsyVNGbcjCDMLRaWVi0z
AEEsy31rNjVe/kqIctYJDlpKWiAo3s/e2PmVOK5AwWBGT6T63WyP4D8Q3zwC4JRI
UuTXIr9aTHD3CLMkfXfRMAmXXHawTabaOReaKwTMqqhNgYdpg1zpmiBM7YvDX3IX
PlE0tAGaRklxIDFdge9wXtHYbCpUC4VbZx4NICsTpF+g2n8iw9CoaimIACa7qRud
hVIzF2eRa80ID4zeltfxlcu4o6YaaE9go/uqQcxknFGDwLKZihiVn8698gANNOFm
hldnv/vWlSWtWsxDuhrwyKvf4usQfw==
=2SUy
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
