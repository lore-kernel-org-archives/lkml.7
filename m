Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9620866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560449750;
	bh=R8ZH7G6D0LJn3GZl0Oagv2+fhA5zSqalKo6kDepjQvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kzzRGPPYjJHYGrV0TSrkLMhHOw6Dtvt/Ag3kZ+3kvZu9vPXQz3CMhK/HqEghgjyNZ
	 bFFlkffhrJuMTHSt7IV0eHxJD4Hb3Zo/6wKEGIqEuSKUMX43oprQi/rXqo8EX+UGqm
	 ejA0hv9DcA3xpPFAPI9VP43Id+OMT2TuEmO7Wyq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfFMSPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:15:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37318 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFMSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=urMa43C+0jgItqUyKJ9OgJ7uvJ3NBZiThEq7mP6kNFo=; b=fS9qeQP9mDtbwyTQps7xsg8TY
        Xi5vuZ820jGy9LW6yXfnIKJ/QIfObCgPNLzwy7yiszNFR1GrkwXIe5coL5ZTRb2Dv5FR4SAJVJnHs
        eYtFB45+9apT1zy91xxZCBO99lRTwGbLggEPjQuISbkZ1S0RKNZw1/ohoFLPwPqzqvLc0=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbUFI-0005Ms-0T; Thu, 13 Jun 2019 18:14:44 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6007A440046; Thu, 13 Jun 2019 19:14:43 +0100 (BST)
Date:   Thu, 13 Jun 2019 19:14:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ASoC: tda7802: Add enable device attribute
Message-ID: <20190613181443.GQ5316@sirena.org.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
 <20190611174909.12162-4-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uRjmd8ppyyws0Tml"
Content-Disposition: inline
In-Reply-To: <20190611174909.12162-4-thomas.preston@codethink.co.uk>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uRjmd8ppyyws0Tml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2019 at 06:49:08PM +0100, Thomas Preston wrote:
> Add a device attribute to control the enable regulator. Write 1 to
> enable, 0 to disable (ref-count minus one), or -1 to force disable the
> physical pin.

> To disable a set of amplifiers wired to the same enable gpio, each
> device must be disabled. For example:

> 	echo 0 > /sys/devices/.../device:00/enable
> 	echo 0 > /sys/devices/.../device:01/enable

This is adding a new ABI completely outstide the standard ALSA and power
management frameworks and ABIs with no explanation as to why or
integration with the rest of the driver.  This is obviously not in the
slightest bit OK.  If there's something missing from the frameworks
extend the frameworks, don't just ignore them.

--uRjmd8ppyyws0Tml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CkpIACgkQJNaLcl1U
h9BS2Qf/eUVj90LcvztgsSKTKJesxl0D3bt7RMK299c2vYLHkirE0vtrBBYdi4Pl
FJ8puURfuyztbRnoMYrmvkGzoB+kCtwXLSxo2i1Mi6NSlQfnwwg0aoE9RHuB0oOD
/2hT/ekihe5UadF/JGir89imbhQob5EDyVVzjEgyWULQ4ITpkAw8wiaIcF3GNrjY
yFLb/wBrR+BM4SXfJKc+SmWy+xt1btn93sWuiaU7SMS86bIEbT1h0w4vQ1p3v2+/
qjopN+wN8BrUnWRHi7xBR4eocG6hGN9+z6/Xkhr2XL8E0tyaDly5TMDZomOPYAif
beljIAen1oDtCE4MOp25DYHPAJUmzg==
=ioNi
-----END PGP SIGNATURE-----

--uRjmd8ppyyws0Tml--
