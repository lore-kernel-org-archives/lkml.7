Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A676EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FF206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564602451;
	bh=zyW4MZRLWEdm/kkgcwH9mztWXHjI6/G5ionKp0YHWpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2fjpAJ9jVKRtjuybg9IiaXuqUgPF8yrGG4jQAVMLd9t4NqQBvDMvrxNud9nY83pXo
	 aqASZFRFnlAi3W/S0baWIsFteMOAthpDn3m73qbM3l55Dv6YWK0Mp51K4morIlTCfQ
	 QvgwyWXH/h5TQaKUY+dB9pcNxI2WvGlvZ7yf2x14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfGaTra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:47:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGaTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ywgvJpds6ShwwZJqZzq8qZN2L9l/gFjUWXQjVg0+xMg=; b=Tat7484s4Is7coC0Akt9WpQYv
        eph3Y1ifwxs/7zgbZ1s1+ipensPo32nHGqAzn49uWE9ySs2ZQ0Bodyj007DRKc+VhnC79WoFIjFd/
        cnL2B4HCDdPPdAUfC7qMK0ZnAewHySBtpC0dY/5KyRi/+sTWk92q0NRTlxLBAPQ/o1NvM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsuZF-0003D3-8g; Wed, 31 Jul 2019 19:47:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6F8D62742C99; Wed, 31 Jul 2019 20:47:20 +0100 (BST)
Date:   Wed, 31 Jul 2019 20:47:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ASoC : amd: reduced period size
Message-ID: <20190731194720.GH4369@sirena.org.uk>
References: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1564402115-5043-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <1564402115-5043-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: FEELINGS are cascading over me!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 05:38:31PM +0530, Ravulapati Vishnu vardhan rao wrote:
> Reduced period size and offsets.

Why?

>  #define PLAYBACK_MAX_NUM_PERIODS    8
> -#define PLAYBACK_MAX_PERIOD_SIZE    16384
> -#define PLAYBACK_MIN_PERIOD_SIZE    4096
> +#define PLAYBACK_MAX_PERIOD_SIZE    8192
> +#define PLAYBACK_MIN_PERIOD_SIZE    1024

Is there a need to also reduce the maximum, the hardware culd support it
before?

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B8EcACgkQJNaLcl1U
h9C6BQf+Oo4ryGKqExrjlr4uVgeaAMIHXAeGfJG+wmHgD6YbMabBcib7q7imVqKk
1npEyRS6jlWFO9jRTVUGfMHhAP51/E/1oNmJB9YllLPq4cuViQUH7ztud3pcN04z
zQ8hm1OtH9YmBfIoABFxYgFd6DI+hn/OdEX4dN4Unv0ppvTQZ0NTCd0Ikok+061U
CacojaF/Z/mrjZir7lXvFuxC9PrG+4/C6FakQC9ApRbewYjxybg+KkG2AuN7CeUK
ZP9ZrbEpe6668ZDm/cpSI4axkP+FCVTKorW6M19AoMbcOWCdCL90D5hhO+1pgv50
CT55tq9iGxYm7D9cLBE0glLW+Ymd0g==
=JOkR
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
