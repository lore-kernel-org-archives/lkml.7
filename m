Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679FCC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B92D215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VFalHLvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfJDRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:24:59 -0400
Received: from mout.web.de ([212.227.17.12]:55307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfJDRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570209874;
        bh=q5dyvL9jNiiGjfoUjjUV7o2v7WYPluh/HSKwURmfO2o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VFalHLvGo2Z2FYpx2jtSym1AVAzmz67y8bmUVpEug71QEyq/ocbtotwoIo2IfaJmr
         60YjTFelDAxe6IFF8xC89aLlo09fkRWCcKMYE/TB2YHPZvYoB1oZ2yhlo0eKNGtofx
         rLd/Sp2HlbB5LTqedyTn/b6QUZXD23ep/wRumwA8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.27] ([77.191.3.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1i9Xad15vF-012I8F; Fri, 04
 Oct 2019 19:24:34 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_fix_Roc?=
 =?UTF-8?B?a1BybzY0IHNkbW1jIHNldHRpbmdz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?Q?ux-rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfr?=
 =?UTF-8?B?YWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191003215036.15023-1-smoch@web.de>
 <20191003215036.15023-3-smoch@web.de>
 <31181f3c-20ec-e717-1f7e-8b35cd54d96d@arm.com>
 <a8b20c45-0426-ee42-4efc-52e56ea6bb20@web.de>
 <120e2dbc-55eb-2205-b00f-7e50928ec706@rock-chips.com>
 <1c452b8b-853f-8f58-5f3a-0bbecbe20557@web.de>
 <fc7dce53-ad39-26e3-7c19-ab60ff4cc332@arm.com>
 <0c6fdb65-be2a-68e3-a686-14ce9b0a00a4@rock-chips.com>
From:   =?UTF-8?Q?S=c3=b6ren_Moch?= <smoch@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e4aaddc2-441b-b835-380e-374a3d935474@web.de>
Date:   Fri, 4 Oct 2019 19:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0c6fdb65-be2a-68e3-a686-14ce9b0a00a4@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:52EcFbHLajU/AYHuTIZWOWQ22JgShGnHnvRwO0xGY7QR4HtEdb5
 459n9NdBU4ZeLYEoOewA/o69ov2RapmYRQE6197U7Cs1UUVMC3bHW9Wl73MVlcqSgV3Strl
 FB994EmQsfd75nMhErupz7kI8xGArUAjNEGBBPbMVvLNsu9ADIWqWgly75IQmti87qOLbim
 8bwMALTyRERRH+EyFwOgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g/vZ21JmO18=:T/qwPM6Lb4c921osB+mW2c
 rPCS/lUYg6tVfbYPXNjck+p4xtm8L5TAUwkzItJzdyJRW/bJAUTC6lKNPLvURrKKJ8FeO3Et0
 8XgB4z2ABriBGCIEUoijaup8OIavL+LwwFs+YHddj5/CmQ+2quFX+qt60Uv87uwEFv3V3sIuh
 9IdGEgUfyItPWuzAYlUeFAHtXElSJP6OPg7dMcD8xI0ttPH13kr/k1G9o33x3CgzI91TsDaBr
 apRkS6ncloygXNl4shlzpxhQ9h/+ns3+aIbmON47UAmIEvtu7pjoZTflpaN4ZyEjb7aSOUjfK
 PI+iVT3eAug99NpY6mbb2rBN+Bwv1Upv7ItnlZHX2szW1vCmRLnliUdtXRQfrLHpytO4rw12W
 P1snOybHI3dYQdDMCrVPY7GLukG8wbdDmefXbJTp16Qe8ubQErSeDR0+foZYk1CiCwN1DpK0L
 /fzxlyHux9wxQ6jwgbQUuVIVbjiZLM+yB5YRvfcmrgfL1njE2IIXOJSdbrqW/aY0mJUc5NgTS
 8cab7iw3aR9yQxIgVc9GfsjslNis18w/NdEe9yQ5/xCW6D8ACeOchn//4xKdzOMAkmn+ZfGX/
 CzC6IYbCfZ7prtrqRgfZF4vo1qiNz0eUA3zB5QSQubJOmgzjq1qDhSweFnV0yBXvWhxpUhT6S
 ZonFvY5hkvBkCOrO8M7Cm1wzITqrNNn1wSVz7VRAmjZVFJTcYEdFtzplZQt35OVpKbHBY01h1
 YZZ1mUecpAki/VjX3wL6iLHrneRjwwb67yaNA49O9YE4NkFX5uJFBSRIHjxRu6QGQSacQY1i3
 /rCYU3Aq0YtzlQAmJQV6sJyPXWbmmjBIReKWpQiQl0hUonUJcmJzCFwOAgm1uX1LC5vRzSfq9
 LPzb28hn37zuVp1hQ4F4xJUa20z4OuG+ZPwhUoJnjmQb+79G+ZAydPslT9bg9kw5IzPyN7Vlr
 wsps9RFHQdjJYuY1VzeZRSro19s65OGFMUuI2n071r9Q+LYQIzofuU/fpDxs7+r7ohT65+yfA
 FC0PJMVshQcb/P7QlCkmSPJUv36lEvxzjYoRzzwvQxFWu3lMiHfsdfIFYXaUZbgKvnjpRjD5L
 YF4i6MxvbNZoK+MhKtRJMtZLB0hW0dDUyOMonUsEZzNukBg+gxBusJ6p7UEKvhmgQJrDHRhF0
 3kkmBvzXyqYljCZvcI4BmJA1wTN1xV+3AzJTVZMxgSv677VUVgB1IC6qLYLSlQHXjMNerUxwj
 uHoyNBv18mA76U5/myIe4N/ebyxcWKYu7PxxGcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.10.19 17:33, Shawn Lin wrote:
> On 2019/10/4 22:20, Robin Murphy wrote:
>> On 04/10/2019 04:39, Soeren Moch wrote:
>>>
>>>
>>> On 04.10.19 04:13, Shawn Lin wrote:
>>>> On 2019/10/4 8:53, Soeren Moch wrote:
>>>>>
>>>>>
>>>>> On 04.10.19 02:01, Robin Murphy wrote:
>>>>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>>>>> controller is
>>>>>>> connected to a microSD (TF card) slot, which cannot be switched t=
o
>>>>>>> 1.8V.
>>>>>>
>>>>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical to th=
e
>>>>>> NanoPC-T4 schematic (it's the same reference design, after all),
>>>>>> and I
>>>>>> know that board can happily drive a UHS-I microSD card with 1.8v
>>>>>> I/Os,
>>>>>> because mine's doing so right now.
>>>>>>
>>>>>> Robin.
>>>>> OK, the RockPro64 does not allow a card reset (power cycle) since
>>>>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
>>>>> SDMMC0_PWH_H signal is not connected. So the card fails to identify=

>>>>> itself after suspend or reboot when switched to 1.8V operation.
>>
>> Ah, thanks for clarifying - I did overlook the subtlety that U12 and
>> friends have "NC" as alternative part numbers, even though they
>> aren't actually marked as DNP. So it's still not so much "cannot be
>> switched" as "switching can lead to other problems".
>>
>>>>
>>>> I believe we addressed this issue long time ago, please check:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>>
>>>>
>>> Thanks for the pointer.
>>> In this case I guess I should use following patch instead:
>>>
>>> --- rk3399-rockpro64.dts.bak =C2=A0=C2=A0 2019-10-03 22:14:00.0677457=
99 +0200
>>> +++ rk3399-rockpro64.dts=C2=A0=C2=A0=C2=A0 2019-10-04 00:02:50.047892=
366 +0200
>>> @@ -619,6 +619,8 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd &=
sdmmc_bus4>;
>>> +=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
>>> +=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> =C2=A0=C2=A0};
>>> When I do so, the sd card is detected as SDR104, but a reboot hangs:
>>>
>>> Boot1: 2018-06-26, version: 1.14
>>> CPUId =3D 0x0
>>> ChipType =3D 0x10, 286
>>> Spi_ChipId =3D c84018
>>> no find rkpartition
>>> SpiBootInit:ffffffff
>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>> mmc: ERROR: Card did not respond to voltage select!
>>> emmc reinit
>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>> mmc: ERROR: Card did not respond to voltage select!
>>> emmc reinit
>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>> mmc: ERROR: Card did not respond to voltage select!
>>> SdmmcInit=3D2 1
>>> mmc0:cmd5,32
>>> mmc0:cmd7,32
>>> mmc0:cmd5,32
>>> mmc0:cmd7,32
>>> mmc0:cmd5,32
>>> mmc0:cmd7,32
>>> SdmmcInit=3D0 1
>>>
>>> So I guess I should use a different miniloader for this reboot to
>>> work!?
>>> Or what else could be wrong here?
>>
>> Hmm, I guess this is "the Tinkerboard problem" again - the patch
>> above would be OK if we could get as far as the kernel, but can't
>> help if the=20
>
> I didn't realize that SD was used as boot medium for RockPro64, but I
> did patch the vendor tree to solve the issue for Tinkerboard, see
> https://github.com/rockchip-linux/kernel/commit/a4ccde21f5a9f04f996fb02=
479cb9f16d3dc8dc0
>
>
> My initial plan was to patching upstream kernel by adding ->shutdown,bu=
t
> never finish it.
>
>> offending card is itself the boot medium. There was a proposal here:
>>
>> https://patchwork.kernel.org/patch/10817217/
>
> This RFC also looks good to me, but seems it needs volunteers
> to push it again.
Oh, I think this is a totally wrong way.

While this might work for some cards, setting the controller's i/o
voltage to 3.3V while leaving the card at 1.8V configuration is totally
against the specification, can lead to all kinds of strange behaviour
and even cause hardware damage. It also would actively defend the
purpose of the above mentioned patch (6a11fc4) where the kernel guesses
the i/o voltage from the card configuration and switches the controller
accordingly. We would end up with a 1.8V card and controller
configuration and a regulator voltage of 3.3V. This would only work with
good luck. Even if the kernel driver would switch the regulator back to
1.8V in this case, the voltage mismatch remains in the bootloader when
this card contains the boot image.

The only sane way I see to handle this is implementing the same
workaround (mode guessing) also in the bootloader (rockchip miniloader
and u-boot SPL since both bootloader chains are supported for this board)=
=2E

Or maybe I miss something?

Soeren


>
>>
>> although I'm not sure what if any progress has been made since then.
>>
>> Robin.
>>
>>
>>
>
>


