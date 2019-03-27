Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09DF21734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfC0NPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:15:53 -0400
Received: from sauhun.de ([88.99.104.3]:35920 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbfC0NPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:15:53 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 742DF2E35A2;
        Wed, 27 Mar 2019 14:15:50 +0100 (CET)
Date:   Wed, 27 Mar 2019 14:15:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] i2c: apply coding style for struct i2c_adapter
Message-ID: <20190327131549.GB5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 02, 2019 at 02:47:29PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I think this preparational patch can be applied right away.
Applied to for-next, thanks!


--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybd4UACgkQFA3kzBSg
KbYWnRAAmUadlsRF622cbFRUumndjog2TVn07dP+XHyCKVxZ/ml29ePh2aAIhQsj
8L4pjKIyXy4bLNoyKQuywMucLdk2SToh4q7Hv4wFhIYyD4LTQgPvuCj/AD0TFRGn
pt7vcLTBerBse52UaMNE99sQnNzxTUrtebildwD/5/GrpN4RCdqo/w8URLaPgMbi
R/Ui9lZWV7pylB/rhWSyYZuPggUFhaXXd8EA3v8w9lDGfOVFnaFv8SmR4RfGlUqM
yGO0CjDTiMQ9KbWXSrwq2z8+jsdhl37WdY4G/kiw6oHy+AvYV3rYubY1oaKfAUW4
Xlzm29ULJfUPOj56aKMSZ1m2dMOJW73uydObveTmIQC0aK3UnntZI1HRHzc4mKhA
M4HGL6wPYKJX7zUf9A5hJcEutHlFunhogfXdG1wEwKS6m8MDFEk5j1H+I0hm8/zB
deyXXyIr+oUv8quAkSz8Y8Y1aa25dMV4jSDpKT+A+G4amONjVb1pybdpqbvDhjtp
5lgw9YqAuMM4w+gu93j4Iyyxxwd0OKmpJbxCgtB81bex0YTab0pbelr/X8l4Wm+D
2XNOvuqgxpzYgLxtn0vFS04BkElncQ4hC0SBzZ/ID4LVFHAOlrkAzpIZ3XfOg6Ov
YE1wcB53UHtO4+H++bwAykSQAZ9DQCofLXOB7Ut0dmq7yhxmQ2w=
=mmPj
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
