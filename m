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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D44C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF774222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="d1ZQzp8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfJDQj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:39:29 -0400
Received: from mout.web.de ([217.72.192.78]:49821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfJDQj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570207152;
        bh=3qY51AIDbh0D6yCJlWeGuCtssREDMvHYUAYtv8hxk2Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d1ZQzp8oEHb5qeQGtCB0Nnx7YTR9xtE9kwzR3Rs5jkxGGF/Q16WaibQGHl0k9+wO5
         zPrL5BRFKhUKvjKa6dMrydOeWNn0a//4jWe1So2yFVnQJpOO++Us++3cQoe3lxDsB4
         siPsGX/IvPzGsGPbmJkmq7grRm0/eZXGnsf5Y9bw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.27] ([77.191.3.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYvxn-1ibTzH00pP-00Vk1a; Fri, 04
 Oct 2019 18:39:12 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_fix_Roc?=
 =?UTF-8?B?a1BybzY0IHNkbW1jIHNldHRpbmdz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?Q?ux-rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfr?=
 =?UTF-8?B?YWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
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
From:   Soeren Moch <smoch@web.de>
Message-ID: <a5b7caab-ffde-30e0-88bc-53a53748701a@web.de>
Date:   Fri, 4 Oct 2019 18:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fc7dce53-ad39-26e3-7c19-ab60ff4cc332@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:WDXMF7fUaHGooh/FbZ81ORhv2SFSl3PKXdEyI/BLdwRZsAjbggD
 8VTFxf353pFadfg+sHKcWdv5+RETJjI5q9jF4pdx5lcrnQv0QtpjAps5dFHtwBP9Ih05Znn
 sVL+FE/0rFaGbOU972rfTgvTZXw8xKiajaoscxXpD4vO9YYHhFdaRGdWkg+eGO47DIhf+9b
 BGRCq9LyxG+eF9Nhf0HzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j89oGVrDlDU=:ezMJXZgomRb8VO2z1FXus6
 lUrP5ck2RvSf/mJ+sYU21+PJdqM+tz+81kdT7Um8IpY1Nt5pYRwMfIgDltZf1vFX0cKJIpOos
 8nnLknq1eAbKfEg+48nonn/JBg3l9G0Dpkzt40CHJq94sf3EnvXHf4lma6EBcXwETYY2kziF/
 bYOIwIqC+wZCmUmG6X0wamlnUWKfqgPNi7uq8WHTLhOpEpqX/FHiyYQz39G7INrcgS+bt+T68
 H7oB2A0gwSSzCtgCkbk0jWSC2RYS5Hh8Zhr3Em6IKxZGHWVrqOwwLRHj8I/JSc12oERWj8NQB
 jCNwCrNTqLlbZKS8xMIDsUZGpxm0quyOY9YmteQRzZtpPqaEzZdavTw6ps8NpqsqsIU5FAlpw
 XaUPbwqrwcMjtgt0+dQyubG5dtmy/o2Wxf7/gKV0777H9w7P+n6hxxUBIc5ovqxQ+1i5uqvF7
 gDEdQ1SeCtHJHP00WRdYTzhs3ANXbvKRuiZ2gSRsWGQCKro9zYT20JPF6J9jT43coluS6dqI6
 EKGiRw/VeDUDRVfUjRsDybBGkg27P4HqAhOS+wY+pev5HRR3MHcn+bLImcRCfKpLmHs8P4ztc
 Nr8yA7/+IzcU0q1J/SNoux4N1tQMe2S2uXC+SJ4KBvo9W45bpJTZELIQoWACfBoHq1xIMV568
 bL6X//YpsT3wM0zJ9ChZrGJXhw/ZROB8QMKCddBiOSGRd7bDnIAsmuaIXpu4koMsGkAzcNiGr
 l07/7pLEM9MKfw6ZxJcV6K13sLb5n5W5cOoc5T51OXUHvxxDLYXnnxdyrizXm11WzgCn9QMAW
 A3eBmIJiHruGSCbEqnzmrTX4kkj1yVUiKu7dYWO5DE+8BdXTjHbtIGPf+fF3Tnsap7tBbiVSW
 JoijeUwuBoBstF/ARU7uYPTBBaynqo+HVKI7KY9RV/+g8LKMtpM6KMzhEgRnnktcJQbP7r4Rf
 voAHisdL43f6JdIsfaw40/4ZUJrJehD2nhugslrFwtq/nPBf/KLpp8s6M6k9Q70qhMdYbH5Ad
 yY4g1DJd8uGO1DpRjDmsT561bX9Bj/seIlNB7wIFlfnc8Gyb0bcmL7l5MJGXVoGLSnAqvi0rH
 QQO7xbTyOaBhsWZuXtBHu6Yn1ZU6QGcqghVXwg7fcmc6v8FzpZuC83JvPYca+iViKYXT68aTR
 W0tW58w5zw6pRz8TeTJqVqw4rlSzYS7dqctEJbTL/PaE51jmqYDdNlQAO4E8iLLOMqXhjWkWs
 b6+2LO3ldd7VTiG9kG++o4qkBkLwnGr6IpYP7tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.10.19 16:20, Robin Murphy wrote:
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
>>>>> NanoPC-T4 schematic (it's the same reference design, after all),
>>>>> and I
>>>>> know that board can happily drive a UHS-I microSD card with 1.8v
>>>>> I/Os,
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
Agreed. I should have been more precise about this in the commit message.

Soeren
>
>>>
>>> I believe we addressed this issue long time ago, please check:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>
>>>
>> Thanks for the pointer.
>> In this case I guess I should use following patch instead:
>>
>> --- rk3399-rockpro64.dts.bak =C2=A0=C2=A0 2019-10-03 22:14:00.067745799=
 +0200
>> +++ rk3399-rockpro64.dts=C2=A0=C2=A0=C2=A0 2019-10-04 00:02:50.04789236=
6 +0200
>> @@ -619,6 +619,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd &sd=
mmc_bus4>;
>> +=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
>> +=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>> =C2=A0=C2=A0};
>> =C2=A0 When I do so, the sd card is detected as SDR104, but a reboot ha=
ngs:
>>
>> Boot1: 2018-06-26, version: 1.14
>> CPUId =3D 0x0
>> ChipType =3D 0x10, 286
>> Spi_ChipId =3D c84018
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
>> SdmmcInit=3D2 1
>> mmc0:cmd5,32
>> mmc0:cmd7,32
>> mmc0:cmd5,32
>> mmc0:cmd7,32
>> mmc0:cmd5,32
>> mmc0:cmd7,32
>> SdmmcInit=3D0 1
>>
>> So I guess I should use a different miniloader for this reboot to work!=
?
>> Or what else could be wrong here?
>
> Hmm, I guess this is "the Tinkerboard problem" again - the patch above
> would be OK if we could get as far as the kernel, but can't help if
> the offending card is itself the boot medium. There was a proposal here:
>
> https://patchwork.kernel.org/patch/10817217/
>
> although I'm not sure what if any progress has been made since then.
>
> Robin.

