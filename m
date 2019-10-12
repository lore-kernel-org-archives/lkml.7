Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF7C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 04:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C852084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 04:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfJLEJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 00:09:51 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:38616 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJLEJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 00:09:50 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id CA5F16821B;
        Sat, 12 Oct 2019 12:09:39 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P21345T140678380103424S1570853375847707_;
        Sat, 12 Oct 2019 12:09:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7211ccd818c8667b6c08baaec1624c00>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: fix RockPro64 sdmmc settings
To:     Soeren Moch <smoch@web.de>, Robin Murphy <robin.murphy@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>
References: <20191003215036.15023-1-smoch@web.de>
 <20191003215036.15023-3-smoch@web.de>
 <31181f3c-20ec-e717-1f7e-8b35cd54d96d@arm.com>
 <a8b20c45-0426-ee42-4efc-52e56ea6bb20@web.de>
 <120e2dbc-55eb-2205-b00f-7e50928ec706@rock-chips.com>
 <1c452b8b-853f-8f58-5f3a-0bbecbe20557@web.de>
 <fc7dce53-ad39-26e3-7c19-ab60ff4cc332@arm.com>
 <0c6fdb65-be2a-68e3-a686-14ce9b0a00a4@rock-chips.com>
 <e4aaddc2-441b-b835-380e-374a3d935474@web.de>
 <HE1PR06MB40115FDF385886FDDE122CD6AC970@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <13064e01-9472-fc4d-2c7f-c186fa2a9a91@web.de>
 <64a7d056-28d0-b6d8-6148-b98b58265c08@arm.com>
 <6c2e6523-dc0a-1ad6-ffd3-7ef63c6f7df9@web.de>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <971537f8-2fe5-9ebe-3f04-9e3d99c915a9@rock-chips.com>
Date:   Sat, 12 Oct 2019 12:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6c2e6523-dc0a-1ad6-ffd3-7ef63c6f7df9@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/11 22:16, Soeren Moch wrote:
> On 11.10.19 15:00, Robin Murphy wrote:
>> On 11/10/2019 12:40, Soeren Moch wrote:
>>> On 11.10.19 10:22, Jonas Karlman wrote:
>>>> On 2019-10-04 19:24, Sören Moch wrote:
>>>>> On 04.10.19 17:33, Shawn Lin wrote:
>>>>>> On 2019/10/4 22:20, Robin Murphy wrote:
>>>>>>> On 04/10/2019 04:39, Soeren Moch wrote:
>>>>>>>> On 04.10.19 04:13, Shawn Lin wrote:
>>>>>>>>> On 2019/10/4 8:53, Soeren Moch wrote:
>>>>>>>>>> On 04.10.19 02:01, Robin Murphy wrote:
>>>>>>>>>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>>>>>>>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>>>>>>>>>> controller is
>>>>>>>>>>>> connected to a microSD (TF card) slot, which cannot be
>>>>>>>>>>>> switched to
>>>>>>>>>>>> 1.8V.
>>>>>>>>>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical
>>>>>>>>>>> to the
>>>>>>>>>>> NanoPC-T4 schematic (it's the same reference design, after all),
>>>>>>>>>>> and I
>>>>>>>>>>> know that board can happily drive a UHS-I microSD card with 1.8v
>>>>>>>>>>> I/Os,
>>>>>>>>>>> because mine's doing so right now.
>>>>>>>>>>>
>>>>>>>>>>> Robin.
>>>>>>>>>> OK, the RockPro64 does not allow a card reset (power cycle) since
>>>>>>>>>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
>>>>>>>>>> SDMMC0_PWH_H signal is not connected. So the card fails to
>>>>>>>>>> identify
>>>>>>>>>> itself after suspend or reboot when switched to 1.8V operation.
>>>>>>> Ah, thanks for clarifying - I did overlook the subtlety that U12 and
>>>>>>> friends have "NC" as alternative part numbers, even though they
>>>>>>> aren't actually marked as DNP. So it's still not so much "cannot be
>>>>>>> switched" as "switching can lead to other problems".
>>>>>>>
>>>>>>>>> I believe we addressed this issue long time ago, please check:
>>>>>>>>>
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>> Thanks for the pointer.
>>>>>>>> In this case I guess I should use following patch instead:
>>>>>>>>
>>>>>>>> --- rk3399-rockpro64.dts.bak    2019-10-03 22:14:00.067745799 +0200
>>>>>>>> +++ rk3399-rockpro64.dts    2019-10-04 00:02:50.047892366 +0200
>>>>>>>> @@ -619,6 +619,8 @@
>>>>>>>>         max-frequency = <150000000>;
>>>>>>>>         pinctrl-names = "default";
>>>>>>>>         pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
>>>>>>>> +    sd-uhs-sdr104;
>>>>>>>> +    vqmmc-supply = <&vcc_sdio>;
>>>>>>>>         status = "okay";
>>>>>>>>     };
>>>>>>>> When I do so, the sd card is detected as SDR104, but a reboot
>>>>>>>> hangs:
>>>>>>>>
>>>>>>>> Boot1: 2018-06-26, version: 1.14
>>>>>>>> CPUId = 0x0
>>>>>>>> ChipType = 0x10, 286
>>>>>>>> Spi_ChipId = c84018
>>>>>>>> no find rkpartition
>>>>>>>> SpiBootInit:ffffffff
>>>>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>>>>> emmc reinit
>>>>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>>>>> emmc reinit
>>>>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>>>>> SdmmcInit=2 1
>>>>>>>> mmc0:cmd5,32
>>>>>>>> mmc0:cmd7,32
>>>>>>>> mmc0:cmd5,32
>>>>>>>> mmc0:cmd7,32
>>>>>>>> mmc0:cmd5,32
>>>>>>>> mmc0:cmd7,32
>>>>>>>> SdmmcInit=0 1
>>>>>>>>
>>>>>>>> So I guess I should use a different miniloader for this reboot to
>>>>>>>> work!?
>>>>>>>> Or what else could be wrong here?
>>>>>>> Hmm, I guess this is "the Tinkerboard problem" again - the patch
>>>>>>> above would be OK if we could get as far as the kernel, but can't
>>>>>>> help if the
>>>>>> I didn't realize that SD was used as boot medium for RockPro64, but I
>>>>>> did patch the vendor tree to solve the issue for Tinkerboard, see
>>>>>> https://github.com/rockchip-linux/kernel/commit/a4ccde21f5a9f04f996fb02479cb9f16d3dc8dc0
>>>>>>
>>>>>>
>>>>>>
>>>>>> My initial plan was to patching upstream kernel by adding
>>>>>> ->shutdown,but
>>>>>> never finish it.
>>>>>>
>>>>>>> offending card is itself the boot medium. There was a proposal here:
>>>>>>>
>>>>>>> https://patchwork.kernel.org/patch/10817217/
>>>>>> This RFC also looks good to me, but seems it needs volunteers
>>>>>> to push it again.
>>>>> Oh, I think this is a totally wrong way.
>>>>>
>>>>> While this might work for some cards, setting the controller's i/o
>>>>> voltage to 3.3V while leaving the card at 1.8V configuration is
>>>>> totally
>>>>> against the specification, can lead to all kinds of strange behaviour
>>>>> and even cause hardware damage. It also would actively defend the
>>>>> purpose of the above mentioned patch (6a11fc4) where the kernel
>>>>> guesses
>>>>> the i/o voltage from the card configuration and switches the
>>>>> controller
>>>>> accordingly. We would end up with a 1.8V card and controller
>>>>> configuration and a regulator voltage of 3.3V. This would only work
>>>>> with
>>>>> good luck. Even if the kernel driver would switch the regulator
>>>>> back to
>>>>> 1.8V in this case, the voltage mismatch remains in the bootloader when
>>>>> this card contains the boot image.
>>>>>
>>>>> The only sane way I see to handle this is implementing the same
>>>>> workaround (mode guessing) also in the bootloader (rockchip miniloader
>>>>> and u-boot SPL since both bootloader chains are supported for this
>>>>> board).
>>>>>
>>>>> Or maybe I miss something?
>>>> Thanks for your input, I have made a new series [1] with a similar
>>>> approach but is limited to dw_mmc-rockchip
>>>> and only changes the regulator at power_off after the regulator has
>>>> been disabled (the vqmmc regulator in affected devices is always-on).
>>> Thanks for your work on this. Unfortunately I still think that this is
>>> the wrong approach.
>>> I see several problems in your patch series:
>>> - You introduced GPIO0_PA1 as regulator enable for RockPro64.
>>> Unfortunately Pine64 decided to disable this regulator on Board Version
>>> 2.1 (real product version), see above. I have no idea why they did this.
>>> - You changed the i/o voltage from 3.0V to 3.3V. This is not allowed on
>>> RK3399 I/O bank F.
>>>
>>> Changing the i/o voltage to 3.0V/3.3V while the sd card is configured
>>> for 1.8V is against the specification and dangerous. While experimenting
>>> with different images (ayufan, armbian) for my newly bought RockPro64 I
>>> killed a SD card (32GB Samsung UHS-I). I cannot reconstruct the exact
>>> circumstances, but I'm pretty sure this happened due to the voltage
>>> mismatch. Of course I'm not keen to experiment further with this and
>>> kill more sd cards. This is not just an theoretical issue.
>>>> To my knowledge the problem is not with the rockchip miniloader or
>>>> u-boot SPL, it is the initial boot rom that tries to load
>>>> the miniloader/SPL from a SD-card, so nothing that can be updated.
>>> What I observed on my RockPro64:
>>> The ROM bootloader always was able to load the next stage, maybe due to
>>> the low initial clock of 400kHz? Also the ROM bootloader cannot change
>>> voltage regulator settings. So if the i/o voltage still is at 1.8V and
>>> matching the sd card setting, there is no problem for the ROM
>>> bootloader.
>>
>> Hmm, that makes me wonder if the problem might be not so much that the
>> level of SDMMC0_VDD itself stays at 1.8V, but that at some point after
>> the bootrom the GRF_IO_VSEL bit gets reset so the controller just
>> stops being able to read anything as logic-high.
> Would be great if someone from Rockchip could give some insights whether
> and when during reboot GRF_IO_VSEL is reset (ATF before reboot, some SoC
> soft-reset, ROM bootloader, rkminiloader, something different), Shawn?

ROM code and miniloader never touch this GRF_IO_VSEL for sdmmc, and only
kernel did since now it support UHS mode. After reboot, the value should
depends on the (value-in-kernel && does-reboot-level-hold-this-reg?)

Different SoCs+PMICs excute differents reboot level policy.


> Or gets this VSEL changed only when switching the voltage regulator (via
> io_domains,sdmmc-supply)?
> 
> Soeren
>>
>> Robin.
>>
>>> So I think the normal reboot handling should be:
>>> If the sd card can be switched off (preferred solution), do so and reset
>>> the controller i/o voltage to 3.0V/3.3V.
>>> If the sd card can not be switched off, make sure to leave the
>>> controller i/o voltage at the current setting. Make sure in later boot
>>> stages to not change the controller i/o voltage to 3.0V/3.3V when the
>>> card is configured for 1.8V. According to the patch mentioned above this
>>> behaviour already is implemented in linux, we also need this for the
>>> bootloaders.
>>>
>>> Regards,
>>> Soeren
>>>>
>>>> I have observed this issue on the following devices, and the patches
>>>> at [1] makes it possible to reboot from SD-card after UHS has been
>>>> enabled.
>>>> - Asus Tinker Board (RK3288)
>>>> - Rockchip Sapphire Board (RK3399)
>>>> - Radxa Rock Pi 4 (RK3399)
>>>> - Pine64 RockPro64 (RK3399)
>>>> All of the above seem to use the RK808 regulator for sd io voltage.
>>>>
>>>> The ROC-RK3328-CC did not have this issue and seem to automatically
>>>> reset to 3.3v.
>>>>
>>>> [1]
>>>> https://github.com/Kwiboo/linux-rockchip/compare/next-20191011...next-20191011-mmc
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>> Soeren
>>>>>
>>>>>
>>>>>>> although I'm not sure what if any progress has been made since then.
>>>>>>>
>>>>>>> Robin.
>>>>>>>
>>>
>>>
> 
> 
> 
> 
> 


