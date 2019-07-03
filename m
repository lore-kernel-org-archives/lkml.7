Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75B9C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516F6218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qUWWDsIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGCNMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:12:52 -0400
Received: from node.akkea.ca ([192.155.83.177]:58376 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCNMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:12:51 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 76E254E204B; Wed,  3 Jul 2019 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1562159571; bh=e9mCRjUPMrK+NkTqhauY/TqZcc/RebVUj8bLM/dL1+g=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=qUWWDsIKxHCz84cOUYE2/HgdHZRdeRICVc9DZ6w8MZS8SW6IQR96VhJ/M+8FikdQO
         +FBE7YvuwCYK9fXTtNatkhVOlKhHmeZRutkl56mEE3H5qeKfsLD4Q2Fef6uVhFJGty
         0E5vya6ra1FDGUaHa/K7hOFElnoA3O7DkCMcBLWY=
To:     Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jul 2019 07:12:51 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Andra Danciu <andradanciu1997@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, andrew.smirnov@gmail.com,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAEnQRZDCpPju7xBBY9=e0dWt=A9c3t3g88pEw+teoZmmOiiKXQ@mail.gmail.com>
References: <20190702132353.18632-1-andradanciu1997@gmail.com>
 <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca>
 <CAEnQRZDCpPju7xBBY9=e0dWt=A9c3t3g88pEw+teoZmmOiiKXQ@mail.gmail.com>
Message-ID: <9e196ce51eac9ce9c327198c4a2911a8@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2019-07-03 07:10, Daniel Baluta wrote:
> On Wed, Jul 3, 2019 at 4:01 PM Angus Ainslie <angus@akkea.ca> wrote:
>> 
>> Hi Andra,
>> 
>> I tried this out on linux-next and I'm not able to record or play 
>> sound.
>> 
>> I also added the sai2 entry to test out our devkit and get a PCM 
>> timeout
>> with that.
> 
> Hi Angus,
> 
> There are still lots of SAI patches that need to be upstream. Me and 
> Andra
> will be working on that over this summer.
> 
>> 
>> On 2019-07-02 07:23, Andra Danciu wrote:
>> > SAI3 and SAI6 nodes are used to connect to an external codec.
>> > They have 1 Tx and 1 Rx dataline.
>> >
>> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
>> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
>> > ---
>> > Changes since v2:
>> >       - removed multiple new lines
>> >
>> > Changes since v1:
>> >       - Added sai3 node because we need it to enable audio on pico-pi-8m
>> >       - Added commit description
>> >
>> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29
>> > +++++++++++++++++++++++++++++
>> >  1 file changed, 29 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > index d09b808eff87..736cf81b695e 100644
>> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> > @@ -278,6 +278,20 @@
>> >                       #size-cells = <1>;
>> >                       ranges = <0x30000000 0x30000000 0x400000>;
>> >
>> > +                     sai6: sai@30030000 {
>> > +                             compatible = "fsl,imx8mq-sai",
>> 
>> I don't find this compatible string in sound/soc/fsl/fsl_sai.c. Aren't
>> the registers at a different offset from "fsl,imx6sx-sai".
> 
> Yes, you are right on this. We are trying to slowly push all our 
> internal-tree
> patches to mainline. Obviously, with started with low hanging fruits, 
> DTS
> nodes and small SAI fixes.
> 
> Soon, we will start to send patches for SAI IP ipgrade for imx8.
> 
>> 
>> How is this supposed to work ?
>> 
> 
> For the moment it won't work unless we will upstream all our SAI
> internal patches.
> But we will get there hopefully this summer.
> 

Shouldn't a working driver be upstream before enabling it in the 
devicetree ?

Thanks
Angus

> Thanks,
> Daniel.

