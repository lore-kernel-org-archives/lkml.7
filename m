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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0790C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FD22190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jPky9ywh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfJKLlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:41:13 -0400
Received: from mout.web.de ([217.72.192.78]:39681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfJKLlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570794049;
        bh=iVzc43ug3QtfI1rmiytmMBv/IwRJnwRtTgk5FTKi8oI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jPky9ywhvFJTZVbHAfYbBWx5B+9jLDKpB1OafjHIRJa16H1vG2sOmmq2ee2xqWO1Z
         mdBmsnYJQY7vSGiK2EqhcOY9HxSmQgyJRRc4W2eALRgV4h4xfayzNqSA1FvDglhiup
         GH38OI5MRsUFkifUpx3jx/bl+t5hKGinyiC3HM5o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.138.232]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUnUe-1iZIcv0e7g-00Y6eI; Fri, 11
 Oct 2019 13:40:49 +0200
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: fix RockPro64 sdmmc settings
To:     Jonas Karlman <jonas@kwiboo.se>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
From:   Soeren Moch <smoch@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <13064e01-9472-fc4d-2c7f-c186fa2a9a91@web.de>
Date:   Fri, 11 Oct 2019 13:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR06MB40115FDF385886FDDE122CD6AC970@HE1PR06MB4011.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:hJzX1PlNsFMkSJz3Dr52GZwbOW+LHfu5MY1JkQGRkbE7n/OyMsY
 0wbwN9O1nubnBmpq08+/CZB/kCjRtjiBOldTlor9ORdbEho/HVgVdfpsL++/rj6aAfpiaun
 uSInhCxvObYd1Ji6kG9e1LJn2ig/ioXmzDra263FE7XcpwR97lUEQdHH6LCOfmRV5w90kHx
 4bth/roahu05h+oMOK6ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NqVqC8bpwjI=:xNgXjkkhEUQ6JVFu7WfBNG
 49GHmXXNsJtw/1oEj6zi2xyLmQDtZEGptTyAJkYImhmPALN5GBSmL4GY4e92N0Lf0dprKf1VA
 HiNI0FlqCMt7Y+swdLYFsB/2yGOqwE1wSgmaopY80jnnA271fbvvoq9940gYm1/HxwPUVEAKx
 5n2/ElzKP6qIOPU9u0S62wxj7Zih2184fwJIEJzNXFUUL6lLc6SnHUR9ktGy8LvK3+dcPzwem
 22VB/bc62cODmsfDn7Hj42R5dxD0+rWTMvgNSsFZ0pVL7gEZ5WDD5L2mGDpbh78jCXogcY9VZ
 K+jIsHupU71Cvzttp+jVPxEGnjrHVp55U6WqsNrz3qlx5KGf9DsLgCZyGKJ7IHiRClOlO20KT
 +kC3gI7xD8fel9kLf7174H1YqrHfJfOmLLTXs9XCkXzOwvGoUjSIgGp+twNYTdw8yM87hTFKJ
 7QFWxIk51/G+6YGoeDwrmsBXhi301DUKXbTU6RddzTp/68qdBPjOxjc3UtqvGhRGNGxIYRaJ4
 hnZ/Gc7834VmD+roKTFf2mbs9+3dd7j1Zd03N9TgDGgIfP7Y6dUQzGip+BD2YnURQo6O4Dof5
 2lh6+NL33qmhlTBRDDaK9enWdDJnJ8XSAlfNOud44q3TrlzZO7j8/rqOQhXjpedvK76wUtKWr
 5rXJssbXjRSa5It8dpv7X33RmfyUhz+hmi9lu7x/QDg3tV56NTTKjJtSko9IyvPp0tM5pzlMP
 UeOv5VmXAQ+mNcy6Mu9dT/WrnQ3OuUBA9AnKbyVFRreQFDv8N8xj1aPyt+o4/P9kDeSaoqero
 408k5zT/hNexlg/OUTh2HhtBXs+0qn07dp8BlJ2sXYXqxWNUis+wdbKbPTGGWqRU8vZ5g6QWd
 JqQjAQtKD/tYJCYAsHpZ9cNIhRXT6WwfUd/NzoRpd0TjhzBU6nsKtZCT0g728m2LH2daKYKA3
 qq2RpoTpuZPQIS2RbJmoWSpXWKHQ9oNmum8kYGWfHKPQs+/oyybjavRvm6bko8ZFlBjElCcFd
 Q5oWL03eT3RdAJoPZrfZgPT3v4Z+Ngmn8jE1pkhh9Tl8sOQtTAPPNDs5Fuv4+19dzsP8X4i9f
 VOljQVDRswysJohrwdwyl41gaEzwamCphTTFCI80uYZDnSmPWfvaOyavCq3avn0ATit9Fa1Dh
 Fqm/8UYRXGjylZhyauhm5GzcdncfA3r0UklFy8R5owuGzAVRnKq7ot04RehE6g5f3+uGzD6Dg
 wSbNMBIA25lOrgNIAcj8aKYSGMO46nz8DHXkMeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.10.19 10:22, Jonas Karlman wrote:
> On 2019-10-04 19:24, S=C3=B6ren Moch wrote:
>> On 04.10.19 17:33, Shawn Lin wrote:
>>> On 2019/10/4 22:20, Robin Murphy wrote:
>>>> On 04/10/2019 04:39, Soeren Moch wrote:
>>>>> On 04.10.19 04:13, Shawn Lin wrote:
>>>>>> On 2019/10/4 8:53, Soeren Moch wrote:
>>>>>>> On 04.10.19 02:01, Robin Murphy wrote:
>>>>>>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>>>>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>>>>>>> controller is
>>>>>>>>> connected to a microSD (TF card) slot, which cannot be switched=
 to
>>>>>>>>> 1.8V.
>>>>>>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical to =
the
>>>>>>>> NanoPC-T4 schematic (it's the same reference design, after all),=

>>>>>>>> and I
>>>>>>>> know that board can happily drive a UHS-I microSD card with 1.8v=

>>>>>>>> I/Os,
>>>>>>>> because mine's doing so right now.
>>>>>>>>
>>>>>>>> Robin.
>>>>>>> OK, the RockPro64 does not allow a card reset (power cycle) since=

>>>>>>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
>>>>>>> SDMMC0_PWH_H signal is not connected. So the card fails to identi=
fy
>>>>>>> itself after suspend or reboot when switched to 1.8V operation.
>>>> Ah, thanks for clarifying - I did overlook the subtlety that U12 and=

>>>> friends have "NC" as alternative part numbers, even though they
>>>> aren't actually marked as DNP. So it's still not so much "cannot be
>>>> switched" as "switching can lead to other problems".
>>>>
>>>>>> I believe we addressed this issue long time ago, please check:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>>>>
>>>>>>
>>>>> Thanks for the pointer.
>>>>> In this case I guess I should use following patch instead:
>>>>>
>>>>> --- rk3399-rockpro64.dts.bak =C2=A0=C2=A0 2019-10-03 22:14:00.06774=
5799 +0200
>>>>> +++ rk3399-rockpro64.dts=C2=A0=C2=A0=C2=A0 2019-10-04 00:02:50.0478=
92366 +0200
>>>>> @@ -619,6 +619,8 @@
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000>;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd=
 &sdmmc_bus4>;
>>>>> +=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
>>>>> +=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>>>> =C2=A0=C2=A0};
>>>>> When I do so, the sd card is detected as SDR104, but a reboot hangs=
:
>>>>>
>>>>> Boot1: 2018-06-26, version: 1.14
>>>>> CPUId =3D 0x0
>>>>> ChipType =3D 0x10, 286
>>>>> Spi_ChipId =3D c84018
>>>>> no find rkpartition
>>>>> SpiBootInit:ffffffff
>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>> emmc reinit
>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>> emmc reinit
>>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>>> mmc: ERROR: Card did not respond to voltage select!
>>>>> SdmmcInit=3D2 1
>>>>> mmc0:cmd5,32
>>>>> mmc0:cmd7,32
>>>>> mmc0:cmd5,32
>>>>> mmc0:cmd7,32
>>>>> mmc0:cmd5,32
>>>>> mmc0:cmd7,32
>>>>> SdmmcInit=3D0 1
>>>>>
>>>>> So I guess I should use a different miniloader for this reboot to
>>>>> work!?
>>>>> Or what else could be wrong here?
>>>> Hmm, I guess this is "the Tinkerboard problem" again - the patch
>>>> above would be OK if we could get as far as the kernel, but can't
>>>> help if the=20
>>> I didn't realize that SD was used as boot medium for RockPro64, but I=

>>> did patch the vendor tree to solve the issue for Tinkerboard, see
>>> https://github.com/rockchip-linux/kernel/commit/a4ccde21f5a9f04f996fb=
02479cb9f16d3dc8dc0
>>>
>>>
>>> My initial plan was to patching upstream kernel by adding ->shutdown,=
but
>>> never finish it.
>>>
>>>> offending card is itself the boot medium. There was a proposal here:=

>>>>
>>>> https://patchwork.kernel.org/patch/10817217/
>>> This RFC also looks good to me, but seems it needs volunteers
>>> to push it again.
>> Oh, I think this is a totally wrong way.
>>
>> While this might work for some cards, setting the controller's i/o
>> voltage to 3.3V while leaving the card at 1.8V configuration is totall=
y
>> against the specification, can lead to all kinds of strange behaviour
>> and even cause hardware damage. It also would actively defend the
>> purpose of the above mentioned patch (6a11fc4) where the kernel guesse=
s
>> the i/o voltage from the card configuration and switches the controlle=
r
>> accordingly. We would end up with a 1.8V card and controller
>> configuration and a regulator voltage of 3.3V. This would only work wi=
th
>> good luck. Even if the kernel driver would switch the regulator back t=
o
>> 1.8V in this case, the voltage mismatch remains in the bootloader when=

>> this card contains the boot image.
>>
>> The only sane way I see to handle this is implementing the same
>> workaround (mode guessing) also in the bootloader (rockchip miniloader=

>> and u-boot SPL since both bootloader chains are supported for this boa=
rd).
>>
>> Or maybe I miss something?
> Thanks for your input, I have made a new series [1] with a similar appr=
oach but is limited to dw_mmc-rockchip
> and only changes the regulator at power_off after the regulator has bee=
n disabled (the vqmmc regulator in affected devices is always-on).
Thanks for your work on this. Unfortunately I still think that this is
the wrong approach.
I see several problems in your patch series:
- You introduced GPIO0_PA1 as regulator enable for RockPro64.
Unfortunately Pine64 decided to disable this regulator on Board Version
2.1 (real product version), see above. I have no idea why they did this.
- You changed the i/o voltage from 3.0V to 3.3V. This is not allowed on
RK3399 I/O bank F.

Changing the i/o voltage to 3.0V/3.3V while the sd card is configured
for 1.8V is against the specification and dangerous. While experimenting
with different images (ayufan, armbian) for my newly bought RockPro64 I
killed a SD card (32GB Samsung UHS-I). I cannot reconstruct the exact
circumstances, but I'm pretty sure this happened due to the voltage
mismatch. Of course I'm not keen to experiment further with this and
kill more sd cards. This is not just an theoretical issue.
> To my knowledge the problem is not with the rockchip miniloader or u-bo=
ot SPL, it is the initial boot rom that tries to load
> the miniloader/SPL from a SD-card, so nothing that can be updated.
What I observed on my RockPro64:
The ROM bootloader always was able to load the next stage, maybe due to
the low initial clock of 400kHz? Also the ROM bootloader cannot change
voltage regulator settings. So if the i/o voltage still is at 1.8V and
matching the sd card setting, there is no problem for the ROM bootloader.=

So I think the normal reboot handling should be:
If the sd card can be switched off (preferred solution), do so and reset
the controller i/o voltage to 3.0V/3.3V.
If the sd card can not be switched off, make sure to leave the
controller i/o voltage at the current setting. Make sure in later boot
stages to not change the controller i/o voltage to 3.0V/3.3V when the
card is configured for 1.8V. According to the patch mentioned above this
behaviour already is implemented in linux, we also need this for the
bootloaders.

Regards,
Soeren
>
> I have observed this issue on the following devices, and the patches at=
 [1] makes it possible to reboot from SD-card after UHS has been enabled.=

> - Asus Tinker Board (RK3288)
> - Rockchip Sapphire Board (RK3399)
> - Radxa Rock Pi 4 (RK3399)
> - Pine64 RockPro64 (RK3399)
> All of the above seem to use the RK808 regulator for sd io voltage.
>
> The ROC-RK3328-CC did not have this issue and seem to automatically res=
et to 3.3v.
>
> [1] https://github.com/Kwiboo/linux-rockchip/compare/next-20191011...ne=
xt-20191011-mmc
>
> Regards,
> Jonas
>
>> Soeren
>>
>>
>>>> although I'm not sure what if any progress has been made since then.=

>>>>
>>>> Robin.
>>>>


