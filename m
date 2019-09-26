Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F503C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E343C206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569521763;
	bh=w+YEycUJKm/sV8nYfQ8uCbJ8b4eRgt70ohlZ1OsaIKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tx9cqEMF/jc2MfcYumg53TTKtlltbsvlaNVqC7tp1pheVWeTuDK++nDW9p7cXHw7k
	 wFyaOebJbeAB1t3cX1X235/1ctc/ShD0kHSTlfeOxq8sJRiayDQVcuyUiCNnU5NKGp
	 nBvXO+Rh/2bS1vHxwAurhO4Sa3Gze2Ak41TDg1ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfIZSQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:16:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36764 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfIZSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mn8IPYK5fTq/nd7bMLIu9R0D58yWiLZOfaLo4U/dC2k=; b=LCzUDgZIId8seDiOSjLAOjdUO
        Zka4JJZRaFdcdEA1XhJjFpSJeg8i8XRjmTYew9A5h5wsEuxK2l+se/3fuiu9lOigRx0Y2ktXUWP2G
        QBABWxwcoAsnDyxaJ+lOwPrdkC+Zu2snNnSUHkiXIpcKr/0W7wKWTk3SY802MioAB3Grw=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDYIm-0004PZ-4W; Thu, 26 Sep 2019 18:15:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 86B0BD02DD8; Thu, 26 Sep 2019 19:15:38 +0100 (BST)
Date:   Thu, 26 Sep 2019 11:15:38 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] ASoC: amd: Enabling two I2S instances
Message-ID: <20190926181538.GC2036@sirena.org.uk>
References: <1569539290-756-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569539290-756-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8H5+QmNTcR9iGQhm"
Content-Disposition: inline
In-Reply-To: <1569539290-756-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8H5+QmNTcR9iGQhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 04:37:37AM +0530, Ravulapati Vishnu vardhan rao wro=
te:
> RAVEN has multiple I2S instances:BT and SP.But only BT is enabled.
> Now I2S SP instance also gets enabled with this patch.

This is extremely difficult to review as is, the patch is very
large and the description very brief so it's hard to tell exactly
what issues there are that must be fixed to enable multiple I2S
interfaces.  My suggestion would be that this should be split
into a number of smaller patches, each making one logical change
with a clear description of what that specific change is.

A few specific comments below but really I didn't get very far
into the code due to the difficulty figuring out what's going on:

> @@ -46,10 +28,10 @@ static int acp3x_i2s_set_fmt(struct snd_soc_dai *cpu_=
dai, unsigned int fmt)
> =20
>  	case SND_SOC_DAIFMT_I2S:
>  		adata->tdm_mode =3D false;
> -		break;
> +	break;
>  	case SND_SOC_DAIFMT_DSP_A:
> -			adata->tdm_mode =3D true;
> -			break;
> +		adata->tdm_mode =3D true;
> +	break;
>  	default:
>  		return -EINVAL;
>  	}

For example this is a pure formatting change (one that moves
things away from the normal Linux coding style) and clearly not
related to the changelog.

> @@ -87,9 +69,16 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *=
cpu_dai, u32 tx_mask,
>  	val =3D rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
>  	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_IRER);
> =20
> +	val =3D rv_readl(adata->acp3x_base + mmACP_I2STDM_ITER);
> +	rv_writel((val | 0x2), adata->acp3x_base + mmACP_I2STDM_ITER);
> +	val =3D rv_readl(adata->acp3x_base + mmACP_I2STDM_IRER);
> +	rv_writel((val | 0x2), adata->acp3x_base + mmACP_I2STDM_IRER);
> +
>  	val =3D (FRM_LEN | (slots << 15) | (slot_len << 18));
>  	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_TXFRMT);
>  	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_RXFRMT);
> +	rv_writel(val, adata->acp3x_base + mmACP_I2STDM_TXFRMT);
> +	rv_writel(val, adata->acp3x_base + mmACP_I2STDM_RXFRMT);
> =20
>  	adata->tdm_fmt =3D val;
>  	return 0;

Won't this configure all the interfaces identically?

--8H5+QmNTcR9iGQhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2NAEkACgkQJNaLcl1U
h9A/nQf/aCxpiLEUD1Kxl47cIVbozOcJU4QYNdUFGgPrUnoYCKI013RSszByaTzt
50c9wKCPY+rsQwVa0Vn9v7LiCDiq50OuEcmknCIFhKqtersy52YJLJB7pu9XNkTD
rfTJiMEIEgaFaa90HAtACaBEvtw9y8K9jqdiOvffmNJUWeMassdjR8GHEJ63U6aJ
OHjcOF3U2jQ49F04lt7EEioY7UNso5Ru4WbYlF4WPvDnZjzzReW9zWiXL0dhitHy
Iw478TOWlDmWbbOcLkzJi8EIqhfshzKxBOmU3JX649T+XghFqhI0s+9ZwWgzSIMF
bw5dMN3uhrrF0ExH7SRRoZPg2T3arg==
=Y62R
-----END PGP SIGNATURE-----

--8H5+QmNTcR9iGQhm--
