Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A124ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1087F2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569952520;
	bh=r0Irq5C6yXon926rmoPoBGtL8VmGw6On3UnexaEHzys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K2BDU4NxKYof4i96vcUt872oYq5yW7O7mDVtbDwQzhbNQ/20aH3R2+OgE8WQLWW8i
	 7afRTox1v2i+5jyjlyLqN9qOEX51ftJM92OZTsOsKnq8ywkjs7QgAJXSvbFfGO5X3V
	 m9BA6Ls8DiFa3pPDQGVnboQFIsmReLLdC3bwiBMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfJARzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:55:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48982 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJARzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UdeDTcRqRLmOWNI66TIvhiXBuusNntkv2kJPDqWMITI=; b=cI5pL9xvdMaZoQSXt/BoTvwCf
        6MS2X7NqiP8DNfNNUfGVb1cu90q/m0myKcYkXX8xFft8BLi1/eB1uQnWkEvPaSyVqJ7zv254ZjiaL
        0xfG4zbL4U3UWysSzRXKZSORC6SNhkkmiB1vOhVgMIPOuM7iGQ26qhGgh++OtljBweJ90=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFMMZ-0005rl-6M; Tue, 01 Oct 2019 17:55:03 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 13E7327429C0; Tue,  1 Oct 2019 18:55:02 +0100 (BST)
Date:   Tue, 1 Oct 2019 18:55:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
Message-ID: <20191001175501.GA14762@sirena.co.uk>
References: <20191001142116.1172290-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20191001142116.1172290-1-arnd@arndb.de>
X-Cookie: Happiness is twin floppies.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 04:20:55PM +0200, Arnd Bergmann wrote:
> The ssc audio driver can call into both pdc and dma backends.  With the
> latest rework, the logic to do this in a safe way avoiding link errors
> was removed, bringing back link errors that were fixed long ago in commit
> 061981ff8cc8 ("ASoC: atmel: properly select dma driver state") such as

This doesn't apply against current code, please check and resend.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TkvUACgkQJNaLcl1U
h9BpXwf/ZbLU57SSOIs72nreZTj7QYl5ewRdha8NvlgMpwL9Tpoann2+x+D1YwW4
YrgZi10+u/d5JJXj26Le5tfl9/XHOiEtnsmSGeyyZ4HCMkGdsN/pbOteyNVq8OSm
m0kbUZzyPrs4UShvQmtmf/NVGAEMno5FWExHJMesI+HCkAguc43qkgPrhCK6w6hE
OTG/+vIokBlBGCwqdM597185U5H/O/zeEtMF//UhLEOyzm7SiowvGAFOukr7PQzK
UCJeArfyY1ik0gYbptXvjoo3+Y1DKg/sRNdtNoF14WIS2oHOkTKm6dpuqxfN2RIt
He43J5QRq+JEaBnzvw/+7mvakg5Rjg==
=mk8+
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
