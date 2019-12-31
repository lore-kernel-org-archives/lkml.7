Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43213C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EC6206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577751457;
	bh=/1kIBLHWq+f/VWD+eJhmzw9yaHG84UVZ1rPWecWotyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YfkqygkLyLKEv4mFz/0AIZLZcZ3LA0QVDoyzoFkH7U4dddaEEpQB5+O0k/37+gF8J
	 +69LZAiNbklZ7l5uCZu3W9A51O2hwEIe1RPfSjoUnKou1SdUQ6AVl2T1cW+zoGtmMu
	 ooul17ubI/U++MrieegM1YHm0lU7Av5eEvgeSXog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfLaARe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:17:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52258 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfLaARe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RbisTe+iB3aSugYpvz9elCfJ1m1jElfgrG8cOw7p7uQ=; b=heqQ65uOQruVqrBdkas8NwERq
        5jwYd62w0bDd1Y1a7yJo/gb2KHpaIM9PH/PVC1PuxdBGVSRIJkIl4cwMPE/w9Dit0UvGWrQla0Iv7
        cp7KLYK78VdkcUZeUHjC3w3EQGXDiZEBUnOpONHruGyQnElwaRVey/yPLQuPS7xTt9xc8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1im5Ds-0002iq-71; Tue, 31 Dec 2019 00:17:20 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8BCC4D01A22; Tue, 31 Dec 2019 00:17:19 +0000 (GMT)
Date:   Tue, 31 Dec 2019 00:17:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: rt5640: Fix NULL dereference on module unload
Message-ID: <20191231001719.GC3897@sirena.org.uk>
References: <20191229150454.2127-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20191229150454.2127-1-digetx@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2019 at 06:04:54PM +0300, Dmitry Osipenko wrote:
> The rt5640->jack is NULL if jack is already disabled at the time of
> driver's module unloading.
>=20
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
0024
>  ...
>  (rt5640_set_jack [snd_soc_rt5640]) from [<bf86f7ed>] (snd_soc_component_=
set_jack+0x11/0x1c [snd_soc_core])
>  (snd_soc_component_set_jack [snd_soc_core]) from [<bf8675cf>] (soc_remov=
e_component+0x1b/0x54 [snd_soc_core])
>  (soc_remove_component [snd_soc_core]) from [<bf868859>] (soc_cleanup_car=
d_resources+0xad/0x1cc [snd_soc_core])

In addition to what Takashi said:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4Kk44ACgkQJNaLcl1U
h9B0vAf+Jesim6R6yU2diF32zHcRsUbMmsppI6c2j5Th/D8i5h+fRxjvXEvVkuGI
XjQkntGRuppBqIv7EcVt19JhOaO2S2+dCWskZY9G1C2t0k/i4FaGv20iVr+Zd1qI
po2/Sv/mjruuFZqpx8ZVGdGVwrdCB8EnANT6k62eFFGb+bvrE9k6xh4db9CyYBKH
EO+NXjIDf/115a4XcHEfWGe3627k8rlw5llArmHyp+kTo2jq5jbCVcUxsXGTsz7W
QyGsYgljmuJ7OVMZv2lpHa4Wxl1hdCobWS8TCrjK5gMFmlWZypw1zOh5Z9lkEVcl
nm/taB4a/p7GEMWOa+AJevErYZjl2w==
=D3/K
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
