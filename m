Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96CE2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574943821;
	bh=p5M2FYS9l32ApOb5aEF4vOH3RZYCM+Qot1lhnsAQQOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K/+PE428SbxuNq11z+UBBHAUH6x4WXQOWNVoNMatwfLbxV+avMrQ84s7eIZ/T2g4f
	 8M0RlBGWwpqORq7tuq6IDUyhASjRSNdjQojkZQoHP/8MPf0jmIX0wmx5kdlZ6n6Q8U
	 jn/vffveMW4lsPfYlsSW+2Yyt3tgoRg/imAQpwsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfK1MXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:23:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK1MXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:23:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E309A31B;
        Thu, 28 Nov 2019 04:23:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6186B3F6C4;
        Thu, 28 Nov 2019 04:23:39 -0800 (PST)
Date:   Thu, 28 Nov 2019 12:23:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Andrew F. Davis" <afd@ti.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add HP output driver pop reduction
 controls
Message-ID: <20191128122337.GC4210@sirena.org.uk>
References: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
 <20191128121128.GA4210@sirena.org.uk>
 <ecfa48d3-284b-5234-02b9-adc0c6892b6f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <ecfa48d3-284b-5234-02b9-adc0c6892b6f@cogentembedded.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2019 at 03:19:38PM +0300, Nikita Yushchenko wrote:

> > I'm not seeing any integration with DAPM here, I'd expect to see that so
> > we don't cut off the start of audio especially with the longer times
> > available (which I'm frankly not sure are seriously usable).

> I believe driver already has that integration, there is
> aic31xx_dapm_power_event() that is called on DAPM events, and polls state in
> register bits waiting for operation to complete.

> Btw, the default setting for register fields in question is "304ms" /
> "3.9ms" thus some delay is already there. This patch just makes it
> explicitly controllable by those who wait it.

Can you confirm that this does take effect (should be easy with the
longer delays) and put a comment in indicating that please in case
someone is cut'n'pasting?

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3fvEkACgkQJNaLcl1U
h9DlHgf/SsdPanPk6tcxh3RNkH+E1k2QbOZyqz3ogi46FtVFl/EySbEnLUh0vvfV
yr8xLzJaENOWRlmBPP8NeB65/Zq4gfCp4vNX8fmm+0i7Uphn07vD13M2LMFMyWWn
H+NMnpM/8u+UsPY/dW7lk4cSt4sWhoV9D1FfwZt3fyabVGYF11+m440TFjUxqd1a
8NZTM7n2vOLlH7CXYXFyJqsJ0TGmmxdB1xWoT7S4XCHvsCBdyDYMyLFooZS/ClLW
MD24Rq9hH90CWAqcKbicRtGYs2fohXUZfzGEFDnSS2VYB7vlF4QPw7w8s9UGNvu1
bvEXSMuQhdTSHtz/BvV3d59WPNkRJw==
=+Mvy
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
