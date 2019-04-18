Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8025C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FA52186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="hSKwbyj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389860AbfDRRov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:44:51 -0400
Received: from node.akkea.ca ([192.155.83.177]:57140 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389817AbfDRRov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:44:51 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 4926C4E204B; Thu, 18 Apr 2019 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555609490; bh=lhBxiRLUZJ5Ub6CaqN1pNkADQcPLYCoqT1MnSfYZbZs=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=hSKwbyj0Xms6ltQRU9iZCuKdFSSHREVmKr88vw8ckauAhVn47pE80hhlsMlgK5yt3
         piP/28r+NZrtpYcf7Kd5T5o0SkiwwNTHLGpYFt18Pw0KSli4lp6WbCBcxnV8a5qhr0
         w+eZLUa3uspaFQkSrNQxsOZ7EA3MC6ejxkQB+lv4=
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] arm64: dts: fsl: librem5: Add a device tree for  the Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Apr 2019 10:44:50 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, m.felsch@pengutronix.de,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20190418151350.GC32345@bogus>
References: <20190417165514.18689-1-angus@akkea.ca>
 <20190417165514.18689-2-angus@akkea.ca> <20190418151350.GC32345@bogus>
Message-ID: <79d43377285d6897847ac1452afbb18a@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 2019-04-18 08:13, Rob Herring wrote:
> On Wed, Apr 17, 2019 at 09:55:12AM -0700, Angus Ainslie (Purism) wrote:
>> This is the development kit board for the Librem 5. The current level 
>> of
>> support yields a working console and is able to boot userspace from 
>> the
>> Network or eMMC.
>> 
>> Additional subsystems that are active :
>> 
>> - Both USB ports
>> - SD card socket
>> - WiFi usdhc
>> - WWAN modem
>> - GNSS
>> - GPIO keys
>> - LEDs
>> - gyro
>> - magnetometer
>> - touchscreen
>> - pwm
>> - backlight
>> - haptic motor
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 833 
>> ++++++++++++++++++
>>  2 files changed, 834 insertions(+)
>>  create mode 100644 
>> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile 
>> b/arch/arm64/boot/dts/freescale/Makefile
>> index 0bd122f60549..c043aca66572 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>> 
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts 
>> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> new file mode 100644
>> index 000000000000..846a72dc7640
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> 
>> +&usb3_phy0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	port@0 {
>> +		reg = <0>;
>> +
>> +		typec_hs: endpoint {
>> +			remote-endpoint = <&usb_con_hs>;
>> +		};
>> +	};
>> +
>> +	port@1 {
>> +		reg = <1>;
>> +
>> +		typec_ss: endpoint {
>> +			remote-endpoint = <&usb_con_ss>;
>> +		};
>> +	};
> 
> This is wrong. The graph should be between the USB controller and the
> connector. The phy is not involved.
> 
>> +};
>> +
>> +&usb3_phy1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_dwc3_0 {
>> +	extcon = <&typec_ptn5100>;
> 
> extcon is deprecated and you should only have the usb-connector 
> binding.
> From the controller, you can walk the graph to the connector.
> 

I not sure that I'm clear on what you mean. Here's what I think you want 
it changed to.

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts 
b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 846a72dc7640..7b8770fdc5fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -755,51 +755,50 @@
  };

  &uart4 { /* BT */
         pinctrl-names = "default";
         pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_bt>;
         uart-has-rtscts;
         status = "okay";
  };

  &usb3_phy0 {
+       status = "okay";
+};
+
+&usb3_phy1 {
+       status = "okay";
+};
+
+&usb_dwc3_0 {
         #address-cells = <1>;
         #size-cells = <0>;
+       dr_mode = "otg";
         status = "okay";

         port@0 {
                 reg = <0>;

                 typec_hs: endpoint {
                         remote-endpoint = <&usb_con_hs>;
                 };
         };

         port@1 {
                 reg = <1>;

                 typec_ss: endpoint {
                         remote-endpoint = <&usb_con_ss>;
                 };
         };
  };

-&usb3_phy1 {
-       status = "okay";
-};
-
-&usb_dwc3_0 {
-       extcon = <&typec_ptn5100>;
-       dr_mode = "otg";
-       status = "okay";
-};
-
  &usb_dwc3_1 {
         dr_mode = "host";
         status = "okay";
  };



Thanks
Angus

>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};

