Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E68220650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391926AbfJPJV2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:21:28 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:55206 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJPJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:21:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 7DD609C02F3;
        Wed, 16 Oct 2019 05:21:26 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HYlKbr2B05BK; Wed, 16 Oct 2019 05:21:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id CCB989C03A3;
        Wed, 16 Oct 2019 05:21:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DtRpUWLBM3Fo; Wed, 16 Oct 2019 05:21:25 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 900CB9C02F3;
        Wed, 16 Oct 2019 05:21:25 -0400 (EDT)
Date:   Wed, 16 Oct 2019 05:21:25 -0400 (EDT)
From:   Gilles Doffe <gilles.doffe@savoirfairelinux.com>
To:     shawnguo <shawnguo@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        rennes <rennes@savoirfairelinux.com>,
        =?utf-8?Q?J=C3=A9rome?= Oufella 
        <jerome.oufella@savoirfairelinux.com>,
        robh+dt <robh+dt@kernel.org>,
        mark rutland <mark.rutland@arm.com>,
        s hauer <s.hauer@pengutronix.de>,
        kernel <kernel@pengutronix.de>, festevam <festevam@gmail.com>,
        linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1837032218.9373931.1571217685548.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20191007112430.GD7150@dragon>
References: <20190916104353.7278-1-gilles.doffe@savoirfairelinux.com> <20191007112430.GD7150@dragon>
Subject: Re: [PATCH v3] ARM: dts: imx6qdl-rex: add gpio expander pca9535
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC76 (Linux)/8.8.11_GA_3737)
Thread-Topic: imx6qdl-rex: add gpio expander pca9535
Thread-Index: 0SgUHsAJvXpg4HUlY55gc/ziL2JF9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Le 7 Oct 19, à 13:24, shawnguo shawnguo@kernel.org a écrit :

> On Mon, Sep 16, 2019 at 12:43:53PM +0200, Gilles DOFFE wrote:
>> The pca9535 gpio expander is present on the Rex baseboard, but missing
>> from the dtsi.
>> The pca9535 is on i2c2 bus which is common to the three SOM
>> variants (Basic/Pro/Ultra), thus it is activated by default.
>> 
>> Add also the new gpio controller and the associated interrupt line
>> MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.
>> 
>> Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> b/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> index 97f1659144ea..8a748ca1b108 100644
>> --- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> @@ -132,6 +132,19 @@
>>  	pinctrl-0 = <&pinctrl_i2c2>;
>>  	status = "okay";
>>  
>> +	pca9535: gpio8@27 {
> 
> gpio-expander might be a better node name?
> 
> Shawn

Indeed, v4 incoming. ;)

Thank you Shawn.

> 
>> +		compatible = "nxp,pca9535";
>> +		reg = <0x27>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_pca9535>;
>> +		interrupt-parent = <&gpio6>;
>> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +	};
>> +
>>  	eeprom@57 {
>>  		compatible = "atmel,24c02";
>>  		reg = <0x57>;
>> @@ -237,6 +250,12 @@
>>  			>;
>>  		};
>>  
>> +		pinctrl_pca9535: pca9535 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x17059
>> +		   >;
>> +		};
>> +
>>  		pinctrl_uart1: uart1grp {
>>  			fsl,pins = <
>>  				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
>> --
>> 2.20.1
