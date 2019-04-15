Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF1C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A8C20693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SZ99pled"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfDONOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:14:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34929 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbfDONOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:14:00 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FDD03K016272;
        Mon, 15 Apr 2019 15:13:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=pVfFlkSPFP7dS9+W0jKtlwvszZ1b6U8ZRRT6weF36T8=;
 b=SZ99pled915rPvUgPw4f/vfqrTZBfEeCTHTr1TrOHHMGH0nd2XRiSf1lIZJzH/2QpIc2
 CzzBlw4vV52zU9hRGmawCSElOxF5G+rGad2pAbp+Y4fOyrlillYVv1Cqx3rXkDJQWwPL
 mh+tQmLyj2TbCBPMfj93OSa6EVy721l/T4dqnLRwJtLE8pUVkgUCIVm8ZNM2Md8RTlwL
 r0dvmj2w1oXeCghlVuoCUUnVdYT8pr46UEheDzshR8KovdmHdjsPx9ylbB1MAm+iYmRl
 TqVynr1cgcQFme26L211MQS6nee3bFPEWFAT4G/Sr+hohKmewzrGrECLRxh7p7yhASRS cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ru5hu2b6r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Apr 2019 15:13:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E6D734;
        Mon, 15 Apr 2019 13:13:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD0572557;
        Mon, 15 Apr 2019 13:13:44 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Apr
 2019 15:13:44 +0200
Subject: Re: linux-next: Tree for Apr 8 (iio/adc/)
To:     Jonathan Cameron <jic23@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
References: <20190408154140.515139e3@canb.auug.org.au>
 <47db3c7b-eb05-c4cd-ed03-f03e6754d5f8@infradead.org>
 <20190414133059.4e25a574@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b28b147f-0f42-3829-ff5a-aeb9ad0cc249@st.com>
Date:   Mon, 15 Apr 2019 15:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414133059.4e25a574@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/19 2:30 PM, Jonathan Cameron wrote:
> On Mon, 8 Apr 2019 09:09:37 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 4/7/19 10:41 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20190405:
>>>   
>>
>> on i386 or x86_64:
>>
>> modular:
>> ERROR: "is_stm32_timer_trigger" [drivers/iio/adc/stm32-dfsdm-adc.ko] undefined!
>>
>> or builtin:
>> ld: drivers/iio/adc/stm32-dfsdm-adc.o: in function `stm32_dfsdm_postenable':
>> stm32-dfsdm-adc.c:(.text+0x878): undefined reference to `is_stm32_timer_trigger'
>>
>>
>> Full i386 randconfig file is attached.
>>
> Thanks Randy.
> 
> So two possible fixes for this one.  We can do what is done for the
> stm32-adc driver and select IIO_STM_TIMER_TRIGGER or we can add a stub
> for this function in the header to make it return false if that
> driver isn't built.
> 
> I personally favour the stub option but would like Fabrice to say what
> makes more sense.
> 
> So Fabrice, which of the above? If you are busy and don't get back
> in the next day or two, I'll add the stub.

Hi Jonathan, Randy,

I've posted 3 patches:
- One to fix the current issue, with the stub option [1]. This makes
sense as the STM32 DFSDM can use timer and/or lptimer. I think I'll post
another patch later to remove the select in STM32_ADC config (no longer
needed then... But it's not the subject here, right ?).
- Two other patches to fix other warning/build issues I've seen while
working on the stub option. See [2]:

[1] https://lkml.org/lkml/2019/4/15/223
[2] https://lkml.org/lkml/2019/4/15/437

Sorry for the inconvenience, I should have seen this earlier.

Thanks,
Best Regards,
Fabrice

> 
> Thanks,
> 
> Jonathan
> 
