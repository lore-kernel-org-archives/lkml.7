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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63831222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TWupxaHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfJDUQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:16:12 -0400
Received: from mout.web.de ([212.227.15.4]:44361 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJDUQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570220147;
        bh=/9iohLUYEBbDOBi5xKcaPBwoVFoiXUt1MECauKaeNPo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=TWupxaHFHy8htGtXWmxeL0FJOHS78tgk2FewKPAYTLdU/gIv+6Ph7W47GGQhQlKJL
         K+3dE7Sxhp+y8vqH6ERC/XBycECioVXB5hTL9ftDzFn6CoBLsdTzrFNRRmR1bAyWZq
         sEk5rWSI+6/WFiD5zokQaSF29JdQXQYXLgdmLAKk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.27] ([77.191.3.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaTtv-1hqBeG0gfP-00mIlm; Fri, 04
 Oct 2019 22:15:47 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_fix_Roc?=
 =?UTF-8?B?a1BybzY0IHNkbW1jIHNldHRpbmdz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?Q?ux-rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfr?=
 =?UTF-8?B?YWRlYWQub3Jn5Luj5Y+R44CR?=
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191003215036.15023-1-smoch@web.de>
 <20191003215036.15023-3-smoch@web.de>
 <31181f3c-20ec-e717-1f7e-8b35cd54d96d@arm.com>
 <a8b20c45-0426-ee42-4efc-52e56ea6bb20@web.de>
 <120e2dbc-55eb-2205-b00f-7e50928ec706@rock-chips.com>
 <1c452b8b-853f-8f58-5f3a-0bbecbe20557@web.de>
 <fc7dce53-ad39-26e3-7c19-ab60ff4cc332@arm.com>
 <0c6fdb65-be2a-68e3-a686-14ce9b0a00a4@rock-chips.com>
 <e4aaddc2-441b-b835-380e-374a3d935474@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 mQMuBFF1CvoRCADuPSewZ3cFP42zIHDvyXJuBIqMfjbKsx27T97oRza/j12Cz1aJ9qIfjOt5
 9cHpi+NeCo5n5Pchlb11IGMjrd70NAByx87PwGL2MO5k/kMNucbYgN8Haas4Y3ECgrURFrZK
 vvTMqFNQM/djQgjxUlEIej9wlnUO2xe7uF8rB+sQ+MqzMFwesCsoWgl+gRui7AhjxDJ2+nmy
 Ec8ZtuTrWcTNJDsPMehLRBTf84RVg+4pkv4zH7ICzb4AWJxuTFDfQsSxfLuPmYtG0z7Jvjnt
 iDaaa3p9+gmZYEWaIAn9W7XTLn0jEpgK35sMtW1qJ4XKuBXzDYyN6RSId/RfkPG5X6tXAQDH
 KCd0I2P2dBVbSWfKP5nOaBH6Fph7nxFFayuFEUNcuQgAlO7L2bW8nRNKlBbBVozIekqpyCU7
 mCdqdJBj29gm2oRcWTDB9/ARAT2z56q34BmHieY/luIGsWN54axeALlNgpNQEcKmTE4WuPaa
 YztGF3z18/lKDmYBbokIha+jw5gdunzXXtj5JGiwD6+qxUxoptsBooD678XxqxxhBuNPVPZ0
 rncSqYrumNYqcrMXo4F58T+bly2NUSqmDHBROn30BuW2CAcmfQtequGiESNHgyJLCaBWRs5R
 bm/u6OlBST2KeAMPUfGvL6lWyvNzoJCWfUdVVxjgh56/s6Rp6gCHAO5q9ItsPJ5xvSWnX4hE
 bAq8Bckrv2E8F0Bg/qJmbZ53FQf9GEytLQe0xhYCe/vEO8oRfsZRTMsGxFH1DMvfZ7f/MrPW
 CTyPQ3KnwJxi9Mot2AtP1V1kfjiJ/jtuVTk021x45b6K9mw0/lX7lQ+dycrjTm6ccu98UiW1
 OGw4rApMgHJR9pA59N7FAtI0bHsGVKlSzWVMdVNUCtF9R4VXUNxMZz84/ZcZ9hTK59KnrJb/
 ft/IEAIEpdY7IOVI7mso060k3IFFV/HbWI/erjAGPaXR3Cccf0aH28nKIIVREfWd/7BU050G
 P0RTccOxtYp9KHCF3W6bC9raJXlIoktbpYYJJgHUfIrPXrnnmKkWy6AgbkPh/Xi49c5oGolN
 aNGeFuvYWbQaU29lcmVuIE1vY2ggPHNtb2NoQHdlYi5kZT6IegQTEQgAIgUCUXUK+gIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQANCJ0qFZnBAmcQEAkMwkC8NpkNTFQ+wc1j0C
 D1zWXsI3BE+elCcGlzcK8d0A/04iWXt16ussH2x+LzceaJlUJUOs6c4khyCRzWWXKK1HuQIN
 BFF1CvoQCADVUJEklP4MK6yoxlb+/fFsPw2YBNfpstx6TB8EC7TefHY1vIe/O4i4Vf4YfR+E
 dbFRfEc1uStvd/NBOZmEZYOwXgKuckwKSEGKCDz5IBhiI84e0Je4ZkHP3poljJenZEtdfiSG
 ZKtEjWJUv34EQGbkal7oJ2FLdlicquDmSq/WSjFenfVuGKx4Cx4jb3D0RP8A0lCGMHY6qhlq
 fA4SgtjbFiSPXolTCCWGJr3L5CYnPaxg4r0G5FWt+4FZsUmvdUTWB1lZV7LGk1dBjdnPv6UT
 X9VtL2dWl1GJHajKBJp9yz8OmkptxHLY1ZeqZRv9zEognqiE2VGiKTZe1Ajs55+HAAMFB/4g
 FrF01xxygoi4x5zFzTB0VGmKIYK/rsnDxJFJoaR/S9iSycSZPTxECCy955fIFLy+GEF5J3Mb
 G1ETO4ue2wjBMRMJZejEbD42oFgsT1qV+h8TZYWLZNoc/B/hArl5cUMa+tqz8Ih2+EUXr9wn
 lYqqw/ita/7yP3ScDL9NGtZ+D4rp4h08FZKKKJq8lpy7pTmd/Nt5rnwPuWxagWM0C2nMnjtm
 GL2tWQL0AmGIbapr0uMkvw6XsQ9NRYYyKyftP1YhgIvTiF2pAJRlmn/RZL6ZuCSJRZFMLT/v
 3wqJe3ZMlKtufQP8iemqsUSKhJJVIwAKloCX08K8RJ6JRjga/41HiGEEGBEIAAkFAlF1CvoC
 GwwACgkQANCJ0qFZnBD/XQEAgRNZehpq0lRRtZkevVooDWftWF34jFgxigwqep7EtBwBAIlW
 iHJPk0kAK21A1fmcp11cd6t8Jgfn1ciPuc0fqaRb
Message-ID: <c180ec58-083b-5730-a188-58eb6100b7b6@web.de>
Date:   Fri, 4 Oct 2019 22:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e4aaddc2-441b-b835-380e-374a3d935474@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:Zf72IgGpSgQJSNpJ/D6zm5lUuOX8w2V1h+znKSLKcyv+nh1hsOc
 p6T++Xvs/wvidFTOWBEvt39EPNaRpji/3T7Uo+DJema1R1MZ4uxLrGfVAjoqlBnYyMVby2J
 Mh3Eig6qsSJ/XW0CF+3RHmBJKpeNGvB4O0KYm/8HbavMnoRcIUvBIJMENxe/cwHWVYjayKD
 nAvysTpymIKUV9OTraj6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlODg3pdTKc=:2bXAJqkdhFYAJ6UtzWSE8c
 sY2WaG2V7lKLn7aE3t/qANkHdgX2W7ji5kX2emKrysveUNdm8sUryT5TUEX396gxYrVtnPpnH
 OMquyWmBbU8vHWnhDBeTfWgfjYO6Jot1mVv8fzp2v4iMV7EmAtyfsUNr2qWz56rb8PjvcG77X
 QOnOHiB1WkTRELrcY5lCJn0ASdb4dE01kCXUJ0PEcgJ/xlT1x4ekixIX/eHCXV0b8FiyjEDcK
 HlLE2D9CEdqnwCgiYaeCSwigXpzfllHpLuNWl+5/4LSzSHQqszAZHwv3qbd9UftFTDXdOgp6T
 Fgfa11oRaABb2qdm2mW8evyLQ22PNaYSc1XRxfLNzuXfp/41FqtkuDp95uJn6xbg3Hri4ANnX
 hBdFZqNSYzRzRKSQ1xcjd26Iz/joKOs+NaEbS6VoDzVFAsBslLdKQ9QaYYSSOOg4rjG0f6DvJ
 ncdRRhT/jTSxC2iDbMWF/ZEXtRfq0CJc3zDn2HchJz4f8PuBtkP1qxzyXuZ8MEl3md1hxdeNG
 gd9wb5eR0FnyZoogXP2e80iQ6xk3xPi+mIPe5BQOQFSTvmNNUasfBrPApOdj6QfBZPO3mjigy
 wHJFnSZyeENRdGJtrWWGmXSCOJI8h4b0dOi2xKzcW6hGSUKf4BxA6Yzlvfa/LE/Rei512CI91
 Ot+75JE+VBlYopy5Gf+mnuQHHsdhob1XLExKz94RJjeIzPkgLp8r2V2FwBrikZekb7uqQaQB1
 o7vPk2oZyq40bZea396HqWQh1JSEgvkqz/oU9cV9jsAhoA/BLsyDSgH75C+p9MGz8txOQX4Th
 12QvRmAd/Yks5GfU9sxSvKFEyOt3SPgPNhWeV01J6rpMWOUEfYo2agXP08TnfbrWPnEt0Lyal
 8PiD+3HmPKqoQJK5QfLuZnYx9hXBTcXQ3ZqGr/+7CMqQf5+UmJa5dC+GHDFaOM6MYx9ZBnyNv
 JDrIUaLYt0HC/xgFjYm+f3Q4xPqdaqJe4Vz9XM3RLzQJuvPECEOq3+ZNLzivZG+xFEaNtxZoL
 xKSA5U5r6+jM6t/4y+qyb7OLwgMNVYf21azNDTeP/mHjemsGizXwHPpF981xfPHG2PWIVYybD
 s5mcMi4mer+RWTGHqBQKLoGrY1WF/eVqN+h7LTnrVo+I81oWLSWsLuIk7OmjjQioQCy87P5tp
 QuAStsd1RuGq0Wtv3uDYBad9pxuZ5WbT2ia/rXgdqH0SEAsq0/5sjuz1Hscb2Y1wasynKfFuA
 eZtTSps+734dS0RFZlm1N9RW6ylL1rMnAXg4t3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko,

since you started to apply the first 2 Patches of this series (thanks
for that!), now after all the discussions here (and the heads-up for the
implemented mode detection) I think we should leave the vcc_sdio
regulator settings unmodified.

It still could make sense to remove the cap-mmc-highspeed property. Are
you OK with a V2 patch for that?

Thanks,
Soeren


On 04.10.19 19:24, S=C3=B6ren Moch wrote:
>
> On 04.10.19 17:33, Shawn Lin wrote:
>> On 2019/10/4 22:20, Robin Murphy wrote:
>>> On 04/10/2019 04:39, Soeren Moch wrote:
>>>>
>>>> On 04.10.19 04:13, Shawn Lin wrote:
>>>>> On 2019/10/4 8:53, Soeren Moch wrote:
>>>>>>
>>>>>> On 04.10.19 02:01, Robin Murphy wrote:
>>>>>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>>>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>>>>>> controller is
>>>>>>>> connected to a microSD (TF card) slot, which cannot be switched =
to
>>>>>>>> 1.8V.
>>>>>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical to t=
he
>>>>>>> NanoPC-T4 schematic (it's the same reference design, after all),
>>>>>>> and I
>>>>>>> know that board can happily drive a UHS-I microSD card with 1.8v
>>>>>>> I/Os,
>>>>>>> because mine's doing so right now.
>>>>>>>
>>>>>>> Robin.
>>>>>> OK, the RockPro64 does not allow a card reset (power cycle) since
>>>>>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
>>>>>> SDMMC0_PWH_H signal is not connected. So the card fails to identif=
y
>>>>>> itself after suspend or reboot when switched to 1.8V operation.
>>> Ah, thanks for clarifying - I did overlook the subtlety that U12 and
>>> friends have "NC" as alternative part numbers, even though they
>>> aren't actually marked as DNP. So it's still not so much "cannot be
>>> switched" as "switching can lead to other problems".
>>>
>>>>> I believe we addressed this issue long time ago, please check:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>>>
>>>>>
>>>> Thanks for the pointer.
>>>> In this case I guess I should use following patch instead:
>>>>
>>>> --- rk3399-rockpro64.dts.bak =C2=A0=C2=A0 2019-10-03 22:14:00.067745=
799 +0200
>>>> +++ rk3399-rockpro64.dts=C2=A0=C2=A0=C2=A0 2019-10-04 00:02:50.04789=
2366 +0200
>>>> @@ -619,6 +619,8 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000>;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd =
&sdmmc_bus4>;
>>>> +=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
>>>> +=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>>> =C2=A0=C2=A0};
>>>> When I do so, the sd card is detected as SDR104, but a reboot hangs:=

>>>>
>>>> Boot1: 2018-06-26, version: 1.14
>>>> CPUId =3D 0x0
>>>> ChipType =3D 0x10, 286
>>>> Spi_ChipId =3D c84018
>>>> no find rkpartition
>>>> SpiBootInit:ffffffff
>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>> mmc: ERROR: Card did not respond to voltage select!
>>>> emmc reinit
>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>> mmc: ERROR: Card did not respond to voltage select!
>>>> emmc reinit
>>>> mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
>>>> mmc: ERROR: Card did not respond to voltage select!
>>>> SdmmcInit=3D2 1
>>>> mmc0:cmd5,32
>>>> mmc0:cmd7,32
>>>> mmc0:cmd5,32
>>>> mmc0:cmd7,32
>>>> mmc0:cmd5,32
>>>> mmc0:cmd7,32
>>>> SdmmcInit=3D0 1
>>>>
>>>> So I guess I should use a different miniloader for this reboot to
>>>> work!?
>>>> Or what else could be wrong here?
>>> Hmm, I guess this is "the Tinkerboard problem" again - the patch
>>> above would be OK if we could get as far as the kernel, but can't
>>> help if the=20
>> I didn't realize that SD was used as boot medium for RockPro64, but I
>> did patch the vendor tree to solve the issue for Tinkerboard, see
>> https://github.com/rockchip-linux/kernel/commit/a4ccde21f5a9f04f996fb0=
2479cb9f16d3dc8dc0
>>
>>
>> My initial plan was to patching upstream kernel by adding ->shutdown,b=
ut
>> never finish it.
>>
>>> offending card is itself the boot medium. There was a proposal here:
>>>
>>> https://patchwork.kernel.org/patch/10817217/
>> This RFC also looks good to me, but seems it needs volunteers
>> to push it again.
> Oh, I think this is a totally wrong way.
>
> While this might work for some cards, setting the controller's i/o
> voltage to 3.3V while leaving the card at 1.8V configuration is totally=

> against the specification, can lead to all kinds of strange behaviour
> and even cause hardware damage. It also would actively defend the
> purpose of the above mentioned patch (6a11fc4) where the kernel guesses=

> the i/o voltage from the card configuration and switches the controller=

> accordingly. We would end up with a 1.8V card and controller
> configuration and a regulator voltage of 3.3V. This would only work wit=
h
> good luck. Even if the kernel driver would switch the regulator back to=

> 1.8V in this case, the voltage mismatch remains in the bootloader when
> this card contains the boot image.
>
> The only sane way I see to handle this is implementing the same
> workaround (mode guessing) also in the bootloader (rockchip miniloader
> and u-boot SPL since both bootloader chains are supported for this boar=
d).
>
> Or maybe I miss something?
>
> Soeren
>
>
>>> although I'm not sure what if any progress has been made since then.
>>>
>>> Robin.
>>>
>>>
>>>
>>
>


