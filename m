Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19238C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00E22084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfCZJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:19:56 -0400
Received: from asrmicro.com ([210.13.118.86]:55188 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCZJT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:19:56 -0400
Received: from [10.1.170.171] (10.1.170.171) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 26 Mar
 2019 17:19:23 +0800
Subject: Re: [PATCH] arm64: add support for ASR AquilaC SoC
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>
References: <1553389083-13237-1-git-send-email-qiaozhou@asrmicro.com>
 <20190326081251.GE32613@kadam>
From:   qiaozhou <qiaozhou@asrmicro.com>
Message-ID: <5f777fcb-291a-3144-9674-cb81848a4a85@asrmicro.com>
Date:   Tue, 26 Mar 2019 17:19:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326081251.GE32613@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/26 下午4:12, Dan Carpenter wrote:
> 
> I'm not the right person to send this to...
> 
> $ ./scripts/get_maintainer.pl -f arch/arm64/Kconfig.platforms
> Catalin Marinas <catalin.marinas@arm.com> (maintainer:ARM64 PORT (AARCH64 ARCHITECTURE))
> Will Deacon <will.deacon@arm.com> (maintainer:ARM64 PORT (AARCH64 ARCHITECTURE))
> linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE))
> linux-kernel@vger.kernel.org (open list)
I'll send to Will and Catalin next time.
> 
> 
> On Sun, Mar 24, 2019 at 08:58:03AM +0800, qiaozhou wrote:
>> From: Qiao Zhou <qiaozhou@asrmicro.com>
>>
>> Add ARCH_ASR
> 
> You'll need to expand this.
Yes, I'll add more description.
> 
>>
>> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
>                   ^^^^^^^^
> Use Qiao Zhou so it matches the From header.
ok.
> 
> 
>> ---
>>   arch/arm64/Kconfig.platforms | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 70498a0..da8d43a 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -278,4 +278,10 @@ config ARCH_ZYNQMP
>>   	help
>>   	  This enables support for Xilinx ZynqMP Family
>>   
>> +config ARCH_ASR
>> +	bool "ASR Microelectronics chip Family"
>> +	select PINCTRL
>> +	help
>> +	  This enables support for ASR Microelectronics chip Family, including:
>> +	  - ASR 8751C SoC
>>   endmenu
> 
> Was this supposed to be part of the patch you sent earlier?  You will
> need to resend that one as a v2 patch.
Yes. I'll send a v2 patch. thanks a lot for reviewing.
> 
> regards,
> dan carpenter
> 
