Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C59C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D29218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfDWVWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:22:51 -0400
Received: from sauhun.de ([88.99.104.3]:56398 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWVWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:22:50 -0400
Received: from localhost (p5486CDD9.dip0.t-ipconnect.de [84.134.205.217])
        by pokefinder.org (Postfix) with ESMTPSA id C6A632C7BF4;
        Tue, 23 Apr 2019 23:22:48 +0200 (CEST)
Date:   Tue, 23 Apr 2019 23:22:48 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "eha@deif.com" <eha@deif.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Message-ID: <20190423212248.GD5659@kunai>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB42110D893D07DFECFE167F5580250@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42110D893D07DFECFE167F5580250@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Dong Aisheng,

> Besides above comments:
>=20
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Are you maybe interested in maintaining this driver? We are seriously
needing one with experience.

Thanks,

   Wolfram


--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly/gigACgkQFA3kzBSg
KbYvrxAAsVX1hQ3T3vhl9uvtE92c9kzpKgsLtjqZlLCY8q8lj16EEea4hZe3jd/7
KaO+Tk73Pd36Ci0sGJMRH91E7CQTPdoei6fNm0ZxjAM/TKTHKQUO5Szcgyq+hyS3
AGpazulMEwt6gCGBiPWdsJXLy0id3GpZ3BSmWeKFYb9BQMq1EiqdNpHTdBgUBIH4
F3S140Dg2sNrXZT/6hoxesQkD594PLaE8WfRgQqo7tIqTZz2RcNBbJTyRcWaUYf3
H6qAnySi8nM+fkE9xnNMz+XbC7N9Qi2fLfMxC+TxfABSVOrHZXnaXOijpIQuxQ2c
XE11A/8EhEu6NvmJOI1cyz4rpPKw2huNkRLEN+fLzLf6OJRnTu4rEnE0PK20KZdm
Im7vCMTSpia/tYaVvici7wFFjLIuICzKe2vBU3h+ynlSJr79awcZFnbb0l7tn/xw
3LWPi2O0scT9Lxgs+6E1tvoeQ/wIiCmbe0Z0RW13Ej+cRPVJ4lhvWK1zH56aWkmV
REPfsPnsdmT7tlWQkM7PXOLZ1fIVIBMyGFNp2HaOzYORFlSJcZZTB+aB2ZfWjRSS
aqVxtcdoOJ12YPfqRvMTUCrDyjkQwB37t0FgdAsnwHo+V7u0ozJCuwSU2mdrEnov
MCsjzyEqOy6/OmtWRI7YIpHi/cxVzRvTzKgAbEO7eR2k04RX1ZY=
=ONMA
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
