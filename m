Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCRJVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:21:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25257 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfCRJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:21:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2I9L6f5026116;
        Mon, 18 Mar 2019 10:21:27 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r8qsxavxb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Mar 2019 10:21:27 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4124C34;
        Mon, 18 Mar 2019 09:21:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 149FC28F6;
        Mon, 18 Mar 2019 09:21:26 +0000 (GMT)
Received: from [10.48.1.93] (10.75.127.46) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Mar
 2019 10:21:25 +0100
Subject: Re: [PATCH v1 2/3] ARM: dts: stm32: enable Vivante GPU support on
 stm32mp157c-ed1 board
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
 <1550247269.2546.58.camel@pengutronix.de>
 <2cf49be6-474d-350b-8dfd-3fe1bf38af3a@st.com>
Message-ID: <2dcacbfb-2306-5147-b2d3-43be27319e5a@st.com>
Date:   Mon, 18 Mar 2019 10:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2cf49be6-474d-350b-8dfd-3fe1bf38af3a@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

I'm going to resend a new version on this DT. I have to move this region elsewhere.

However I didn't get your feedback about statement I did.
Would it be possible to have your feelings ?

Thanks :)

On 2/25/19 4:57 PM, Pierre Yves MORDRET wrote:
> Hi again,
> 
> On 2/15/19 5:14 PM, Lucas Stach wrote:
>> Am Freitag, den 15.02.2019, 16:58 +0100 schrieb Pierre-Yves MORDRET:
>>> Enable Vivante GPU driver for stm32mp157c-ed1 board.
>>>
>>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>>> ---
>>>  arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts
>>> b/arch/arm/boot/dts/stm32mp157c-ed1.dts
>>> index 98ef7a0..792f402 100644
>>> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
>>> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
>>> @@ -20,6 +20,17 @@
>>>  		reg = <0xC0000000 0x40000000>;
>>>  	};
>>>  
>>> +	reserved-memory {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges;
>>> +
>>> +		gpu_reserved: gpu@f8000000 {
>>> +			reg = <0xf8000000 0x8000000>;
>>> +			no-map;
>>> +		};
>>> +	};
>>> +
>>
>> I don't think you need this. The GPU driver uses very little contig dma
>> memory. Most of the GPU memory is ordinary paged memory, so setting
>> aside a private memory region of this size is a waste of memory. Most
>> likely you can just allow the GPU driver to use the system global CMA
>> region.
> 
> That's correct, but this memory area is also used for U-BOOT splash screen
> rendering.
> Moreover, even if we lack of proof as for today, it turns out performances are
> better with this region as reduces MMU accesses (with Vivante driver)
> Eventually using Android framework application is started more gently whatever
> previous application and CMA status(fragmentation).
> Provided this memory, CMA region is decreased accordingly.
> 
> Hope it clarifies.
> 
> Regards
>>
>> Regards,
>> Lucas
>>
>>
>>>  	aliases {
>>>  		serial0 = &uart4;
>>>  	};
>>> @@ -53,6 +64,11 @@
>>>  	status = "okay";
>>>  };
>>>  
>>> +&gpu {
>>> +	contiguous-area = <&gpu_reserved>;
>>> +	status = "okay";
>>> +};
>>> +
>>>  &i2c4 {
>>>  	pinctrl-names = "default";
>>>  	pinctrl-0 = <&i2c4_pins_a>;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
