Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA20BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1699208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561548237;
	bh=7ietyuIcaBatOPYfddSSylJ4sxAZ+ZLKOiAKxLzp6es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y6WO/tXEiTKPowkLyQ01UW/VRub1blsP6aZrnRTGugoRKT8k0mBY4HF85RpPOMKz8
	 VsjiqKyeSWU/n9NoGKNpf0ndjs3iWNK3tqWTGNmPF8o8F6mx5HOkKTrLJQlpADe8ka
	 NpffI/R2wLPRiSXs1+JYQxaKugrYEM9XhGL42fR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfFZLX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:23:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38082 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ietyuIcaBatOPYfddSSylJ4sxAZ+ZLKOiAKxLzp6es=; b=F05n5gh9dgVKij6KvK7Jni2sH
        EpeOadTX2njYnxIy/4tL586k+XHd3PAuDNzyWFoNrkPfQvszMo0pMX+orsIoIjRWPWlE/GXoEMRms
        keb34VYGi2rDr7DuZVl17wH4XqywWKeNJooQcH8gstxaCL4pTEz6TqN/a/JIGYp8xZWUI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg61U-0007me-6n; Wed, 26 Jun 2019 11:23:32 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B4DFD440046; Wed, 26 Jun 2019 12:23:31 +0100 (BST)
Date:   Wed, 26 Jun 2019 12:23:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Subject: Re: [PATCH 2/2] ASoC: codecs: ad193x: Reset DAC Control 1 register
 at probe
Message-ID: <20190626112331.GB5316@sirena.org.uk>
References: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
 <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0LPhsWsL1Ga+XLL0"
Content-Disposition: inline
In-Reply-To: <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0LPhsWsL1Ga+XLL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2019 at 01:49:47PM +0300, Codrin Ciubotariu wrote:
> Since the ad193x codecs have no software reset, we have to reinitialize the
> registers after a hardware reset. For example, if we change the
> device-tree between these resets, changing the audio format of the DAI link
> from DSP_A with 8 TDM channels to I2S 2 channels, DAC Control 1 register
> will remain configured for 8 channels. This patch resets this register at
> probe to its default value.

Would it not be more robust/complete to have a set of register defaults
and write the whole lot out rather than individually going through and
adding writes for specific registers as needed?

--0LPhsWsL1Ga+XLL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0TVbIACgkQJNaLcl1U
h9B5dQf/cxYmztEqqJW7n7EhRXlsxlPo8LHdNVs1D7b4aSBNJZTPs4ydlpRlCQga
MQ7cYmznzzNCJSNwIBi/ra/arsQWHoyM1gHaQH01vhjaEoMYgm3Tbtn2IDR16tR4
sU1ffhFgQmve2BD6q5fRVYdZldcvJuBkY8fnYO5BktFrQXil/YiQXudVjAiP0/tW
tZMoigVLniRxERF9FwQ5XWzVeW8Pa6/tSZ1xAs+MyXNdvXa9jrL1Wrwze6S/i12U
yT0QVxnVBhOBZfgH1bGHO8V3Al2lAn6P1n9uHfvl63HeZgnPp6qfScLVkXLzCpO1
hb2duf3THhcgLRM+qZA88qsgyyRW4w==
=ZAHw
-----END PGP SIGNATURE-----

--0LPhsWsL1Ga+XLL0--
