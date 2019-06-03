Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C81C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74A22475D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559575664;
	bh=6BbxqDitWM9alxT1tuEKV3wxqoqNVenlh/LEgLLZtTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S6/a22QjovZIk1RIdi8vNb6xpVH0VEJxPdiqi6TmP+k8ZW4pt14a17PPdGpG6XQRw
	 Ed9480hlyTM+Lqxax/qe/nlUMaQKEWgmabq211DXMDV/3DHeqm5GWiz7ZgYZV/X9vu
	 lldjQfdRXzRZAK6FFnVfzoruoevkEWrGH3grR1kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfFCP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:27:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfFCP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iEWFECNWEoRXHdke6havOY+8o53ZmeWbffO16u0RrZA=; b=xfE05/kilw0Y6BZLHtPD9FVK6
        62ltCKphRfOyqNZePrg/XtYAowVIxrQ+G7gM5apeB/BvedYY4mVGEZgMkI3ZgJm2kV10K0W/sDnyM
        Y6u2mIcR5iwBdSChCjobF2zBCFwdiWitghbQKKzgnYr2i9zC/aHTU7IDUR0beb8dhBYAs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXorw-0002EH-9r; Mon, 03 Jun 2019 15:27:28 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6B345440046; Mon,  3 Jun 2019 16:27:27 +0100 (BST)
Date:   Mon, 3 Jun 2019 16:27:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2] Revert "ASoC: core: use component driver name as
 component name"
Message-ID: <20190603152727.GU2456@sirena.org.uk>
References: <1559298842-15059-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9pXJW6w71JX4l3T"
Content-Disposition: inline
In-Reply-To: <1559298842-15059-1-git-send-email-krzk@kernel.org>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9pXJW6w71JX4l3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2019 at 12:34:02PM +0200, Krzysztof Kozlowski wrote:
> Using component driver as a name is not unique and it breaks audio in
> certain configurations, e.g. Hardkernel Odroid XU3 board where following
> components are registered:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--s9pXJW6w71JX4l3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1PFwACgkQJNaLcl1U
h9DFewf+Nrpc5dIbkdtpXJkd+/r3A72X4Qa3bSaqMe32ihQnjGEheNTX/QRKVJRI
2CPV6hCZ21/kjRHjjPZh7wnz3/2ICFPbVFT0oqw7ODSgYB9mbKfJG22awJVr1xtY
jncb8BwIddJhKu2wmP0kFqvZZ4bUhspqeQ5pStUhlrkpy2Vgk3KCzvhDcOaDaMv1
1/+eGxpQfFQyHD6MFK+ilSePDl9ZYm+tnzjtAP7ztdjJaRQRiRhwHTUEHUf+ViAL
Gd789UwaU9no7R0/MxgHHWB/0+qd/JTp91XzVCTJBFu7dlwoLynN4kVAIVrvUDTl
mhhtur3Rm0khwJ2jfqvuVqv8Rwq5ag==
=vsht
-----END PGP SIGNATURE-----

--s9pXJW6w71JX4l3T--
