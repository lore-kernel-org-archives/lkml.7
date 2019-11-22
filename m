Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34890C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075DF20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P3F2cemZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKVJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:30:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49454 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:30:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAM9TvN4113974;
        Fri, 22 Nov 2019 03:29:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574414997;
        bh=xX8liYsX0VdU7UbDFFdmYxW/QRc0esFBTcTeyfAaf/Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P3F2cemZy8prOUSQ+UocifYvHE6rFXxrk1FsUUVIHva+YoMvD1ZSLT3roJzOG9qOY
         78HBTfVCsfqEehMiIXAV6jPrs1OM/5HHNdZSdkP3fXMutMbL9HDBN9dus404g3wT8C
         DWjZj7iRA31pUYaiuC1s4htNtmQ6l7Pc+eBECvt8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAM9TvZu119213;
        Fri, 22 Nov 2019 03:29:57 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 22
 Nov 2019 03:29:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 22 Nov 2019 03:29:57 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAM9TqqM096217;
        Fri, 22 Nov 2019 03:29:53 -0600
Subject: Re: [PATCH 1/1] ARM: dts: am5729: beaglebone-ai: adding device tree
To:     "Robey, Caleb" <c-robey@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
CC:     Jason Kridner <jkridner@gmail.com>,
        "Vutla, Lokesh" <lokeshvutla@ti.com>,
        "Kridner, Jason" <jdk@ti.com>,
        "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>,
        "Dannenberg, Andreas" <dannenberg@ti.com>,
        "Hiblot, Jean-Jacques" <jjhiblot@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        "Davis, Andrew" <afd@ti.com>, Tom Rini <trini@konsulko.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191119202850.18149-1-c-robey@ti.com>
 <20191119202850.18149-2-c-robey@ti.com>
 <8465b8c3-db4b-31fd-a299-3d5251ec99cf@ti.com>
 <12acbc1a96754fe68d7447b6ee99efd3@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a02ff0ca-f061-4d9e-977b-f41b52bbf18a@ti.com>
Date:   Fri, 22 Nov 2019 11:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <12acbc1a96754fe68d7447b6ee99efd3@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2019 16:41, Robey, Caleb wrote:
> 
> 
>> -----Original Message-----
>> From: Strashko, Grygorii
>> Sent: Thursday, November 21, 2019 5:05 AM
>> To: Robey, Caleb; linux-omap@vger.kernel.org
>> Cc: Jason Kridner; Vutla, Lokesh; Kridner, Jason; Rizvi, Mohammad Faiz
>> Abbas; Dannenberg, Andreas; Hiblot, Jean-Jacques; Bajjuri, Praneeth; Davis,
>> Andrew; Tom Rini; Robert Nelson; Rob Herring; Mark Rutland; Benoît
>> Cousson; Tony Lindgren; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/1] ARM: dts: am5729: beaglebone-ai: adding device
>> tree
>>
>>
>>
>> On 19/11/2019 22:28, Caleb Robey wrote:
>>> From: Jason Kridner <jdk@ti.com>
>>>
>>> BeagleBoard.org BeagleBone AI is an open source hardware single
>>> board computer based on the Texas Instruments AM5729 SoC featuring
>>> dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
>>> signal processor (DSP), quad-core embedded vision engine (EVE),
>>> Arm Cortex-M4 processors, dual programmable realtime unit
>>> industrial control subsystems and more. The board features 1GB
>>> DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
>>> 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
>>> headers.
>>>
>>> For more information, refer to:
>>> https://beaglebone.ai
>>
>>
>>>
>>> This patch introduces the BeagleBone AI device tree.
>>>
>>> Note that the device use the "ti,tpd12s016" component which is
>>> software compatible with "ti,tpd12s015". Thus we only use the
>>> latter driver.
>>>
>>> Signed-off-by: Jason Kridner <jdk@ti.com>
>>> Signed-off-by: Caleb Robey <c-robey@ti.com>
>>> Cc: Robert Nelson <robertcnelson@gmail.com>
>>>
>>> ---
>>>    arch/arm/boot/dts/Makefile                |   1 +
>>>    arch/arm/boot/dts/am5729-beagleboneai.dts | 782
>> ++++++++++++++++++++++
>>>    2 files changed, 783 insertions(+)
>>>    create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index b21b3a64641a..b1154dbda73c 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>
>> [..]
>>
>>> +
>>> +&uart1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&davinci_mdio {
>>> +	reset-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
>>> +	reset-delay-us = <2>;
>>> +
>>> +	phy0: ethernet-phy@1 {
>>> +		reg = <4>;
>>> +		compatible = "ethernet-phy-id004d.d072",
>>> +			"ethernet-phy-ieee802.3-c22";
>>
>> Pls, do not ignore my comments.
>>
>> Above compatible should not be required.
> 
> Grygori, I am so sorry about this - I had deleted this,
> but must have made a mistake in the resubmission. I
> will fix it immediately.
> 

Yep. thanks and sorry.
I saw you fixed it in next version.

-- 
Best regards,
grygorii
