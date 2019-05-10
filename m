Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75130C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FA8217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfEJPLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:11:18 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:59870 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJPLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:11:18 -0400
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id BB0A319F54D;
        Fri, 10 May 2019 17:11:06 +0200 (CEST)
Subject: Re: [PATCHv1 7/8] arm64: dts: qcom: msm8998: Add PSCI cpuidle low
 power states
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <0afe77d25490b10250f9eac4b4e92ccac8c42718.1557486950.git.amit.kucheria@linaro.org>
 <3de9c573-5971-15fc-1632-706fc30e90c2@free.fr>
 <CAP245DU7=h=t1_QoM9nMGE-Amduuh+GPQBnmEEG+NGDdXCiR=g@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8292f259-d28b-9b37-d58e-3afb26da0646@free.fr>
Date:   Fri, 10 May 2019 17:11:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAP245DU7=h=t1_QoM9nMGE-Amduuh+GPQBnmEEG+NGDdXCiR=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 16:12, Amit Kucheria wrote:

> On Fri, May 10, 2019 at 6:45 PM Marc Gonzalez wrote:
>>
>> On 10/05/2019 13:29, Amit Kucheria wrote:
>>
>>> Add device bindings for cpuidle states for cpu devices.
>>>
>>> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>>> index 3fd0769fe648..208281f318e2 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>>> @@ -78,6 +78,7 @@
>>>                        compatible = "arm,armv8";
>>>                        reg = <0x0 0x0>;
>>>                        enable-method = "psci";
>>> +                     cpu-idle-states = <&LITTLE_CPU_PD>;
>>
>> For some reason, I was expecting the big cores to come first, but according
>> to /proc/cpuinfo, cores 0-3 are part 0x801, while cores 4-7 are part 0x800.
>>
>> According to https://github.com/pytorch/cpuinfo/blob/master/src/arm/uarch.c
>>
>> 0x801 = Low-power Kryo 260 / 280 "Silver" -> Cortex-A53
>> 0x800 = High-performance Kryo 260 (r10p2) / Kryo 280 (r10p1) "Gold" -> Cortex-A73
> 
> Hmm, did I mess up the order of the big and LITTLE cores?
> I'll take a look again.

Sorry for being unclear. I was saying I expected the opposite,
but it appears the order in your patch is correct ;-)

Little cores have higher latency (+5%) than big cores?

Regards.
