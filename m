Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01F1C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D241320679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKLIqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:46:55 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:37500 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfKLIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:46:55 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iURp7-00020s-1K; Tue, 12 Nov 2019 09:46:53 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xAC8kpAN012974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 12 Nov 2019 09:46:52 +0100
Subject: Re: arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on
 rk3399-roc-pc
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
 <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 eD/Xv4SsK2JTO4nkQYw8
Organization: five technologies GmbH
Message-ID: <3ebbea5b-0bda-3528-344d-d717889e6fec@fivetechno.de>
Date:   Tue, 12 Nov 2019 09:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1573548414;68438760;
X-HE-SMSGID: 1iURp7-00020s-1K
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Am 11.11.19 um 18:27 schrieb Ulf Hansson:
> On Mon, 11 Nov 2019 at 15:13, Markus Reichl <m.reichl@fivetechno.de> wrote:
>>
>> Add SDR104 capability and regulators to SD card node.
>> While at it, fix a typo in lcd pinctrl and remove two
>> undocumented bindings from pmic.
>>
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 31 +++++++++++++++----
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index 33df95e384b4..e86a6db54499 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -135,6 +135,20 @@
>>                 vin-supply = <&vcc_1v8>;
>>         };
>>
>> +       vcc3v0_sd: vcc3v0-sd {
>> +               compatible = "regulator-fixed";
>> +               enable-active-high;
>> +               gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&vcc3v0_sd_en>;
>> +               regulator-name = "vcc3v0_sd";
>> +               regulator-always-on;
> 
> This looks odd. A GPIO regulator being always on?

Works fine without always-on. Have sent v2. Thanks.

> 
>> +               regulator-boot-on;
>> +               regulator-min-microvolt = <3000000>;
>> +               regulator-max-microvolt = <3000000>;
>> +               vin-supply = <&vcc3v3_sys>;
>> +       };
> 
> Assumes this powers an SDIO embedded card. Often those have a specific
> power sequence, just wanted to make sure the above are really
> sufficient? No delays or external clock needed?
> 
> [...]
> 
> Kind regards
> Uffe
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

Gruß,
-- 
Markus Reichl
