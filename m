Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADBAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3782184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555578410;
	bh=3HIKo4TJ7arFeFGllVQWH4Zy1kee7tJAEJfaQEc9lqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aKjRZa9BXsn+raYp++DFOkxdGtQ/H1SQCUOT6Ah+i7kjiUR+NsOcClj2XD+g1IRmY
	 krrv1RWUSkoDGF9NqnGYVMpN68xFxX9ykhIfj7IyqisvNJQPyOymW/j1VYRmII35EU
	 5/sE/K/VG4Xh6lA4PPnOBG2tnRWnmdY15bwSspjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfDRJGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:06:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3HIKo4TJ7arFeFGllVQWH4Zy1kee7tJAEJfaQEc9lqA=; b=t25R1zLCLQQLYZao47Wzvqc6P
        9q+MdBj3J0gRPa4hYzj6fh09E//7i+IuahGCg877ktcKJUsHvaLIlto3y3MpO9JwN7GIKj6aDi5AZ
        ZeT8syzGoVxzVX8FMWJkB9pmaOly+/cGtUTQUvy+8Kaoh9tst9dNq0VKefPpw6kyS3tLU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH30B-00013G-Es; Thu, 18 Apr 2019 09:06:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 63DC11126DA9; Thu, 18 Apr 2019 10:06:38 +0100 (BST)
Date:   Thu, 18 Apr 2019 10:06:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418090638.GA6702@sirena.org.uk>
References: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
 <20190418090011.GA4028@Asurada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190418090011.GA4028@Asurada>
X-Cookie: A watched clock never boils.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:

> > In imx8 when systerm enter suspend state, the power of subsystem will
> > be off, the clock enable state will be lost and register configuration

> Just for curiosity, we had similar situation on imx6sx, so we
> added suspend/resume with regcache. Why will the clock enable
> state be lost too? Does CCM on imx8 (might not be called CCM
> though) have any difference? What about clock rate settings?

That sounds like a bug somewhere else - I'd expect that after resume the
clocking would be restored to the state it was in before suspend.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4PhsACgkQJNaLcl1U
h9D0+Qf/Qb3ZB7++N4KWIotelaGoJliU91cFGeVtbV14n7Hb9xPZ3PzNlZBY9iYN
zhzzBdDCqWV5btb21LZ8lCcFicsKQTJieKm6Ufjrnr7SJ/9pjoOuV4JnDZ6aFucA
1krwDMkcK/ZD4Dj+favuOXRQUQ892A1Km2dp1ihRlQTIVIRyubA/7F3PQdr8ZjQl
8sLhALAl7K5u5ylLUX9SItPTJSQeVxb7V+JaHCrmVpsYP1oSu3I77DHvHPKLNK7p
JJe0CvyDco+KWEJ4VXnZVt/hkEyT8tvhlmAX37A+NxYxjyXdHQZYVNOn83FuWPo7
f2Krw/3Jy9Th/DZfw4A0/wLL+dMzDA==
=OW6D
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
