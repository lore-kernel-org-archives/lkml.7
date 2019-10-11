Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B924ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C48D214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="i1AIlfAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfJKOQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:16:38 -0400
Received: from mout.web.de ([212.227.17.11]:47347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfJKOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570803376;
        bh=0DEX5VKWVD9x0e8Dn9x3ribmYstuDtlwcI1P1OnQ6rU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=i1AIlfALDwep6ZQaOUtsSBpdZ1qDGsP6XdYvANP1aNC71Qs1pUctRrbsFeFMgk5l1
         MQPwMkVEecrz8GKQsLtgkglDBNSb7hAkF35oFyH+Ua8S1kdvgCw/kpw/TolKXfgTlH
         sbkwu/UdrwCkCKF8bFt6PuI45JFLPw6lEcuFr6to=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.138.232]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHKO-1iNLYe1XyC-004PiP; Fri, 11
 Oct 2019 16:16:16 +0200
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: fix RockPro64 sdmmc settings
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
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
From:   Soeren Moch <smoch@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c2e6523-dc0a-1ad6-ffd3-7ef63c6f7df9@web.de>
Date:   Fri, 11 Oct 2019 16:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64a7d056-28d0-b6d8-6148-b98b58265c08@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:ZQUTbzEI4Q5cpX8IwRbTN8abRrd/bc+5Mj+9i+H0ysvZ6N964S5
 xt6UFDf8NpiC2NjlADMVOWeSpE6f3FUlyDed+SRBGoKnQ+m8Gto1Aj8smtYFxkk0cOY+K4t
 htC04GE/PwkdsmBBKPBI27lFS3cpQEtfEzyBLTteAMxEc5952zJUrZSfu+RHXuur2K3s0AN
 8ex1cWDOdPqQ6x8oeNCow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjAgu2sz3ZE=:dxY8g2JmlpjdGOlBabf7Wt
 1ZO4GbucEpmTjHJg6qt0uol5KjXipm2sIkqAfiDJNw3PI2joaXYM3r1EaK8uKed4cVp2c+FFC
 9teAXPQDB/IdmTYdnobxIftyo1LxCC1vIM09pWfgSeo4Z9C7T8Osk7WOx6tawy04KsXnpGVhD
 gywzKa3zzaJJ2U2ftQcehxP77IoT0+dLBG2hUeyBahpwBquApAksDwwkURVXaE6/VAOL960Z1
 c4Gs7/cksMyxXZFC9r6BO/R07yz9XJblQQU1AO3YUN02XbaZ0SWZeIG9IANt/O9X9dztQ1Hxw
 SXFyCUPG71tLhgPc0Ez/m9N8298DOfvZXVZaFydCR4qntOmAqykqWQyQVVhEV+w+jrUG6m8dy
 0WJEd+Be2Qw0Go8s7W1SBNJTIXsbTF3hZkSYMnwmHfE8anUy+6/r0BODHEeEsvvnghtWkcAze
 HQFyCqdzWCZWma6KhHQL8uaGC+zo2RS550dprwTwo4nt5yI3/mK77CqmY6Biqfd3G/lTM/8Bv
 +J1U4l3sRqA5jcOeBojvI7sTfr+8348AttU7JrQkD8IgLckE9ORxvqakpIIYwU9xaLUdKfLkD
 R0Sv7tMqT+N2aONkrZwBDcwDLfiiEsxObBSEr4ls6VS+kpCfW3HSjgnMA1nQklBXJHspcdhjD
 Kg5uONFNr4AROTyUPtsrAL9npJZHhhGQ++N5vSMSe6jbBrUYl0IU5jvPiXsmudtZ5kE7aqz+0
 gmcUgIKW3EpEaRZuBowrNsAENZmMYI3j618aVj2fYJCpYyEudy99168SAHhIPYYiLpZgaygFK
 IUUvW4lhb2E7sxD5SQdJwcHFPQdwMk4E2TqgBlPbQJflfSHcArU6Klu9YlI3uJ9NpZQ/CvggN
 W3whHTHWadG3INX/MmlKvPux9vFYh+F94xFvf2q+EoeYs6F16T1pEfXO+K1VCdMgJWbzWXphU
 Z456j7GxHEG0jhjWoCK452MRtAcsq0fL+yzRw4S/bq/ma3yCmL9ywRMA/AAS8W6bj1nQ7ci0d
 tbyubmCpdPbs2xI5215MYWNR9d3twTiPK3TMqS7cP3PQslH51qCqzuf+1pdwrebeLPgaZKuue
 Ec+NuP5wTRbPE63o8t5m1UrgxDHMkKDSk1J8IP6gTenEEwG2ddyhl1lcZM4lpqq9tT/Fo7xeY
 JqCzmrD+33vZHCzNWl4xkzj2xj2XHqy8hTx1KLMlrsN8Npy7VAShV1/WVnfFXTgN/xpjpxpOI
 8n9GBan8+a+j/sa3mAm9xiDpHa1kI/oNRdKaOTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.19 15:00, Robin Murphy wrote:
> On 11/10/2019 12:40, Soeren Moch wrote:
>> On 11.10.19 10:22, Jonas Karlman wrote:
>>> On 2019-10-04 19:24, S=C3=B6ren Moch wrote:
>>>> On 04.10.19 17:33, Shawn Lin wrote:
>>>>> On 2019/10/4 22:20, Robin Murphy wrote:
>>>>>> On 04/10/2019 04:39, Soeren Moch wrote:
>>>>>>> On 04.10.19 04:13, Shawn Lin wrote:
>>>>>>>> On 2019/10/4 8:53, Soeren Moch wrote:
>>>>>>>>> On 04.10.19 02:01, Robin Murphy wrote:
>>>>>>>>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>>>>>>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>>>>>>>>> controller is
>>>>>>>>>>> connected to a microSD (TF card) slot, which cannot be
>>>>>>>>>>> switched to
>>>>>>>>>>> 1.8V.
>>>>>>>>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical
>>>>>>>>>> to the
>>>>>>>>>> NanoPC-T4 schematic (it's the same reference design, after all=
),
>>>>>>>>>> and I
>>>>>>>>>> know that board can happily drive a UHS-I microSD card with 1.=
8v
>>>>>>>>>> I/Os,
>>>>>>>>>> because mine's doing so right now.
>>>>>>>>>>
>>>>>>>>>> Robin.
>>>>>>>>> OK, the RockPro64 does not allow a card reset (power cycle) sin=
ce
>>>>>>>>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the=

>>>>>>>>> SDMMC0_PWH_H signal is not connected. So the card fails to
>>>>>>>>> identify
>>>>>>>>> itself after suspend or reboot when switched to 1.8V operation.=

>>>>>> Ah, thanks for clarifying - I did overlook the subtlety that U12 a=
nd
>>>>>> friends have "NC" as alternative part numbers, even though they
>>>>>> aren't actually marked as DNP. So it's still not so much "cannot b=
e
>>>>>> switched" as "switching can lead to other problems".
>>>>>>
>>>>>>>> I believe we addressed this issue long time ago, please check:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>> Thanks for the pointer.
>>>>>>> In this case I guess I should use following patch instead:
>>>>>>>
>>>>>>> --- rk3399-rockpro64.dts.bak =C2=A0=C2=A0 2019-10-03 22:14:00.067=
745799 +0200
>>>>>>> +++ rk3399-rockpro64.dts=C2=A0=C2=A0=C2=A0 2019-10-04 00:02:50.04=
7892366 +0200
>>>>>>> @@ -619,6 +619,8 @@
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000=
>;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";=

>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &s=
dmmc_cmd &sdmmc_bus4>;
>>>>>>> +=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
>>>>>>> +=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>>>>>> =C2=A0=C2=A0=C2=A0};
>>>>>>> When I do so, the sd card is detected as SDR104, but a reboot
>>>>>>> hangs:
>>>>>>>
>>>>>>> Boot1: 2018-06-26, version: 1.14
>>>>>>> CPUId =3D 0x0
>>>>>>> ChipType =3D 0x10, 286
>>>>>>> Spi_ChipId =3D c84018
>>>>>>> no find rkpartition
>>>>>>> SpiBootInit:ffffffff
>>>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>>>> emmc reinit
>>>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>>>> emmc reinit
>>>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>>>> SdmmcInit=3D2 1
>>>>>>> mmc0:cmd5,32
>>>>>>> mmc0:cmd7,32
>>>>>>> mmc0:cmd5,32
>>>>>>> mmc0:cmd7,32
>>>>>>> mmc0:cmd5,32
>>>>>>> mmc0:cmd7,32
>>>>>>> SdmmcInit=3D0 1
>>>>>>>
>>>>>>> So I guess I should use a different miniloader for this reboot to=

>>>>>>> work!?
>>>>>>> Or what else could be wrong here?
>>>>>> Hmm, I guess this is "the Tinkerboard problem" again - the patch
>>>>>> above would be OK if we could get as far as the kernel, but can't
>>>>>> help if the
>>>>> I didn't realize that SD was used as boot medium for RockPro64, but=
 I
>>>>> did patch the vendor tree to solve the issue for Tinkerboard, see
>>>>> https://github.com/rockchip-linux/kernel/commit/a4ccde21f5a9f04f996=
fb02479cb9f16d3dc8dc0
>>>>>
>>>>>
>>>>>
>>>>> My initial plan was to patching upstream kernel by adding
>>>>> ->shutdown,but
>>>>> never finish it.
>>>>>
>>>>>> offending card is itself the boot medium. There was a proposal her=
e:
>>>>>>
>>>>>> https://patchwork.kernel.org/patch/10817217/
>>>>> This RFC also looks good to me, but seems it needs volunteers
>>>>> to push it again.
>>>> Oh, I think this is a totally wrong way.
>>>>
>>>> While this might work for some cards, setting the controller's i/o
>>>> voltage to 3.3V while leaving the card at 1.8V configuration is
>>>> totally
>>>> against the specification, can lead to all kinds of strange behaviou=
r
>>>> and even cause hardware damage. It also would actively defend the
>>>> purpose of the above mentioned patch (6a11fc4) where the kernel
>>>> guesses
>>>> the i/o voltage from the card configuration and switches the
>>>> controller
>>>> accordingly. We would end up with a 1.8V card and controller
>>>> configuration and a regulator voltage of 3.3V. This would only work
>>>> with
>>>> good luck. Even if the kernel driver would switch the regulator
>>>> back to
>>>> 1.8V in this case, the voltage mismatch remains in the bootloader wh=
en
>>>> this card contains the boot image.
>>>>
>>>> The only sane way I see to handle this is implementing the same
>>>> workaround (mode guessing) also in the bootloader (rockchip miniload=
er
>>>> and u-boot SPL since both bootloader chains are supported for this
>>>> board).
>>>>
>>>> Or maybe I miss something?
>>> Thanks for your input, I have made a new series [1] with a similar
>>> approach but is limited to dw_mmc-rockchip
>>> and only changes the regulator at power_off after the regulator has
>>> been disabled (the vqmmc regulator in affected devices is always-on).=

>> Thanks for your work on this. Unfortunately I still think that this is=

>> the wrong approach.
>> I see several problems in your patch series:
>> - You introduced GPIO0_PA1 as regulator enable for RockPro64.
>> Unfortunately Pine64 decided to disable this regulator on Board Versio=
n
>> 2.1 (real product version), see above. I have no idea why they did thi=
s.
>> - You changed the i/o voltage from 3.0V to 3.3V. This is not allowed o=
n
>> RK3399 I/O bank F.
>>
>> Changing the i/o voltage to 3.0V/3.3V while the sd card is configured
>> for 1.8V is against the specification and dangerous. While experimenti=
ng
>> with different images (ayufan, armbian) for my newly bought RockPro64 =
I
>> killed a SD card (32GB Samsung UHS-I). I cannot reconstruct the exact
>> circumstances, but I'm pretty sure this happened due to the voltage
>> mismatch. Of course I'm not keen to experiment further with this and
>> kill more sd cards. This is not just an theoretical issue.
>>> To my knowledge the problem is not with the rockchip miniloader or
>>> u-boot SPL, it is the initial boot rom that tries to load
>>> the miniloader/SPL from a SD-card, so nothing that can be updated.
>> What I observed on my RockPro64:
>> The ROM bootloader always was able to load the next stage, maybe due t=
o
>> the low initial clock of 400kHz? Also the ROM bootloader cannot change=

>> voltage regulator settings. So if the i/o voltage still is at 1.8V and=

>> matching the sd card setting, there is no problem for the ROM
>> bootloader.
>
> Hmm, that makes me wonder if the problem might be not so much that the
> level of SDMMC0_VDD itself stays at 1.8V, but that at some point after
> the bootrom the GRF_IO_VSEL bit gets reset so the controller just
> stops being able to read anything as logic-high.
Would be great if someone from Rockchip could give some insights whether
and when during reboot GRF_IO_VSEL is reset (ATF before reboot, some SoC
soft-reset, ROM bootloader, rkminiloader, something different), Shawn?
Or gets this VSEL changed only when switching the voltage regulator (via
io_domains,sdmmc-supply)?

Soeren
>
> Robin.
>
>> So I think the normal reboot handling should be:
>> If the sd card can be switched off (preferred solution), do so and res=
et
>> the controller i/o voltage to 3.0V/3.3V.
>> If the sd card can not be switched off, make sure to leave the
>> controller i/o voltage at the current setting. Make sure in later boot=

>> stages to not change the controller i/o voltage to 3.0V/3.3V when the
>> card is configured for 1.8V. According to the patch mentioned above th=
is
>> behaviour already is implemented in linux, we also need this for the
>> bootloaders.
>>
>> Regards,
>> Soeren
>>>
>>> I have observed this issue on the following devices, and the patches
>>> at [1] makes it possible to reboot from SD-card after UHS has been
>>> enabled.
>>> - Asus Tinker Board (RK3288)
>>> - Rockchip Sapphire Board (RK3399)
>>> - Radxa Rock Pi 4 (RK3399)
>>> - Pine64 RockPro64 (RK3399)
>>> All of the above seem to use the RK808 regulator for sd io voltage.
>>>
>>> The ROC-RK3328-CC did not have this issue and seem to automatically
>>> reset to 3.3v.
>>>
>>> [1]
>>> https://github.com/Kwiboo/linux-rockchip/compare/next-20191011...next=
-20191011-mmc
>>>
>>> Regards,
>>> Jonas
>>>
>>>> Soeren
>>>>
>>>>
>>>>>> although I'm not sure what if any progress has been made since the=
n.
>>>>>>
>>>>>> Robin.
>>>>>>
>>
>>


