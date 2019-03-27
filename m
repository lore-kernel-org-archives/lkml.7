Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF7621734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="dj0YONef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfC0NZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:25:46 -0400
Received: from node.akkea.ca ([192.155.83.177]:50218 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0NZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:25:44 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 2FD444E204B; Wed, 27 Mar 2019 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553693144; bh=iFnuqUuCLiL1UuhJauDFiwBaX4p3xC2wnoQawxv2M7Y=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=dj0YONefsuy/N9Pa7k8x1zRGe8Wq0T8jEH78Z5RWye9gSY4gmEOSUSgsA+0RZlyj/
         yDibGCe3XHzjZgFDHOo6lv2GcTn91wlR940uvQ0kWEArebkRifZ2NFEUgg5xAjdWtf
         +ampvibMe6BTbth7wWX/sgkK7CwCvv2hEDsA0wXk=
To:     Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v6 1/4] arm64: dts: imx8mq: Add SDMA nodes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Mar 2019 06:25:44 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        baruch@tkos.co.il, Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ccaione@baylibre.com, Chris Spencer <spencercw@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>, agx@sigxcpu.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
In-Reply-To: <CAEnQRZD27=jCvGB_Go-niXyEtrFu=MP2Wyvvqcx2CpnQ4Npx-Q@mail.gmail.com>
References: <20190308120141.3698-1-daniel.baluta@nxp.com>
 <20190308120141.3698-2-daniel.baluta@nxp.com>
 <20190319143139.GA24315@dragon>
 <f5934d5bca4b9241d0ac84de463fbeed@www.akkea.ca>
 <CAEnQRZD27=jCvGB_Go-niXyEtrFu=MP2Wyvvqcx2CpnQ4Npx-Q@mail.gmail.com>
Message-ID: <9a124bfc5395e1fbfd8c226bb80f6df5@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-27 02:51, Daniel Baluta wrote:
> On Tue, Mar 26, 2019 at 11:44 PM Angus Ainslie <angus@akkea.ca> wrote:
>> 
>> On 2019-03-19 07:31, Shawn Guo wrote:
>> > On Fri, Mar 08, 2019 at 12:02:22PM +0000, Daniel Baluta wrote:
>> >> SDMA1 is part of AIPS-3 region and SDMA2 is part
>> >> of AIPS-1 region.
>> >>
>> >> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> >
>> > Reviewed-by tag should go after your SoB, since that's the sequence of
>> > how they come.
>> >
>> >> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> >> [initial submit in i.MX internal tree]
>> >> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> >> [adaptation for linux-next]
>> >
>> > I would see these notes in commit log or even just cover letter.
>> >
>> > Shawn
>> >
>> >> ---
>> >>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>> >>  1 file changed, 22 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> >> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> >> index 9155bd4784eb..9d48450453fb 100644
>> >> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> >> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> >> @@ -234,6 +234,17 @@
>> >>                              status = "disabled";
>> >>                      };
>> >>
>> >> +                    sdma2: sdma@302c0000 {
>> >> +                            compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
>> >> +                            reg = <0x302c0000 0x10000>;
>> >> +                            interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> >> +                            clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
>> >> +                                     <&clk IMX8MQ_CLK_SDMA2_ROOT>;
>> >> +                            clock-names = "ipg", "ahb";
>> >> +                            #dma-cells = <3>;
>> >> +                            fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
>> >> +                    };
>> >> +
>> >>                      iomuxc: iomuxc@30330000 {
>> >>                              compatible = "fsl,imx8mq-iomuxc";
>> >>                              reg = <0x30330000 0x10000>;
>> >> @@ -575,6 +586,17 @@
>> >>                              status = "disabled";
>> >>                      };
>> >>
>> >> +                    sdma1: sdma@30bd0000 {
>> >> +                            compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
>> 
>> There shouldn't be a space in the imx8mq compatible string.
> 
> Oh, nice catch. This patch series is already in so care to send a fix?
> 
> Otherwise, I will take care of it.

I'm preparing some other fixes so I can add it.

Angus

> 
> thanks,
> Daniel.

