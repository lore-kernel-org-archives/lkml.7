Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4462FC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23ECE212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559930441;
	bh=yEjHUTeDOx/bVhtT8NKDYF5tv5cPT46YztGXBKmrfW0=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=KorsEEFSHj1CBwjvWZeKjQ0timdJoI60LSs4XtRo4c/CdfjsuAbTU7yqu6qm6DcrS
	 72mrEtFKbv1OYIUCKa4KUxlFfn7RXDrR/y454Q87S4lw465yh5vaEYqMjnMk/1Kgy+
	 dCVo6DMhrlbFT9B6hxxE9cibv7TstAQtK1/MHd8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfFGSAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbfFGSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:00:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 611C7208C0;
        Fri,  7 Jun 2019 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559930439;
        bh=yEjHUTeDOx/bVhtT8NKDYF5tv5cPT46YztGXBKmrfW0=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=buPYYsjITPLFUb4400cFTBwKZR4aHQBxdam/szMAZlq52am04yHsLQ24WWVCcmlxp
         YMDBtqhWX8I2JWySI9ZSxlCOdG7+/wd/6s/Mt6WpaXXWDvEPUzSb8Di0IspEw7dpwj
         vgtG4hIrAZXIcZOJfZrFjX0a/stLpy0jDHM3Ak3Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com> <20190604015928.23157-3-Anson.Huang@nxp.com> <20190606162543.EFFB820645@mail.kernel.org> <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix .de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Cc:     dl-linux-imx <linux-imx@nxp.com>
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 11:00:38 -0700
Message-Id: <20190607180039.611C7208C0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-06-06 17:50:28)
>=20
> I will use devm_platform_ioremap_resource() instead of ioremap(),
> and can you be more specific about devmified clk registration?
>=20

I mean using things like devm_clk_hw_register().

