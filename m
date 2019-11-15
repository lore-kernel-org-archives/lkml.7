Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98842C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70114206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfKOBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:51:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbfKOBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:51:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80276B1C0;
        Fri, 15 Nov 2019 01:51:52 +0000 (UTC)
Subject: Re: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-realtek-soc@lists.infradead.org
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-6-afaerber@suse.de>
 <CAL_Jsq+fdksCHQ1_NaizkM6dVWT1h2wocJpD4NB8K2dOO-yZ4Q@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <c8ff8f52-9c01-12f7-e462-5c47d3a59f52@suse.de>
Date:   Fri, 15 Nov 2019 02:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+fdksCHQ1_NaizkM6dVWT1h2wocJpD4NB8K2dOO-yZ4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.11.19 um 02:34 schrieb Rob Herring:
>> diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
>> index a8cc2d23e7ef..3439647ecf97 100644
>> --- a/arch/arm/boot/dts/rtd1195.dtsi
>> +++ b/arch/arm/boot/dts/rtd1195.dtsi
>> @@ -92,28 +92,36 @@
>>                          <0x18100000 0x18100000 0x01000000>,
>>                          <0x40000000 0x40000000 0xc0000000>;
>>
>> -               wdt: watchdog@18007680 {
>> -                       compatible = "realtek,rtd1295-watchdog";
>> -                       reg = <0x18007680 0x100>;
>> -                       clocks = <&osc27M>;
>> -               };
>> -
>> -               uart0: serial@18007800 {
>> -                       compatible = "snps,dw-apb-uart";
>> -                       reg = <0x18007800 0x400>;
>> -                       reg-shift = <2>;
>> -                       reg-io-width = <4>;
>> -                       clock-frequency = <27000000>;
>> -                       status = "disabled";
>> -               };
>> -
>> -               uart1: serial@1801b200 {
>> -                       compatible = "snps,dw-apb-uart";
>> -                       reg = <0x1801b200 0x100>;
>> -                       reg-shift = <2>;
>> -                       reg-io-width = <4>;
>> -                       clock-frequency = <27000000>;
>> -                       status = "disabled";
>> +               rbus: r-bus@18000000 {
> 
> Following node names should be generic: bus@...

Fixed for all four SoCs.

That seems inconsistent with specific pci@... & usb@... (both from OF),
but I see now the Amlogic-specific buses that I was inspired by do use
bus@..., too.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
