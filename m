Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC29CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5281420679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571917253;
	bh=4btlfmpiJWxkiomXjtDznq8yoGMHmLTUUggXIjDkJgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zjT/ftyPmWP5inL148JnQLKNmsuUvtCcaQC1RylSRanG7rigZ/ch7TXYuLETx0vnw
	 moS7zfxvJM1pVn4xBCdvhUKOdUFNDJs3c9rCLjRHZSZWXgZYwooOhyf4kiK9S4wVMU
	 iscVJKy4b1CwZ/KlgR29nMzqi/DTqI2hKC3N4ScY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439036AbfJXLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:40:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438710AbfJXLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X3j9UrH+/Fzfrt4StiXNQ+AaG04IVrkqPFPRYShjJH4=; b=OijjdxG5DT0DclHIlyYtSOjt9
        QKdLW86wpsJkyhSha1lDzuwcYivt7PvCkdZX9pi4Q7Byvs5+Kqeb3SPxkP2rPwLA4qcU/l9usNBRc
        YrsHsThy+YglGy1Xh/JSyUSZ20k+pK7cPajhMVLb/u3A5i6RWdPBsgdq+S9c0jSRvzQE8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNbTU-0003Ph-7k; Thu, 24 Oct 2019 11:40:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 700B5274293C; Thu, 24 Oct 2019 12:40:15 +0100 (BST)
Date:   Thu, 24 Oct 2019 12:40:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] ASoC: amd: Enabling I2S instance in DMA and DAI
Message-ID: <20191024114015.GG5207@sirena.co.uk>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <1571432760-3008-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2019 at 02:35:41AM +0530, Ravulapati Vishnu vardhan rao wrote:

> +		case I2S_BT_INSTANCE:
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> +			val = val | (rtd->xfer_resolution  << 3);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +		break;

For some reason the break; isn't indented with the rest of the block.
I'm fairly sure I've mentioned this before...

> +		case I2S_SP_INSTANCE:
> +		default:
> +			val = rv_readl(rtd->acp3x_base + mmACP_I2STDM_ITER);
> +			val = val | (rtd->xfer_resolution  << 3);
> +			rv_writel(val, rtd->acp3x_base + mmACP_I2STDM_ITER);
> +		}

Missing break; here - again it's normal kernel coding style to include
it.

> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
> +	struct snd_soc_card *card = prtd->card;
> +	struct acp3x_platform_info *pinfo = snd_soc_card_get_drvdata(card);
> +
> +	if (pinfo) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			rtd->i2s_instance = pinfo->play_i2s_instance;
> +		else
> +			rtd->i2s_instance = pinfo->cap_i2s_instance;
> +	}

Looks like you need an error handling case here if pinfo is missing,
i2s_instance needs to be set.  There are default cases but it's not
clear that that's a good idea, the intent of the code is clearly that
there's always platform data.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xjZ4ACgkQJNaLcl1U
h9BhrAf/Txqck6/DbNHSTK8lPyCZ9s2RTKplJJicUfk0nuoJtCepGTPnONQjxLm5
4zppLX7vtUzP9GVvTBzR5acgF79LIEOtevrY2H/3fAJ4W93HsshpLQtDs45ksPrE
HBiiXl16hX9WNRf1s17LizgPUw+izaQsAhDf8JuBWcKRfhRL9M8/oxe4ZgE3wooK
SLE7e74+roHIWQ9hhb7eJy4IQSquVSb3dYFpHruwQVJxN20uKypEPzeVxO2EYAK4
e9GBmKw8rXzlsVME8M57mIQ4RgO3J/hOvmv2Rtpa+lJ26H5qpQqxcLuCpCZ5KR+C
+2yTqhWbMBMHjpfQtibSEyJFfe8YTw==
=8jUs
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
