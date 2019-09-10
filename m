Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713DC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B39E21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aCBFXZAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfIJNsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:48:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46020 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbfIJNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:48:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ADlAGb068851;
        Tue, 10 Sep 2019 08:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568123230;
        bh=KCsuiucHi88CCTXSYu2IpIzdJ7GYk/usdfSwVkf0fN0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=aCBFXZAkngxsPLJ/RWW99Vqvi5DqIb/9uS/cdfD7nGL+ng9fLYqb/l80gcbyjzpAg
         npotnHguI98tJFqnWongfobRdhcla/VvL9Kq75+dWDSHcYcVFoVjWY2+yneHYw/p8q
         ln/foJwhUp+NiNKabjS9tFqNrF7LOdI5vbxOawaY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ADlAVO104167;
        Tue, 10 Sep 2019 08:47:10 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 08:47:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 08:47:10 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ADlAPC079028;
        Tue, 10 Sep 2019 08:47:10 -0500
Subject: Re: [PATCH] tas2770: add tas2770 smart PA dt bindings
From:   Dan Murphy <dmurphy@ti.com>
To:     <shifu0704@thundersoft.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <navada@ti.com>
References: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
 <76759c2c-3f5d-5cf6-fc2b-feb1dc8c0e6a@ti.com>
Message-ID: <15483b8f-ffda-eea3-9461-894f43a39a20@ti.com>
Date:   Tue, 10 Sep 2019 08:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <76759c2c-3f5d-5cf6-fc2b-feb1dc8c0e6a@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shi

One other thing

On 9/10/19 8:21 AM, Dan Murphy wrote:
> Shi
>
> On 9/6/19 2:06 AM, shifu0704@thundersoft.com wrote:
>> From: Frank Shi <shifu0704@thundersoft.com>
>
> Subject should be
>
> dt-bindings: ASoC: Add tas2770 smart PA dt bindings
>
> Also Please add Rob Herring <robh+dt@kernel.org> for review
>
>> add tas2770 smart PA dt bindings
>>
>> Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
>> ---
>>   Documentation/devicetree/bindings/tas2770.txt | 38 
>> +++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/tas2770.txt
>>
>> diff --git a/Documentation/devicetree/bindings/tas2770.txt 
>> b/Documentation/devicetree/bindings/tas2770.txt
This binding belongs in Documentation/devicetree/bindings/sound
>> new file mode 100644
>> index 0000000..f70b310
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/tas2770.txt
>> @@ -0,0 +1,38 @@
>> +Texas Instruments TAS2770 Smart PA
>> +
>> +The TAS2770 is a mono, digital input Class-D audio amplifier 
>> optimized for
>> +efficiently driving high peak power into small loudspeakers.
>> +Integrated speaker voltage and current sense provides for
>> +real time monitoring of loudspeaker behavior.
>> +
>> +Required properties:
>> +
>> + - compatible:       - Should contain "ti,tas2770".
>> + - reg:               - The i2c address. Should contain <0x4c>, 
>> <0x4d>,<0x4e>, or <0x4f>.
> s/should/may
>> + - #address-cells  - Should be <1>.
>> + - #size-cells     - Should be <0>.
>> + - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
>> + - ti,left-slot:   - Sets TDM RX left time slots.
>> + - ti,right-slot:  - Sets TDM RX right time slots.
>> + - ti,imon-slot-no:- TDM TX current sense time slot.
>> + - ti,vmon-slot-no:- TDM TX voltage sense time slot.
>> +
>> +Optional properties:
>> +
>> + - reset-gpio:    Reset GPIO number of left device.
>> + - irq-gpio:  IRQ GPIO number of left device.
>
> You might want to use
>
> - interrupt-parent: the phandle to the interrupt controller which 
> provides
>                     the interrupt.
> - interrupts: interrupt specification for data-ready.
>
> Instead of irq-gpio
>
>> +
>> +Examples:
>> +
>> +    tas2770@4c {
>> +                compatible = "ti,tas2770";
>> +                reg = <0x4c>;
>
> Missing
>
> #address-cells = <1>;
>
> #size-cells = <0>;
>
>> +                reset-gpio = <&gpio15 1 GPIO_ACTIVE_LOW>;
>> +                irq-gpio = <&gpio16 1 GPIO_ACTIVE_LOW>;
>> +                ti,asi-format = <0>;
>> +                ti,left-slot = <0>;
>> +                ti,right-slot = <1>;
>> +                ti,imon-slot-no = <0>;
>> +                ti,vmon-slot-no = <2>;
>> +        };
>> +
>
> Suggestion to provide the URL to the data sheet.
>
