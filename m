Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B68C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 03:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78AC207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 03:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZpyY0dXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfJDDkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 23:40:13 -0400
Received: from mout.web.de ([212.227.15.4]:49089 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387567AbfJDDkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 23:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570160395;
        bh=M2hr1DFTmVUJtV0KSUX/LhA146pG6rhKVo+Ai17B1nU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZpyY0dXOTpwwqAFAFHizLTQBvV9RYXIbq1FI5oRN7fy6FET+CxPgQK22B/aU5Cu6M
         w8hk+k7NrL/oJlBzqVOa1CdftsvorLyaupw+X3R7FHsLG6e7b/5BIQnfwmLl44pDw6
         XexSVCV5fQ+iypzVc42hjkRftykR0HQynXslggDM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.27] ([77.183.117.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McWbQ-1iXtr0345I-00HbDo; Fri, 04
 Oct 2019 05:39:54 +0200
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
From:   Soeren Moch <smoch@web.de>
Message-ID: <1c452b8b-853f-8f58-5f3a-0bbecbe20557@web.de>
Date:   Fri, 4 Oct 2019 05:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <120e2dbc-55eb-2205-b00f-7e50928ec706@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:KiA97Kjmyv4wFkvQ0/dhatW3EPzZBAUT7SGV1rKafjmtxsn00Lx
 ZuwA20AQdpNfoTr8YYmi92f2N/UGkWxJ9p5Gyf8j7DmYgDtav37azDQAFNv5ZT/WkzqPGWP
 zjMEM7bm7ZukdM4HtNmVPE37KDCWKrYDN/6uutZ+4SWq95R6H2TceDOCCsd2M2pla1cWuiB
 WuFhbGn5E95o4io0Oed/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0RMfn7JLJKA=:aLtcRB63cedwkhHqYcK3An
 RP0UlDMnYvySyUBVjSoaOBaRua+NUvP9W+GHrjUIc3vKxC0W9crsjUrkZLn8U1SD1un0RgSQ9
 4VyZ8iLEhrvg5Lhq+uKKvOqw6IHD43+M6hGzJkqxEFD7QoE01kIdRs4aV3KiM0sw/EZb6iVYN
 tNdAQzEWOS+bahYMaFiK3o6oMYgJkP6ls/BUr2FFhx/5P6EBzRJB2xTJyj+aGNE7B/BsqFK6S
 3t/GDwXPBQi63crIGCk9fWMTxG58k90LHOQginzDzfj6MAa/L++MFfKL/tTA/eXcwxJTbh9ir
 rUz7slNxFEjchlcnIIk0T3TOBJASxhfYxNuyx/7ZPdvt49Lg6OONRFg+ZgN/zOvZFvqcy9v3G
 3JQc9zo2KBFCssebPr+VaGjBRr0DnWEbfz83raGYbCy8idYBvv6+dxaSLehJLEWSu3cPUZB10
 5kjT2pcSNkxihJ3MV0xe7EV3X0aMTnNExMhcJjqvduV/jzmdE8rjTDeIA3tt1aBO1Q562F9+9
 oZM0q8thQ2YTjfdNzLePbHKUKkYN8Vqp4DxFNIaCSeHWzAS5wtn57Cp2UysDFHeZipO0jXa0I
 GJklneAK/dxYneXyFV4CawDPT2HcVZfu7RuClHPK3wXjwTw22nlEcFIeo9wtdQIDrTfkTaGze
 g2R14RGLymYai5VBqdjW9OMIRI9sqJeTW535gI0aJ3nJKhGKrmuDjJESZCXt1emh6waavv8bD
 5ccivHFmUmMdzts4NL9HqyRpDAQ/kUePJUwdb4oJP/7vQyZ4X7CHhi4rRr7+/hhRQWKhX+3mv
 SLpXY5AQhErnmQl3WOLDFVMsDsdBzTkXU1mWKSg25R95AUQ9PjV7hSUIpiVO5GYgngwmWq/bc
 swAcqul1OKTjnGFq5sr0f4GEgFRqlKepFmQbpkL/5hyZ7X1N4NsWNawfIxiaiCNOOLNy+Kf7K
 /ehjY7VOX3yjmvdfUF3z8Mne4keME4HwlB6aR/Yh9iajNn58No2WMVQzYUamxtwgnuJDGBVtG
 C3pWTxZs+ygJDyya9uf5Y669cxFC6qHZsBw6F+gM1LtsOG1ItCvb1GVkSpkZXxdYm+aG/lfLW
 yw0akWYMeaRsBc2LFZ6ljjJRqiV53qf/4g57qdt7Y2peoo12UrnF0MyrU7eX6WbTKyLS6Nwa+
 itLyDiCbH3mrPT5HQka8/exeghviIUKEN4cVXsQIvSXvETnh9qJarlpUmGicHH1b/Eh9Ujop3
 fwixYoBYAwOywTmEH5Avo3/CGS9zdga/mw4e1hQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.10.19 04:13, Shawn Lin wrote:
> On 2019/10/4 8:53, Soeren Moch wrote:
>>
>>
>> On 04.10.19 02:01, Robin Murphy wrote:
>>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>>> According to the RockPro64 schematic [1] the rk3399 sdmmc
>>>> controller is
>>>> connected to a microSD (TF card) slot, which cannot be switched to
>>>> 1.8V.
>>>
>>> Really? AFAICS the SDMMC0 wiring looks pretty much identical to the
>>> NanoPC-T4 schematic (it's the same reference design, after all), and I
>>> know that board can happily drive a UHS-I microSD card with 1.8v I/Os,
>>> because mine's doing so right now.
>>>
>>> Robin.
>> OK, the RockPro64 does not allow a card reset (power cycle) since
>> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
>> SDMMC0_PWH_H signal is not connected. So the card fails to identify
>> itself after suspend or reboot when switched to 1.8V operation.
>>
>
> I believe we addressed this issue long time ago, please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
>
Thanks for the pointer.
In this case I guess I should use following patch instead:

=2D-- rk3399-rockpro64.dts.bak =C2=A0=C2=A0 2019-10-03 22:14:00.067745799 =
+0200
+++ rk3399-rockpro64.dts=C2=A0=C2=A0=C2=A0 2019-10-04 00:02:50.047892366 +=
0200
@@ -619,6 +619,8 @@
=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000>;
=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>=
;
+=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
+=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>;
=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
=C2=A0};
=C2=A0
When I do so, the sd card is detected as SDR104, but a reboot hangs:

Boot1: 2018-06-26, version: 1.14
CPUId =3D 0x0
ChipType =3D 0x10, 286
Spi_ChipId =3D c84018
no find rkpartition
SpiBootInit:ffffffff
mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
mmc: ERROR: Card did not respond to voltage select!
emmc reinit
mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
mmc: ERROR: Card did not respond to voltage select!
emmc reinit
mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
mmc: ERROR: Card did not respond to voltage select!
SdmmcInit=3D2 1
mmc0:cmd5,32
mmc0:cmd7,32
mmc0:cmd5,32
mmc0:cmd7,32
mmc0:cmd5,32
mmc0:cmd7,32
SdmmcInit=3D0 1

So I guess I should use a different miniloader for this reboot to work!?
Or what else could be wrong here?

Thanks,
Soeren

>> Regards,
>> Soeren
>>>
>>>> So also configure the vcc_sdio regulator, which drives the i/o voltag=
e
>>>> of the sdmmc controller, accordingly.
>>>>
>>>> While at it, also remove the cap-mmc-highspeed property of the sdmmc
>>>> controller, since no mmc card can be connected here.
>>>>
>>>> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
>>>>
>>>> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support
>>>> for Rockpro64")
>>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>>> ---
>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>> Cc: linux-rockchip@lists.infradead.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>> =C2=A0=C2=A0 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 3 +-=
-
>>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> index 2e44dae4865a..084f1d994a50 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> @@ -353,7 +353,7 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-name =3D "vcc_sdio";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-always-on;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-boot-on;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 regulator-min-microvolt =3D <1800000>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 regulator-min-microvolt =3D <3000000>;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-max-microvolt =3D <30000=
00>;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-state-mem {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-=
on-in-suspend;
>>>> @@ -624,7 +624,6 @@
>>>>
>>>> =C2=A0=C2=A0 &sdmmc {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus-width =3D <4>;
>>>> -=C2=A0=C2=A0=C2=A0 cap-mmc-highspeed;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap-sd-highspeed;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cd-gpios =3D <&gpio0 7 GPIO_ACTI=
VE_LOW>;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable-wp;
>>>> --=C2=A0
>>>> 2.17.1
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>
>

