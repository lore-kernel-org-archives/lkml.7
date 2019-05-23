Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07237C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A868D2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558573425;
	bh=0c93wE/T01S1HHzZxo+8x1JHeBq/Z/FxViGUSsHuNEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GqJDr8nU0iNYzyXoMTU2oo5/BU1+2puEer79i+znbQTRckY2jN3j6nIiRj3KIjswr
	 WGIyOm8nrCW50tamCfVqFrk6RadPonn59YJRZh1z8uod+s2x9Va/02nv673Eq0xJbt
	 Zacq0Z1xZ/CXqhn49m6YxkwAEAyNxmfPmRD5+oK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfEWBDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfEWBDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:03:44 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EAB2089E;
        Thu, 23 May 2019 01:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558573424;
        bh=0c93wE/T01S1HHzZxo+8x1JHeBq/Z/FxViGUSsHuNEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5QNOK3Hj+hGJR7NJooBOJM7pC622hJjNbI5Z74TNb6jZ770OzTtrJEGQI9llBWGP
         +D6mZ+AVButruoo+8vcMfrKj3TNJQv1FdHUIvbxKyWAJPV51f2RZB+0NHwVmtEjyFn
         XD27vCaRuP0B38k5NcdLJfb4l/8ijUSN0M6zbBh4=
Date:   Thu, 23 May 2019 09:02:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8mq: add clock for SNVS RTC node
Message-ID: <20190523010243.GD16359@dragon>
References: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
 <1557882259-3353-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557882259-3353-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:09:36AM +0000, Anson Huang wrote:
> i.MX8MQ has clock gate for SNVS module, add clock info to SNVS
> RTC node for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

This one still has problem with encoding and thus cannot be applied.
Here is what I get, and there is '=20' in the patch content.

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index e5f3133..b706de8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -438,6 +438,8 @@
                                        offset =3D <0x34>;
                                        interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
                                                <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+                                       clocks =3D <&clk IMX8MQ_CLK_SNVS_ROOT>;
+                                       clock-names =3D "snvs-rtc";
                                };
                        };
=20
--=20
2.7.4

