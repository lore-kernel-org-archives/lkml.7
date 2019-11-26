Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA795C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936C4206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="dFxXPlxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKZKIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:08:06 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:52403 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfKZKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:08:06 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E7C5C230D1;
        Tue, 26 Nov 2019 11:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574762882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3hXqvgd2MuTcuqEB4nE4yu26xVNMub4dFPnjjzwuFc=;
        b=dFxXPlxcs5wRBFdPEc6cdNVDsDXU/Kllf1DAfc65g3QCmnFm7rxn7VkV6HW6eniMyCLORP
        0ffkpCIJM3wk6wAdij5MW5XC8KcmV0IMV1KlrYdE+7SwIYNPlVr7geT1jC9WQ/DwXMhBU9
        +/u3dIrPZ8oKDR05yic5hLRaapCXt9c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Nov 2019 11:08:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
In-Reply-To: <AM0PR0402MB3556804FB47D182173C6A7AAE0450@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191123201317.25861-1-michael@walle.cc>
 <20191123201317.25861-4-michael@walle.cc>
 <AM0PR0402MB3556804FB47D182173C6A7AAE0450@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Message-ID: <afde04b888418e9e4f4fdb946a579e70@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: E7C5C230D1
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.32.167.96:email];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.385];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuldeep,

Am 2019-11-26 07:40, schrieb Kuldeep Singh:
> Hi Michael,
> 
>> -----Original Message-----
>> From: devicetree-owner@vger.kernel.org 
>> <devicetree-owner@vger.kernel.org>
>> On Behalf Of Michael Walle
>> Sent: Sunday, November 24, 2019 1:43 AM
>> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; 
>> linux-
>> kernel@vger.kernel.org
>> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
>> Michael Walle <michael@walle.cc>
>> Subject: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
> 
> There's already a patch[1] sent upstream and is under review.
> It includes dts(i) entries for LS1028. I will be sending the next 
> version

I've seen that, but there wasn't any reply for almost two months now. 
But
if you're sending your next version, this patch can be dropped from this
series.

-michael

> 
> [1] https://patchwork.kernel.org/patch/11139365/
>> 
>> Caution: EXT Email
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> index 6730922c2d47..650b277ddd66 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> @@ -260,6 +260,19 @@
>>                         status = "disabled";
>>                 };
>> 
>> +               fspi: spi@20c0000 {
>> +                       compatible = "nxp,lx2160a-fspi";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <0x0 0x20c0000 0x0 0x10000>,
>> +                             <0x0 0x20000000 0x0 0x10000000>;
>> +                       reg-names = "fspi_base", "fspi_mmap";
>> +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
>> +                       clock-names = "fspi_en", "fspi";
>> +                       status = "disabled";
>> +               };
>> +
>>                 esdhc: mmc@2140000 {
>>                         compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
>>                         reg = <0x0 0x2140000 0x0 0x10000>;
>> --
>> 2.20.1
> 
> Regards
> Kuldeep
