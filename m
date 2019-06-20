Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F151CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561045326;
	bh=v03C322y5FrHQeDuwVvWrF4MCZyT6rtT188y+cmx1ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rmyJqMIi94Cy+MIdEg5c8d5qY/watLamqP1Gi3zgyb4cb8cpG6CfKxCrCJrqCYAJR
	 TFInqyrBod1wLEn4T0ACCl5BB6VCgT2/nE2mhnOPIatRPiEAAzCB1KEEa54DsJzkTe
	 71yXt86tx39j/Es4S6hEhnZq8nH6q9706xjVWn+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFTPmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:42:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50506 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6s6aZu8b9dqDAqPoq81Bk78Hj/YlZ9Zu2gddBiQR0jA=; b=jov01KPU7Ey0HCtDvL/bMfUvM
        q+kHss2+okCgunU54lbz7AUEXxS2cz7t6hVp3TCiDXLIBSddCYMcK66KsNAYrByHqXzLdYmj5E8ms
        s98+kDkEwIFNMnhf/WgI7uAcAm8nRSMA5EA0gm8aA9dNtYxJ/3JhRSD6SoNS961M86AwU=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdzCB-0000qH-N9; Thu, 20 Jun 2019 15:41:51 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id AF546440046; Thu, 20 Jun 2019 16:41:50 +0100 (BST)
Date:   Thu, 20 Jun 2019 16:41:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Xing Zheng <zhengxing@rock-chips.com>,
        Benson Leung <bleung@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz
 sample rates
Message-ID: <20190620154150.GE5316@sirena.org.uk>
References: <20190620134708.28311-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rOnZ5ITIX7GHaQD9"
Content-Disposition: inline
In-Reply-To: <20190620134708.28311-1-enric.balletbo@collabora.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rOnZ5ITIX7GHaQD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2019 at 03:47:08PM +0200, Enric Balletbo i Serra wrote:
> According to the datasheet the max98357a also supports 32, 44.1 and
> 88.2 kHz sample rate. This support was also introduced recently by
> commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").
> This patch adds support for these rates also for the machine driver so
> we get rid of the errors like the below and we are able to play files
> using these sample rates.

Does the machine actually need to validate this at all?  The component
drivers can all apply whatever constraints are needed and do their own
validation, the machine driver is just getting in the way here.

--rOnZ5ITIX7GHaQD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0LqT0ACgkQJNaLcl1U
h9Aomwf+IWYRVucBBZvhsm/gdBVe/B8CpBjmp/2qlcOTbdBRiwV3TGlwjFiWqyNF
a/7criDs2zMUCDb4Ad2Xh7FoRj24dC+1QikkP64iwyN/Y5wJLwQhRRDuM60vjRGp
waQP/rQ86h14cWtTi/+IE8Rm3nFcs/0J0S+87SVuW8kIifVcEAzUGYH8fhTwgkki
SerVWbkR+weSZLJVq/cvR2CKQvt4qPaQ2AT2V7W9pCRzBJRza8CLIg+t7jaFUuLP
EefouE+9/aOgtVf4NT+BPfcy7pptkMZwAsbX0Obcm6+1dmIpjffWRdRzki4AVnJD
wUUi0N6O0HWIkSLhMnqzgBaOrZBMjg==
=cr78
-----END PGP SIGNATURE-----

--rOnZ5ITIX7GHaQD9--
