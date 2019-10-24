Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33B52084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571945512;
	bh=ZYHjAX/b+kUbAl/Jj0HZ4gVPKvrqwDOLe7uDKfric+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emFXF5WPZXlAof3nrLn6ukvJ7ivYLrWnGpphMnPhi8Eal1v87C9AdRQ9MRyLXYQHS
	 5toQNOR7YR6EjrMcM1pDFHv9emyGO+uos+LRVFIF1MrM3TEVikQtmgdA04LgyMu5Nx
	 F31vSJiVgLIA/kHw/CCFVfOoURTaEJKerCHgNTQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbfJXTbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:31:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53982 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732494AbfJXTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bYLTR5lAt1DS4s85acQPDIZhTtsS4lcp9InvxsMxs2c=; b=SNfRyomBYgNIcIrjGAs2fDuUx
        HFRo92ePd0ZbJQB/7ucujoUwNCQx9kwWRugvqtDQ3XHrenBP4aSwToELPjj8W0GtlM7z8w1MkGkn7
        XcojAivOAByPsvGYlSqf9zojNSDxYt3F50mX3PygApPxNZR5qpxbgng0QktxwQkGP5IuE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNipf-0003zT-Se; Thu, 24 Oct 2019 19:31:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1EBBD274293C; Thu, 24 Oct 2019 20:31:39 +0100 (BST)
Date:   Thu, 24 Oct 2019 20:31:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal Paillet <p.paillet@st.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/1] regulator: stm32_pwr: Enable driver for stm32mp157
Message-ID: <20191024193139.GK46373@sirena.co.uk>
References: <20191024154121.8503-1-p.paillet@st.com>
 <20191024154121.8503-2-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
Content-Disposition: inline
In-Reply-To: <20191024154121.8503-2-p.paillet@st.com>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:41:21PM +0200, Pascal Paillet wrote:

> @@ -875,6 +875,7 @@ config REGULATOR_STM32_VREFBUF
>  config REGULATOR_STM32_PWR
>  	bool "STMicroelectronics STM32 PWR"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	default MACH_STM32MP157
>  	help

This isn't the sort of stuff we usually put in Kconfig, we usually just
leave it in the defconfig - why do things differently here?

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2x/BoACgkQJNaLcl1U
h9Auzgf9GVwXP4xb4sT3oaFPMYv4yv+Y/2lbK00lHXm8d3BZqOL3+eJY8Ve7G8/X
QP8uoEKFQpqM4l1kw5Jhz7+owyvK7Ch4VXZxWwxyyxQw13cg5CghLVqG8X7JR9g1
rWs2ADsjV4tOEpvEldUFDY1qPumlhChoMUVbb2NzEi1++Q9FYdpzfOBXUur6WcuX
xyUFqTIrXYudIu2vMlk/xaa+jpib/2t+dorMc0v29oAoUQfITVS8k9W1PDcbyLTf
TPjFWIk8xfKCRFFWQscqoIUSS1ldosMAxQosFs/mu0RCeCnUSrvuuhLf+jKYDmfm
wxcwlNJzMb1NHZSoQ7O8YU4Xeai5jQ==
=4PH1
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--
