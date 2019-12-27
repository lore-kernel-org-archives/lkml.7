Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5042BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D7620740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577408848;
	bh=C6uqv3n6xouQOgZTOjhS0LjqoNmIDYF5KwS2ioU6ARY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZyI6hmylhTHGVD2o+9rPQ6Rbd+NeYlDbQCeX1GJgYY1sTpYNyz69EYH/U0GzbXU8g
	 mNU4Q5dcilAzcBdGy8M3XXbJ7hjSrR42s/m6kX7Kp2zwD5OK1ayW58c8N5TqzuwbwX
	 NpRahhHu2snY9e3VXqseKNXTS+g0iCsPN0jWJv5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfL0BH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:07:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57218 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0BH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C6uqv3n6xouQOgZTOjhS0LjqoNmIDYF5KwS2ioU6ARY=; b=HpW7TGec6HMWofJqvOYl3go7F
        PPRQFn1JYJINXbp7Uz9UxjR3Rlxj0YTv6KYf0cU7UiFbtMhrhe2E5+ZcWWcyl1zgZRxxlfaGovcPY
        eMa0U9m3JBEsHsb9nX5BLjWjOEv6MFsJQ17V9u2ylQRx861l+f5qoO1+eqRnQlhpeJoqc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ike5m-00049F-BN; Fri, 27 Dec 2019 01:07:02 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B8BD3D01A22; Fri, 27 Dec 2019 01:07:01 +0000 (GMT)
Date:   Fri, 27 Dec 2019 01:07:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        pierre-louis.bossart@linux.intel.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v14 2/7] ASoC: amd: Refactoring of DAI from DMA driver
Message-ID: <20191227010701.GK27497@sirena.org.uk>
References: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1575553053-18344-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline
In-Reply-To: <1575553053-18344-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2019 at 07:07:27PM +0530, Ravulapati Vishnu vardhan rao wrote:
> ASoC: PCM DMA driver should only have dma ops.
> So Removed all DAI related functionality.Refactoring
> the PCM DMA diver code.Added new file containing only DAI ops

This doesn't apply against current code, please check and resend.

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FWTQACgkQJNaLcl1U
h9C6Qgf/YaesCjRBOBWjivS9T9BLZkRe0qF/Ot4xyMlnIT8zYH/XQOQWfdZhzmGO
wB/fxqKJRXnbupS3ynhCzNHGbl9Uhj+AuFy9Fb8vFYbVwRuHYckTxBRI2ohK6OA9
/0KDeoGqC7nKKzlYY+R6Z2cBzxNACiVjYPtR/MIrXmjS4GAZ8Lbgdx3pVvA1HDmS
36fr79im8RG4QFlmeIVUl/ZH+9hOoBa3IcxGPA4Qtie/+KJ1j/0gxwUd5wCWnx1E
i9rLojdohEqrM1nvw8oy9QZ35qgkylMPClguzkSPmH2xslXaJgKfaTUd7L+ia07N
sPJt+6bI3gDjJdifhjKOuwUtZ7FiVg==
=mUn1
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--
