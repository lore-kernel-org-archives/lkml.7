Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A991321783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKLIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:16:50 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:45906 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfKLIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:16:49 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iURLr-0006wE-BB; Tue, 12 Nov 2019 09:16:39 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xAC8GcHU011669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 12 Nov 2019 09:16:38 +0100
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Kever Yang <kever.yang@rock-chips.com>, Soeren Moch <smoch@web.de>,
        heiko@sntech.de
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        linux-kernel@vger.kernel.org, Alexis Ballier <aballier@gentoo.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Andy Yan <andyshrk@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Nick Xie <nick@khadas.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Akash Gajjar <akash@openedev.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
 <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
 <1eaef5d5-c923-da56-b9c4-48d517b3c969@rock-chips.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 eD/Xv4SsK2JTO4nkQYw8
Organization: five technologies GmbH
Message-ID: <acbab893-9e9a-cfe1-67bf-a9e2b2e50114@fivetechno.de>
Date:   Tue, 12 Nov 2019 09:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1eaef5d5-c923-da56-b9c4-48d517b3c969@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1573546608;a847d6c2;
X-HE-SMSGID: 1iURLr-0006wE-BB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kever,

have a rk3399-roc-pc running mainline U-Boot and kernel and vdd_log is 
showing 1118 mV.
Is this a danger for the board?
How to fix it?
Btw. vin-supply for this pwm-regulator is ignored and I could not find it 
in bindings doc. 

Gruß,
-- 
Markus Reichl


Am 12.11.19 um 09:04 schrieb Kever Yang:
> 
> On 2019/11/11 下午4:42, Soeren Moch wrote:
>> On 11.11.19 01:51, Kever Yang wrote:
>>> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
>>> will be 'enable' with the dts node at a default PWM state with high or low
>>> output. Both too high or too low for vdd_log is not good for the board,
>>> add init voltage for driver to make the regulator get into a know output.
>>>
>>> Note that this will be used by U-Boot for init voltage output, and this
>>> is very important for it may get system hang somewhere during system
>>> boot up with regulator enable and without this init value.
>> I think it's a good idea to include this setting in the main dts for the
>> boards (not in u-boot specific additions as is done now). But there is
>> (for some reason?) no documented binding for regulator-init-microvolt in
>> linux.
> 
> 
> Ohh, I forgot the kernel driver does not support this property.
> 
> @Heiko, can we add this 'regulator-init-microvolt' without driver support but adding document for
> 
> it at dt-binding?
> 
> 
> Thanks,
> 
> - Kever
> 
>>
>> Regards,
>> Soeren
>>> CC: Elaine Zhang <zhangqing@rock-chips.com>
>>> CC: Peter Robinson <pbrobinson@gmail.com>
>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>> ---
>>>
>>>   arch/arm64/boot/dts/rockchip/rk3399-evb.dts          | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts       | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts    | 1 +
>>>   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 1 +
>>>   9 files changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>>> index 77008dca45bc..fa241aeb11b0 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>>> @@ -65,6 +65,7 @@
>>>           regulator-name = "vdd_center";
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           regulator-always-on;
>>>           regulator-boot-on;
>>>           status = "okay";
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>>> index 92de83dd4dbc..4e45269fcdff 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>>> @@ -208,6 +208,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <430000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vcc_sys>;
>>>       };
>>>   };
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>> index c133e8d64b2a..692f3154edc3 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>> @@ -100,6 +100,7 @@
>>>           regulator-name = "vdd_log";
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           regulator-always-on;
>>>           regulator-boot-on;
>>>       };
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>>> index 4944d78a0a1c..c2ac80d99301 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>>> @@ -79,6 +79,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vsys_3v3>;
>>>       };
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>>> index 73be38a53796..c32abcc4ddc1 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>>> @@ -101,6 +101,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vcc5v0_sys>;
>>>       };
>>>   };
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>>> index 0541dfce924d..9d674c51f025 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>>> @@ -164,6 +164,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vcc_sys>;
>>>       };
>>>   };
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>>> index 19f7732d728c..7d856ce1d156 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>>> @@ -129,6 +129,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vcc3v3_sys>;
>>>       };
>>>   };
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> index e544deb61d28..8fbccbc8bf47 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> @@ -174,6 +174,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1700000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vcc5v0_sys>;
>>>       };
>>>   };
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>>> index 1bc1579674e5..f8e2cb8c0624 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>>> @@ -133,6 +133,7 @@
>>>           regulator-boot-on;
>>>           regulator-min-microvolt = <800000>;
>>>           regulator-max-microvolt = <1400000>;
>>> +        regulator-init-microvolt = <950000>;
>>>           vin-supply = <&vcc_sys>;
>>>       };
>>>   };
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
