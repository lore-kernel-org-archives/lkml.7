Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4721734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="r/kBNeF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfCLNSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:18:21 -0400
Received: from node.akkea.ca ([192.155.83.177]:34210 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbfCLNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:18:19 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 141524E204B; Tue, 12 Mar 2019 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552396698; bh=oDx1nuwRo6SxGUTALtyoKJr+jLWzMVDR6z2D/iEA5rc=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=r/kBNeF+6r6TDIEH9rv7D52X1y1654Rtg9ARnpHeszAShWpeCMZbcNz6hR5c5na5g
         KX9cM1+ujY9paLykTiSaOEM6krn4VWWGnFe47YDzrIbpEPZx6Z5VaITO1A9MnqX3M/
         2lBz2mzO8bxQE4XzMn9akF+loM7Z03CvYiRKcCGo=
To:     Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: fsl: librem5: Add a device tree for the  Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Mar 2019 06:18:17 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAOMZO5Do+GF-sLO5wHEMR0daUbf4pnrwQby9dtvLXF+4fVC+Xw@mail.gmail.com>
References: <20190311234655.30357-1-angus@akkea.ca>
 <20190311234655.30357-2-angus@akkea.ca>
 <CAOMZO5Do+GF-sLO5wHEMR0daUbf4pnrwQby9dtvLXF+4fVC+Xw@mail.gmail.com>
Message-ID: <27b43910ac10170c3679cad51fc5bb83@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 2019-03-11 17:10, Fabio Estevam wrote:
> On Mon, Mar 11, 2019 at 8:47 PM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
> 
>> +/ {
>> +       model = "Purism Librem 5 devkit 1.0";
>> +       compatible = "fsl,librem5-devkit", "fsl,imx8mq";
> 
> This board is not manufactured by FSL/NXP, so it should be
> "purism,librem5-devkit", "fsl,imx8mq" instead.
> 
> You should also add an entry for the purism vendor entry in
> Documentation/devicetree/bindings/vendor-prefixes.txt in a separate
> patch.
> 

Thanks I'll add it in there.

>> +
>> +       chosen {
>> +               stdout-path = &uart1;
>> +       };
>> +
>> +       reg_usdhc2_vmmc: regulator-vsd-3v3 {
> 
> The usual format would be:
> 
> reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
> 

Ok

> 
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "VSD_3V3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>> +               enable-active-high;
>> +               regulator-always-on;
> 
> Always on? It would be better to pass this regulator inside the mmc 
> node.
> 

This GPIO is a #disable line for the WLAN and if it goes low the module 
doesn't recover. Until we get the WLAN driver working after disable it's 
best to leave it always on.

>> +       };
>> +
>> +       reg_pwr_en: pwr_en {
> 
> reg_pwr_en: regulator-pwr-en {
> 

Ok

>> +               compatible = "regulator-fixed";
>> +               regulator-name = "PWR_EN";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>> +               enable-active-high;
>> +               regulator-always-on;
> 
> Same here. No need for "regulator-always-on" as it is controlled by
> the gyroscope.
> 

This controls a regulator that feeds 80% of the peripherals on the board 
and we don't have all of the drivers in the devicetree yet. Shutting 
this off would during runtime would break the board so for now it needs 
to stay always on.

>> +&fec1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_fec1>;
>> +       phy-mode = "rgmii-id";
>> +       phy-handle = <&ethphy0>;
>> +       fsl,magic-packet;
>> +       status = "okay";
>> +       phy-supply = <&reg_pwr_en>;
>> +
>> +       mdio {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               ethphy0: ethernet-phy@0 {
>> +                       compatible = "ethernet-phy-ieee802.3-c22";
>> +                       reg = <1>;
> 
> You pass @0 and use reg = <1>, which is a mismatch. Building it with
> W=1 would have warned you about this mismatch.
> 

Thanks I'll fix that

>> +                       at803x,led-act-blind-workaround;
>> +                       at803x,eee-disabled;
>> +                       power-supply = <&reg_pwr_en>;
>> +               };
>> +       };
>> +};
>> +
>> +&iomuxc {
>> +       imx8m-som {
> 
> No need for this imx8m-som level.
> 
> 
>> +               pinctrl_nc: ncgrp {
> 
> Not a very descriptive naming.
> 

Ok , this was my list of not connected pins but it should be removed.

>> +                       fsl,pins = <
>> +                       MX8MQ_IOMUXC_SAI1_MCLK_SAI1_MCLK        0x00
>> +                       MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL          
>> 0x4000007f
>> +                       MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA          
>> 0x4000007f
>> +                       >;
>> +               };
>> +
>> +               pinctrl_up: upgrp {
> 
> Same here. Also, this is not used. Please remove it.
> 

Ok

>> +                       fsl,pins = <
>> +                       MX8MQ_IOMUXC_SAI1_TXD2_SAI1_TX_DATA2           
>>  0x00
>> +                       >;
>> +               };
>> +
>> +               pinctrl_csi1: csi1grp {
> 
> This is not used at the moment. Please remove it and re-add it when
> CSI gets supported.
> 

Ok

>> +                       fsl,pins = <
>> +                       /* CSI_nRST */
>> +                       MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6              
>>  0x11
>> +                       /* CSI_PWDN */
>> +                       MX8MQ_IOMUXC_GPIO1_IO07_GPIO1_IO7              
>>  0x19
>> +                       /* CLK01 */
>> +                       MX8MQ_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1     
>>  0x19
>> +                       >;
>> +               };
>> +
>> +               pinctrl_pwr_en: pwr_engrp {
>> +                       fsl,pins = <
>> +                       MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8              
>>  0x06
>> +                       >;
>> +               };
>> +
>> +               pinctrl_wwan: wwan_grp {
> 
> Not used. Please remove this one and all unused pinctrl nodes.
> 

This one should have been used but I'll go through and checked the rest 
as well.

>> +&i2c1 {
>> +       clock-frequency = <400000>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c1>;
>> +       status = "okay";
>> +
>> +       pmic: bd71837@4b {
> 
> Node names should be generic: pmic@4b
> 
>> +       typec_ptn5100: ptn5110@52 {
> 
> Same here.
> 

Ok

>> +       charger: charger@6b { /* bq25896 */
>> +               compatible = "ti,bq25890";
>> +               reg = <0x6b>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_charger>;
>> +               interrupt-parent = <&gpio3>;
>> +               interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>> +               ti,battery-regulation-voltage = <4192000>; // 4.192V
>> +               ti,charge-current = <1600000>; // 1.6 A
>> +               ti,termination-current = <66000>;  // 66mA
>> +               ti,precharge-current = <1300000>; // 1.3A
>> +               ti,minimum-sys-voltage = <2750000>; // 2.75V
>> +               ti,boost-voltage = <5000000>; // 5V
>> +               ti,boost-max-current = <50000>; // 50mA
> 
> No // style comments, please/
> 

Ok

>> +&i2c3 {
>> +       clock-frequency = <100000>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c3>, <&pinctrl_imu>;
>> +       status = "okay";
>> +
>> +       lsm9d: lsm9d@6a {
>> +               compatible = "st,lsm9ds1-gyro";
> 
> I don't find this binding.
> 

Thanks

>> +               reg = <0x6a>;
>> +               interrupt-parent = <&gpio3>;
>> +               interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>> +               power-supply = <&reg_pwr_en>;
>> +       };
>> +};
> 
>> +&uart4 { /* BT */
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_bt>;
>> +       fsl,uart-has-rtscts;
> 
> uart-has-rtscts is preferred.
> 
>> +       /* resets = <&modem_reset>; */
> 
> Please remove this line instead of commenting it out.

Ok

Thanks
Angus
