Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7433BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525E421848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfFNUbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:31:50 -0400
Received: from sauhun.de ([88.99.104.3]:56706 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfFNUbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:31:47 -0400
Received: from localhost (p5486CF81.dip0.t-ipconnect.de [84.134.207.129])
        by pokefinder.org (Postfix) with ESMTPSA id E6D7B2CF690;
        Fri, 14 Jun 2019 22:31:44 +0200 (CEST)
Date:   Fri, 14 Jun 2019 22:31:44 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Alan Tull <atull@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Moritz Fischer <mdf@kernel.org>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 06/28] drivers: Add generic helper to match by of_node
Message-ID: <20190614203144.GB7991@kunai>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <1560534863-15115-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +
> +int device_match_of_node(struct device *dev, const void *np)
> +{
> +	return dev->of_node == np;
> +}
> +EXPORT_SYMBOL_GPL(device_match_of_node);

Is it an option to 'static inline' this simple function in the header,
saving the EXPORT?


--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0EBDAACgkQFA3kzBSg
KbZQeg/+MjmzU/IJj8oHfL4ndVmHrnLSPM/0OA0J/USTiS12dT9fwVXWkkaLZlRR
cZkTt2QJ3UkAf+rbhooH8c/uo56rhY/LLFM7CT+4b360BZ1CYaVT8ttPRYSs5jtC
CV9vMHwMl1kI1vAg5uSMb0EIjR/0dEl4Q8ol4MYMYqR7fusVx+qGRnVPW9zePbEI
x3F/0woDahhQj0i12ETLSl2ONa8A54M1BgmOHRdcbfrdEnuUnyb0gmnKJDuQu7pz
MDYW2ILMYPOewsH3DJSHpH7HuzgDTjqlgmWIBlKn0EbpgMT2UqyuoxHJ1lkOh4yk
llNaipn5AyS6IbodA4F5TZu2NHJkPhwUgfCy9rXUG5/IGYPq43f9DjLNEzNqHhMI
4nZi5EGx6o8Y5641xf3hZxRjDqu610k19RX3QSOXZxLoOQ9+CSFEwfXxIVDgD11o
B4NMXI6cD3cddQgHfSyUNKDCn9lNMLk7uqbuXnAGEbreQ5InjVBgeZ3O59mDaVrW
1qR3/yup3CR/nOLPdfzR2E4yiwTAKc+B4Vo52DP8X6OnQR/u/05CCTKHaeh8SOjT
uP31ar1Au18BDkCxNuw4NijvDnIGAjqTO/0GLV2m5ViWAeq1nAMpIoCIiR6dhMpK
naLg0mc136SskefQhRyOrVOmm7rLHV9oQmzG7Lb8maF3BNuStsk=
=CJt5
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
