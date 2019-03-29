Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D541EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F182183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="u2rOx3GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfC2OJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:09:27 -0400
Received: from node.akkea.ca ([192.155.83.177]:55936 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbfC2OJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:09:27 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 89E6D4E204D; Fri, 29 Mar 2019 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553868566; bh=pXsYLgQavd8fTBMtWNBZ5DMPnBT/+YoHV2PZjK3PbCg=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=u2rOx3GLYX8PObQ+1clDQgGBnt7V0+aS7HpphSgJsf+eCG/VtZiitSrohksnfag0u
         kgpDGxyfKn31SMM7zceltLMvMcgnDXg7d/MsWulRTSrDH2oDkGa3ICEm9Vh8lWJHfm
         pSEhGPUdvpzySnSnjZI9oHKsCQjMhxdYVWoqzbD0=
To:     Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma  compatible string
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Mar 2019 07:09:26 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <CAEnQRZCjCAhi2OqpSGN8rmGYCqyOmLP=+=L0djcq2C6ksk29LQ@mail.gmail.com>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190328133828.20999-2-angus@akkea.ca>
 <AM0PR04MB421112C3EE79B279953A9252805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAEnQRZCjCAhi2OqpSGN8rmGYCqyOmLP=+=L0djcq2C6ksk29LQ@mail.gmail.com>
Message-ID: <bc7d4617cf7f29fa05f823f48b8ba4d6@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-29 04:20, Daniel Baluta wrote:
> On Fri, Mar 29, 2019 at 11:11 AM Aisheng Dong <aisheng.dong@nxp.com> 
> wrote:
>> 
>> > From: Angus Ainslie (Purism) [mailto:angus@akkea.ca]
>> > Sent: Thursday, March 28, 2019 9:38 PM
>> >
>> > Fix a typo in the compatible string
>> >
>> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> > ---
>> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > index 81d5ce1b1ec1..07099f82965e 100644
>> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > @@ -720,7 +720,7 @@
>> >                       };
>> >
>> >                       sdma1: sdma@30bd0000 {
>> > -                             compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
>> > +                             compatible = "fsl,mx8mq-sdma","fsl,imx7d-sdma";
>> 
>> This is a bit strange.
>> If binding doc says like that, probably we'd better fix the typo in 
>> binding doc
>> to use the same style.
> 
> Oh, indeed.
> 
> Angus, shouldn't this be fsl,imx8mq-sdma instead of fsl,mx8mq-sdma. I
> was just paying
> attention to the extra space in my patch.

Correct I took too many characters when I dropped the space. I'll fix it 
for v2.

Angus
