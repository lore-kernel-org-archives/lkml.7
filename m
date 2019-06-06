Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BDC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0E207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559822093;
	bh=rAZHQ3bVHGDjoCQmg1fzNfF0bwBDvIVyWJnP6+9GpFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GtxHevQ+NtKI41zyCxoEjoU4TJgRhGbIx/YjZBwcDM178jff3VqlwCjzzbxki5M/q
	 ekgv5Il29aoDXlYC5+y3wD1Wfi8Jg7vr+1kqsga0gjXIL1KS0EfhEfNOznZA9Ypuu8
	 h+jPznC0rWa00GzQmMYlJF5nr5pT+IKDDhaNVSDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFFLyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:54:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gTBkVmHAheLzIjg20ZEgj9XJEkLrz4Bi4GDSG+PTTSU=; b=Z1ghBiSsZHjuzORBJfhzyx5pw
        fw272Vt1FcBSp1I6+Hg2sQewRs2GqIic+xjaUhu8i9diVc6DcVwyu8RJFvdQx8YThumh2ui/ZrN1q
        RlWlWN7WZCIEDMknmFSkEO1xRraTFLSbgjTuXQplqBuJVYB3VhOrZiKUv+eJlJTBvyr00=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYqyh-0005ST-2g; Thu, 06 Jun 2019 11:54:43 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 44A95440046; Thu,  6 Jun 2019 12:54:42 +0100 (BST)
Date:   Thu, 6 Jun 2019 12:54:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Add sidetone support
Message-ID: <20190606115441.GB2456@sirena.org.uk>
References: <20190606114002.17251-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Ox1BgGQfTDeiDFL"
Content-Disposition: inline
In-Reply-To: <20190606114002.17251-1-srinivas.kandagatla@linaro.org>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Ox1BgGQfTDeiDFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 12:40:02PM +0100, Srinivas Kandagatla wrote:

> +	default:
> +		pr_err("%s: event = %d not expected\n", __func__, event);
> +	}

dev_err() please (and a break; as well, it isn't strictly needed but
stops people having to check that it isn't needed).

> +	SOC_SINGLE_EXT("IIR1 Enable Band1", IIR1, BAND1, 1, 0,
> +	msm8x16_wcd_get_iir_enable_audio_mixer,
> +	msm8x16_wcd_put_iir_enable_audio_mixer),

The indentation here is *really* messed up.  What are these controls,
with names like "Enable" they sound like on/off controls in which case
they should be standard Switch controls.

--9Ox1BgGQfTDeiDFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4/wEACgkQJNaLcl1U
h9CHXgf9ELgAnvcZKwTjonidDRb4OSre9kePfh4H+mFw7tR6ZR9tmBAT2jbsVbGZ
WvScbpmCOfn++MhbvUy/EPYBm2WKdhiVRzT7K4m40Z/FJI3ZsZcKmR6WXaQnml9u
xkTXA6na7ohZkJ4lpkmN1GMo/3pE0XjQudzjSEUBlY3/ZbLhEf1uOke3Fphilxb7
y2QF6JumJj9Zb1SBYIy30NV738gGDGmQY4A4Dtj1nm1Z4beiB079IxOXTRCoZ15+
fzJ61eL4qFymDuuJ0NTNsvos01adD0vGWVLhR+ngBDILwNatpwJ0gP+gK7XhxKWQ
9JDBbNRSzsgduDJnCk4IIC+A38m0HA==
=3Tnd
-----END PGP SIGNATURE-----

--9Ox1BgGQfTDeiDFL--
