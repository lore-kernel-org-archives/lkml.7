Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70600C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422C421850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGSHAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:00:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44015 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGSHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:00:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1hoMsB-0007Ad-DF; Fri, 19 Jul 2019 09:00:07 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hoMs9-0003lG-Hi; Fri, 19 Jul 2019 09:00:05 +0200
Date:   Fri, 19 Jul 2019 09:00:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     shawnguo@kernel.org, mark.rutland@arm.com, aisheng.dong@nxp.com,
        peng.fan@nxp.com, anson.huang@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, Frank.Li@nxp.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        leonard.crestez@nxp.com, festevam@gmail.com, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 0/3] Add DSP node on i.MX8QXP board
Message-ID: <20190719070005.mkqvfhjras2jmo52@pengutronix.de>
References: <20190718151346.3523-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718151346.3523-1-daniel.baluta@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:55:39 up 62 days, 13:13, 49 users,  load average: 0.14, 0.13,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

thanks for your patches :) but it's quite common to bundle the driver
related and the dt related patches. Can you add the firmware related
patch to this series in your v2?

Regards,
  Marco

On 19-07-18 18:13, Daniel Baluta wrote:
> i.MX8QXP boards feature an Hifi4 DSP from Tensilica. This patch series
> adds the DT node.
> 
> Note that we switched to the new yaml format for bindings documentation.
> 
> The DSP will run SOF Firmware [1]. Patches adding support for Linux DSP
> driver are already sent for review to SOF folks [2].
> 
> This patch series also contains a patch introducing DT related clocks.
> 
> The patch was already reviewed here:
> 	https://lkml.org/lkml/2019/7/17/975
> 
> but I added it in this patch series because it wasn't yet picked by
> Shawn so patches 2/3 will not compiled without patch 1.
> 
> [1] https://github.com/thesofproject/sof
> [2] https://github.com/thesofproject/linux/pull/1048/commits
> 
> Daniel Baluta (3):
>   clk: imx8: Add DSP related clocks
>   arm64: dts: imx8qxp: Add DSP DT node
>   dt-bindings: dsp: fsl: Add DSP core binding support
> 
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 87 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 +
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 32 +++++++
>  drivers/clk/imx/clk-imx8qxp-lpcg.c            |  5 ++
>  include/dt-bindings/clock/imx8-clock.h        |  6 +-
>  5 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> 
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
