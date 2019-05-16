Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558006086;
	bh=75f0Tpj7vgIVS2lmg4rUnHFw3SDykPWg4zcVeoyyIm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bBUEHi/dNDnB3vqBiCcjSqbdyyaAFOPH389UwJWpXr/v21A08qZPyNBnfnZca1zU5
	 BbY6S0/KgUGyRGfjOJl6AscP2GmiImq3J9IYflGbH2Rulz2cylbpz/u4GFR0J/qO50
	 2UvKISp/xzndXSHRQ4QKe/ng5kg1+boT22EEPoBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEPL2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:28:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dVusMfbG2Jo9MmKeoL96YpYZkVmGycIsx1/10iU5uWo=; b=qexgUKy5sGtN8oiEm4LVB7Jr9
        cp3losBfgrHOsuKMRclDApQNtL9uPiwculKW65Ux2uytkmOrJ3yoTHyAqhD/UmeM0KiIBzasZAt5C
        48Lm7/azfg/vfCVeKrM4mAc6SJIaPgiyEqZtrgiPJaOFOUfXmeBoCj+RG7juhCByi5yZ4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREYC-00068n-TM; Thu, 16 May 2019 11:27:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 457491126D45; Thu, 16 May 2019 12:27:48 +0100 (BST)
Date:   Thu, 16 May 2019 12:27:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V3] ASoC: cs42xx8: add reset-gpio in binding
 document
Message-ID: <20190516112748.GF5598@sirena.org.uk>
References: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 11:24:12AM +0000, S.j. Wang wrote:

> +Optional properties:
> +
> +  - reset-gpio : a GPIO spec to define which pin is connected to the chip's
> +    !RESET pin

gpio properties are supposed to be called -gpios even if there's a
single GPIO possible due to DT rules.  The code will accept plain -gpio
but the documentation should say gpios.

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdSTMACgkQJNaLcl1U
h9AI0wf9H/v9XOHLGG0s1+nmST8FhMRdMALRocSMlNs0hntuI+4uxBG9/dXi2ST1
Id5glMJZn5CDpvgp/RUiuTWBAwfejMgpbwxxLtDbrmdqBolGsO0bpnWoEiZTpOop
gVBPRVGueduh/5HWKPbCn9PRfHuyUKq/0uenLwDGEy9VN4dXP6926tOFzTAIewI2
BoFx+Chib3VXyep6aG6PuFzTPPLo4XeXckbROsUj5WNaOIP46A4E9e7nK3aRqd6M
YpPyJN7v/H7BesUV3v9DLZQLcaSCYGxLvfwl07Dz+zI0a3hRQ5eXohzPxWewfqXh
A6lcsDuR+5dafko56EbffC3HlkMhoA==
=692j
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
