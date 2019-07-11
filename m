Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A253C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1BD21721
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZJheqB/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfGKHRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:17:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40694 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfGKHRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:17:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6B7H5iV123685;
        Thu, 11 Jul 2019 02:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562829425;
        bh=0QBVygmwVoVpArXy+0GSkwrp5nxvHuYA5RBaCVFjx2Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZJheqB/GGT+3Qb6IaigPrlfbROfkgmpz01l7kwU4gZmw7jJOZNbtA8yr8+nnwLtSi
         snuq+QQne4StSqvEhrb5TC5ominD4zhoESey9fGqHpIix6BBFTFNvGJWzRXXOQWapx
         sWXh3BUqcDK2fAnpIF48sokoBPhMRvn7DtpmS+T4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6B7H5HA015004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jul 2019 02:17:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Jul 2019 02:17:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Jul 2019 02:17:04 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6B7H2IB023513;
        Thu, 11 Jul 2019 02:17:02 -0500
Subject: Re: [PATCH v2] arm64: Kconfig.platforms: Enable GPIO_DAVINCI for
 ARCH_K3
To:     Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <will.deacon@arm.com>, <catalin.marinas@arm.com>,
        <shawnguo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>
References: <20190627110920.15099-1-j-keerthy@ti.com>
 <20190627143208.eeca4xyygml7s4n3@kahuna>
 <39f5e726-8542-b650-3bdb-7542e8fab8ac@ti.com>
 <20190628203752.rdb6vvc42qd5ofgd@kahuna>
 <ff0b4d00-046f-1ba6-b31e-e49197ba1050@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <41475b80-4a9a-b594-7f66-5bf9b94c0bf0@ti.com>
Date:   Thu, 11 Jul 2019 10:16:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ff0b4d00-046f-1ba6-b31e-e49197ba1050@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2019 08:49, Keerthy wrote:
> 
> 
> On 29/06/19 2:07 AM, Nishanth Menon wrote:
>> On 09:08-20190628, Keerthy wrote:
>> [..]
>>>>> +    select GPIO_SYSFS
>>>>> +    select GPIO_DAVINCI
>>>>
>>>>
>>>> Could you help explain the logic of doing this? commit message is
>>>> basically the diff in English. To me, this does NOT make sense.
>>>>
>>>> I understand GPIO_DAVINCI is the driver compatible, but we cant do 
>>>> this for
>>>> every single SoC driver that is NOT absolutely mandatory for basic
>>>> functionality.
>>>
>>> In case of ARM64 could you help me find the right place to enable
>>> such SoC specific configs?
>>
>> Is'nt that what defconfig is supposed to be all about?
>>
>> arch/arm64/configs/defconfig
>>
>>>
>>>>
>>>> Also keep in mind the impact to arm64/configs/defconfig -> every single
>>>> SoC in the arm64 world will be now rebuild with GPIO_SYSFS.. why force
>>>> that?
>>>
>>> This was the practice in arm32 soc specific configs like
>>> omap2plus_defconfig. GPIO_SYSFS was he only way to validate. Now i 
>>> totally
>>> understand your concern about every single SoC rebuilding but now 
>>> where do
>>> we need to enable the bare minimal GPIO_DAVINCI config?
>>
>> Well, SYSFS, I cannot agree testing as the rationale in
>> Kconfig.platform. And, looking at [1], I see majority being mandatory
>> components for the SoC bootup. However, most of the "optional" drivers
>> go into arm64 as defconfig (preferably as a module?) and if you find a
>> rationale for recommending DEBUG_GPIO, you could propose that to the
>> community as well.
>>
>> Now, Thinking about this, I'd even challenge the current list of 
>> configs as
>> being "select". I'd rather do an "imply"[2] - yes, you need this for the
>> default dtb to boot, however a carefully carved dtb could boot with
>> lesser driver set to get a smaller (and less functional) kernel.
>>
>>>
>>> v1 i received feedback from Tero to enable in Kconfig.platforms. Hence i
>>> shifted to this approach.
>>
>> I noticed that you were posting a v2, for future reference, please use
>> diffstat section to point to lore/patchworks link to point at v1 (I
>> did notice you mentioned you had an update, thanks - link will help
>> catch up on older discussions). This helps a later revision reviewer
>> like me to get context.
>>
>> Tero, would you be able to help with a better rationale as to where the
>> boundaries are to be in your mind, rather than risk every single
>> peripheral driver getting into ARCH_K3?
> 
> Tero,
> 
> Could you point me to a better place for enabling?
> 

Well, thinking about what Nishanth said, we should probably keep the 
defconfig to bare minimal and only enable peripherals that are 
absolutely necessary for boot. We should eventually support eth / mmc-sd 
boot modes for K3 devices, but limit the configs to that.

Rest we can carry within TI internal defconfigs, including this GPIO 
enabler. If GPIO becomes a must have for some future device / 
peripheral, we can re-consider this.

-Tero

> - Keerthy
> 
>>
>> As of right now, I'd rather we do not explode the current list out of
>> bounds. NAK unless we can find a better rationale.
>>
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig.platforms 
>>
>> [2] https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
