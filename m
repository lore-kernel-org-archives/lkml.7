Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2FAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603BF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hdHXeNjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfGaOkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:40:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727073AbfGaOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:40:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VEcGiP031653;
        Wed, 31 Jul 2019 16:40:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=AFDZi45NFu0boqD+CAnY4m7Y5fAiIfy1q8BHKSUyjP8=;
 b=hdHXeNjda3sh2xQpndsqpigl53QQIGQeef4AE++pk6q4aoeHiWh4VNKighKTmboeWN0J
 6fdMVK8oo3aD76eXZDTqCdan5VGuA/8a8l47Hdpoq2C+fQEV2x+NiSkxCUPuZTCwzVpa
 s2205slvDSMfpooFTvRZz2/fNEA9YAKwhs3HgjxQi1wcgnyE2MWvMQFmuKooddl5eIZU
 NAmH6KAYsQ9dQujJ4EqJqimHdx+hMtsHrfAdw0YQpofH9Y3sUHlSsIpPFJlUus9eMbT7
 SbI0D63j2Pz5emFhBr1VnYyEr8fLiIMGMEhFVzUWElaZBdbIghP9Enysptia3K0tUkgL OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0bra5253-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 16:40:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09B0D41;
        Wed, 31 Jul 2019 14:40:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF58FAE6AC;
        Wed, 31 Jul 2019 16:40:18 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 31 Jul
 2019 16:40:18 +0200
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
To:     Olof Johansson <olof@lixom.net>
CC:     Patrice CHOTARD <patrice.chotard@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190729135505.15394-1-patrice.chotard@st.com>
 <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
 <de6ab910-380e-6271-88d8-6fe670525e60@st.com>
 <CAOesGMgi2cLUZGZnzKY+4i2tZSFyLe2TEK5SPY5yu0qSh_BRxg@mail.gmail.com>
 <CAOesGMirq=42Cj4kT=dLSqUiG-yee5zuqFhg5t=ud5KPmQJYBw@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <ce2b0a2f-6775-1318-1537-eae3ad4e63fd@st.com>
Date:   Wed, 31 Jul 2019 16:40:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMirq=42Cj4kT=dLSqUiG-yee5zuqFhg5t=ud5KPmQJYBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/19 3:21 PM, Olof Johansson wrote:
> On Wed, Jul 31, 2019 at 3:20 PM Olof Johansson <olof@lixom.net> wrote:
>>
>> Hi,
>>
>> On Wed, Jul 31, 2019 at 8:48 AM Alexandre Torgue
>> <alexandre.torgue@st.com> wrote:
>>>
>>> Hi Olof
>>>
>>> On 7/30/19 7:36 PM, Olof Johansson wrote:
>>>> Hi Patrice,
>>>>
>>>> If you cc soc@kernel.org on patches you want us to apply, you'll get
>>>> them automatically tracked by patchwork.
>>>>
>>>
>>> Does it means that you will take it directly in arm-soc tree ?
>>> I mean, I used to take this kind of patch (multi-v7_defconfig patch
>>> linked to STM32 driver) in my stm32 branch and to send PR for them.
>>
>> You can do that too -- it was unclear to me whether you posted the
>> patch with us in the To: line because you wanted it applied or not.
> 
> Also, we request that platform maintainers keep the defconfig updates
> in a separate branch, since we normally track them in a separate
> branch on our side. So if you do it in the future, please send
> separate PR.
> 
> For single patches, it's just as easy to send us the patch as a pull request.
> 

Ok. So I'll continue as I did :)

Thanks for clarifications

Alex

> 
> Thanks,
> 
> -Olof
> 
