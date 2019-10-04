Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E695CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E032133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbfJDPfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:35:54 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:36052 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbfJDPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:35:53 -0400
Received: from localhost (unknown [192.168.167.159])
        by lucky1.263xmail.com (Postfix) with ESMTP id 789145D238;
        Fri,  4 Oct 2019 23:35:07 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.105] (unknown [220.200.58.210])
        by smtp.263.net (postfix) whith ESMTP id P1804T140286170752768S1570203303468576_;
        Fri, 04 Oct 2019 23:35:04 +0800 (CST)
X-UNIQUE-TAG: <6cb28cb4058574c829144504cfbbc6dd>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 220.200.58.210
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_fix_Roc?=
 =?UTF-8?B?a1BybzY0IHNkbW1jIHNldHRpbmdz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?Q?ux-rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfr?=
 =?UTF-8?B?YWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Robin Murphy <robin.murphy@arm.com>, Soeren Moch <smoch@web.de>,
        Heiko Stuebner <heiko@sntech.de>
References: <20191003215036.15023-1-smoch@web.de>
 <20191003215036.15023-3-smoch@web.de>
 <31181f3c-20ec-e717-1f7e-8b35cd54d96d@arm.com>
 <a8b20c45-0426-ee42-4efc-52e56ea6bb20@web.de>
 <120e2dbc-55eb-2205-b00f-7e50928ec706@rock-chips.com>
 <1c452b8b-853f-8f58-5f3a-0bbecbe20557@web.de>
 <fc7dce53-ad39-26e3-7c19-ab60ff4cc332@arm.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <0c6fdb65-be2a-68e3-a686-14ce9b0a00a4@rock-chips.com>
Date:   Fri, 4 Oct 2019 23:33:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fc7dce53-ad39-26e3-7c19-ab60ff4cc332@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/4 22:20, Robin Murphy wrote:
> On 04/10/2019 04:39, Soeren Moch wrote:
>>
>>
>> On 04.10.19 04:13, Shawn Lin wrote:
>>> On 2019/10/4 8:53, Soeren Moch wrote:
>>>>
>>>>
>>>> On 04.10.19 02:01, Robin Murphy wrote:
>>>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>>>> controller is
>>>>>> connected to a microSD (TF card) slot, which cannot be switched to
>>>>>> 1.8V.
>>>>>
>>>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical to the
>>>>> NanoPC-T4 schematic (it's the same reference design, after all), and I
>>>>> know that board can happily drive a UHS-I microSD card with 1.8v I/Os,
>>>>> because mine's doing so right now.
>>>>>
>>>>> Robin.
>>>> OK, the RockPro64 does not allow a card reset (power cycle) since
>>>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
>>>> SDMMC0_PWH_H signal is not connected. So the card fails to identify
>>>> itself after suspend or reboot when switched to 1.8V operation.
> 
> Ah, thanks for clarifying - I did overlook the subtlety that U12 and 
> friends have "NC" as alternative part numbers, even though they aren't 
> actually marked as DNP. So it's still not so much "cannot be switched" 
> as "switching can lead to other problems".
> 
>>>
>>> I believe we addressed this issue long time ago, please check:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a11fc47f175c8d87018e89cb58e2d36c66534cb 
>>>
>>>
>> Thanks for the pointer.
>> In this case I guess I should use following patch instead:
>>
>> --- rk3399-rockpro64.dts.bak    2019-10-03 22:14:00.067745799 +0200
>> +++ rk3399-rockpro64.dts    2019-10-04 00:02:50.047892366 +0200
>> @@ -619,6 +619,8 @@
>>       max-frequency = <150000000>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
>> +    sd-uhs-sdr104;
>> +    vqmmc-supply = <&vcc_sdio>;
>>       status = "okay";
>>   };
>> When I do so, the sd card is detected as SDR104, but a reboot hangs:
>>
>> Boot1: 2018-06-26, version: 1.14
>> CPUId = 0x0
>> ChipType = 0x10, 286
>> Spi_ChipId = c84018
>> no find rkpartition
>> SpiBootInit:ffffffff
>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>> mmc: ERROR: Card did not respond to voltage select!
>> emmc reinit
>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>> mmc: ERROR: Card did not respond to voltage select!
>> emmc reinit
>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>> mmc: ERROR: Card did not respond to voltage select!
>> SdmmcInit=2 1
>> mmc0:cmd5,32
>> mmc0:cmd7,32
>> mmc0:cmd5,32
>> mmc0:cmd7,32
>> mmc0:cmd5,32
>> mmc0:cmd7,32
>> SdmmcInit=0 1
>>
>> So I guess I should use a different miniloader for this reboot to work!?
>> Or what else could be wrong here?
> 
> Hmm, I guess this is "the Tinkerboard problem" again - the patch above 
> would be OK if we could get as far as the kernel, but can't help if the 

I didn't realize that SD was used as boot medium for RockPro64, but I
did patch the vendor tree to solve the issue for Tinkerboard, see
https://github.com/rockchip-linux/kernel/commit/a4ccde21f5a9f04f996fb02479cb9f16d3dc8dc0

My initial plan was to patching upstream kernel by adding ->shutdown,but
never finish it.

> offending card is itself the boot medium. There was a proposal here:
> 
> https://patchwork.kernel.org/patch/10817217/

This RFC also looks good to me, but seems it needs volunteers
to push it again.

> 
> although I'm not sure what if any progress has been made since then.
> 
> Robin.
> 
> 
> 


-- 
Best Regards
Shawn Lin


