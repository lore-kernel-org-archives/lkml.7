Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02B4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D372073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfDQIbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:31:22 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41585 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:31:22 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0BA84C0004;
        Wed, 17 Apr 2019 08:31:16 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:31:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190417083116.xgwglxogy2zqdghh@flea>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctpou35gd6hfomxj"
Content-Disposition: inline
In-Reply-To: <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctpou35gd6hfomxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 07:38:30AM +0530, Viresh Kumar wrote:
> On 16-04-19, 11:52, Yangtao Li wrote:
> > Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.
> >
> > Yangtao Li (2):
> >   cpufreq: Add sunxi nvmem based CPU scaling driver
> >   dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
> >
> >  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  drivers/cpufreq/Kconfig.arm                   |  12 +
> >  drivers/cpufreq/Makefile                      |   1 +
> >  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
> >  6 files changed, 415 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> >  create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> >
> > ---
> > v4:
> > -I removed this sunxi_cpufreq_soc_data structure for now.
>
> Why this change ?

It's used on a single SoC for now, so it's impossible to know at this
point what to put in that structure in the first place.

Of course, that would need to be brought back if we ever have two SoCs
to support and that we know which differences there is.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ctpou35gd6hfomxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLbkVAAKCRDj7w1vZxhR
xQuXAP9pgWjpdSjA5KIXPG6IT9T+tbepvXBNmEhSWg7XEt34TAD9EkkRr/+OKOJe
gGXx9J8+DZeXBERfyeRaRvOAbZdrKw0=
=91iH
-----END PGP SIGNATURE-----

--ctpou35gd6hfomxj--
