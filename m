Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17244C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC01206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKMDVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:21:54 -0500
Received: from regular1.263xmail.com ([211.150.70.198]:48502 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKMDVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:21:52 -0500
Received: from localhost (unknown [192.168.165.252])
        by regular1.263xmail.com (Postfix) with ESMTP id 7A8752AD;
        Wed, 13 Nov 2019 11:21:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P23561T140362385442560S1573615294290308_;
        Wed, 13 Nov 2019 11:21:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e71cf5987c7f79efdeaf657392ddab2c>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: dianders@chromium.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andyshrk@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Xie <nick@khadas.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
 <1eaef5d5-c923-da56-b9c4-48d517b3c969@rock-chips.com>
 <1780044.CQmMckQ5VN@diego>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <b752ba88-8931-0e03-a010-650129253afd@rock-chips.com>
Date:   Wed, 13 Nov 2019 11:21:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1780044.CQmMckQ5VN@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko,

     Could you help to just pick the first patch and drop the other 2 
patches?

     I think it's better to fix in the U-Boot first so that the 
stability issue will be fixed,

and the update in kernel dts is not so urgent for kernel driver actually 
not setting

this pwm regulator.

     I want to add a patch for rk3399-roc-pc, since Markus Reichl 
already send it,

so it's OK for that board, and for rock960/Ficus, the vdd_log is removed 
for stability

issue, then we have to update U-Boot first before kernel can add the 
vdd_log back.


Thanks,

- Kever

On 2019/11/12 下午4:10, Heiko Stübner wrote:
> Hi Kever,
>
> Am Dienstag, 12. November 2019, 09:04:49 CET schrieb Kever Yang:
>> On 2019/11/11 下午4:42, Soeren Moch wrote:
>>> On 11.11.19 01:51, Kever Yang wrote:
>>>> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
>>>> will be 'enable' with the dts node at a default PWM state with high or low
>>>> output. Both too high or too low for vdd_log is not good for the board,
>>>> add init voltage for driver to make the regulator get into a know output.
>>>>
>>>> Note that this will be used by U-Boot for init voltage output, and this
>>>> is very important for it may get system hang somewhere during system
>>>> boot up with regulator enable and without this init value.
>>> I think it's a good idea to include this setting in the main dts for the
>>> boards (not in u-boot specific additions as is done now). But there is
>>> (for some reason?) no documented binding for regulator-init-microvolt in
>>> linux.
>>
>> Ohh, I forgot the kernel driver does not support this property.
>>
>> @Heiko, can we add this 'regulator-init-microvolt' without driver
>> support but adding document for
>>
>> it at dt-binding?
> In theory yes, but you would still need to get DT maintainers
> and Mark Brown (regulator maintainer) involved before that.
>
> Especially as this is a individual property you will need to have
> a good excuse why you're not implementing it in the kernel as well.
>
> And of course you will need to keep in mind that it might be
> in the kernel in the future.
>
>
> Heiko
>
>
>
>>
>> Thanks,
>>
>> - Kever
>>
>>> Regards,
>>> Soeren
>>>> CC: Elaine Zhang <zhangqing@rock-chips.com>
>>>> CC: Peter Robinson <pbrobinson@gmail.com>
>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>>> ---
>>>>
>>>>    arch/arm64/boot/dts/rockchip/rk3399-evb.dts          | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts       | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts    | 1 +
>>>>    arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 1 +
>>>>    9 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>>>> index 77008dca45bc..fa241aeb11b0 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>>>> @@ -65,6 +65,7 @@
>>>>    		regulator-name = "vdd_center";
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		regulator-always-on;
>>>>    		regulator-boot-on;
>>>>    		status = "okay";
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>>>> index 92de83dd4dbc..4e45269fcdff 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>>>> @@ -208,6 +208,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <430000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vcc_sys>;
>>>>    	};
>>>>    };
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>>> index c133e8d64b2a..692f3154edc3 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>>> @@ -100,6 +100,7 @@
>>>>    		regulator-name = "vdd_log";
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		regulator-always-on;
>>>>    		regulator-boot-on;
>>>>    	};
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>>>> index 4944d78a0a1c..c2ac80d99301 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>>>> @@ -79,6 +79,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vsys_3v3>;
>>>>    	};
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>>>> index 73be38a53796..c32abcc4ddc1 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>>>> @@ -101,6 +101,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vcc5v0_sys>;
>>>>    	};
>>>>    };
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>>>> index 0541dfce924d..9d674c51f025 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>>>> @@ -164,6 +164,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vcc_sys>;
>>>>    	};
>>>>    };
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>>>> index 19f7732d728c..7d856ce1d156 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>>>> @@ -129,6 +129,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vcc3v3_sys>;
>>>>    	};
>>>>    };
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> index e544deb61d28..8fbccbc8bf47 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>> @@ -174,6 +174,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1700000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vcc5v0_sys>;
>>>>    	};
>>>>    };
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>>>> index 1bc1579674e5..f8e2cb8c0624 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>>>> @@ -133,6 +133,7 @@
>>>>    		regulator-boot-on;
>>>>    		regulator-min-microvolt = <800000>;
>>>>    		regulator-max-microvolt = <1400000>;
>>>> +		regulator-init-microvolt = <950000>;
>>>>    		vin-supply = <&vcc_sys>;
>>>>    	};
>>>>    };
>>
>>
>
>
>


