Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B3C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1036222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ebvNQDzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfJCGAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:00:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8702 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfJCGAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:00:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d958e870000>; Wed, 02 Oct 2019 23:00:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 23:00:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Oct 2019 23:00:36 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct
 2019 06:00:35 +0000
Received: from [10.19.108.102] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct 2019
 06:00:33 +0000
Subject: Re: [PATCH 6/6] arm64: tegra: Enable XUSB host in P2972-0000 board
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-7-jckuo@nvidia.com> <20191002102611.GH3716706@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <2b50ad58-e5da-2f93-0c18-f16843fe64ac@nvidia.com>
Date:   Thu, 3 Oct 2019 14:00:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002102611.GH3716706@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570082439; bh=IRvBK47uVjWmDsT165L0Pu++8XKZQ+qki1Prrbvm1Uw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ebvNQDzMhzJ73lFk+ey5emow7Ea+iV0Yd6g+785HNbmGSvDdJk1V5guN35ec5RjSJ
         zB9IRYwqxV65I71gq1y1oXtcIo/VvJrBsC4PAYbmd6fN/uHbUQ7sjL8LmzP86PbA3J
         Q/Kn098cIDblw5UKhP4wrIRsBVjhh3JHEgCLGmWeFOuKkB+gxu20bj/GdD91kJLuvG
         aZTlyYQMZqBBTSgFDbD3iqjdiv7qusls6o35VVG3wSrQxxo+3OtB1n/ztGkVTCcOn+
         nFlkPGWNAqrlh3PG1k1P68/Mv6eqH47X851PALmtSy6wAPMktTq8MKrkQRg1KNBzb0
         8uLJAytOuocIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 6:26 PM, Thierry Reding wrote:
> On Wed, Oct 02, 2019 at 04:00:51PM +0800, JC Kuo wrote:
>> This commit enables XUSB host and pad controller in Tegra194
>> P2972-0000 board.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 31 +++++++++-
>>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 59 +++++++++++++++++++
>>  2 files changed, 89 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> index 4c38426a6969..cb236edc6a0d 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> @@ -229,7 +229,7 @@
>>  						regulator-max-microvolt = <3300000>;
>>  					};
>>  
>> -					ldo5 {
>> +					vdd_usb_3v3: ldo5 {
>>  						regulator-name = "VDD_USB_3V3";
>>  						regulator-min-microvolt = <3300000>;
>>  						regulator-max-microvolt = <3300000>;
>> @@ -313,5 +313,34 @@
>>  			regulator-boot-on;
>>  			enable-active-low;
>>  		};
>> +
>> +		vdd_5v_sata: regulator@4 {
>> +			compatible = "regulator-fixed";
>> +			reg = <4>;
>> +
>> +			regulator-name = "vdd-5v-sata";
> 
> Please keep capitalization of regulator names consistent. We use
> all-caps and underscores for the others (which mirrors the names in the
> schematics), so please stick with that for this one as well.
> 
Sure. I will fix this.
> Also, I'm wondering if perhaps you can clarify something here. My
> understanding is that SATA functionality is provided via a controller on
> the PCI bus. Why is it that we route the 5 V SATA power to the USB port?
> Oh wait... this is one of those eSATAp (hybrid) ports that can take
> either eSATA or USB, right? Do we need any additional setup to switch
> between eSATA and USB modes? Or is this all done in hardware? That is,
> if I plug in an eSATA, does it automatically hotplug detect the device
> as SATA and if I plug in a USB device, does it automatically detect it
> as USB?
> 
Yes, this 5V supply is for the eSATAp port. eSATA cable will deliver the 5V to
SATA device. No SATA/USB switch is required as USB SuperSpeed and PCIE-to-SATA
controller each has its own UPHY lane. SATA TX/RX pairs also have dedicated pins
at the eSATAp connector. External SATA drive can be hotplug and hardware will
detect automatically.

>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			gpio = <&gpio TEGRA194_MAIN_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
> 
> This will actually cause a warning on boot. For fixed regulators the
> polarity of the enable GPIO is not specified in the GPIO specifier.
> Instead you're supposed to use the boolean enable-active-high property
> to specify if the enable GPIO is active-high. By default the enable GPIO
> is considered to be active-low. The GPIO specifier needs to have the
> GPIO_ACTIVE_HIGH flag set regardless for backwards-compatibilitiy
> reasons.
> 
> Note that regulator@3 above your new entry does this wrongly, but
> next-20191002 should have a fix for that.
> 
Thanks for the information. I will fix this in the next revision.
>> +		};
>> +	};
>> +
>> +	padctl@3520000 {
> 
> Don't forget to move this into /cbb as well to match the changes to
> patch 5/6.
> 
Sure, will do.
>> +		avdd-usb-supply = <&vdd_usb_3v3>;
>> +		vclamp-usb-supply = <&vdd_1v8ao>;
>> +		ports {
> 
> Blank line between the above two for better readability.
> 
Okay.
>> +			usb2-1 {
>> +				vbus-supply = <&vdd_5v0_sys>;
>> +			};
>> +			usb2-3 {
> 
> Same here and below.
> 
>> +				vbus-supply = <&vdd_5v_sata>;
>> +			};
>> +			usb3-0 {
>> +				vbus-supply = <&vdd_5v0_sys>;
>> +			};
>> +			usb3-3 {
>> +				vbus-supply = <&vdd_5v0_sys>;
>> +			};
>> +		};
>>  	};
>>  };
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> index d47cd8c4dd24..410221927dfa 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> @@ -222,4 +222,63 @@
>>  			};
>>  		};
>>  	};
>> +
>> +	padctl@3520000 {
> 
> Same comment as above. Move this into /cbb.
> 
>> +		status = "okay";
>> +
>> +		pads {
>> +			usb2 {
>> +				lanes {
>> +					usb2-1 {
>> +						status = "okay";
>> +					};
>> +					usb2-2 {
> 
> And blank lines for readability here and below.
> 
>> +						status = "okay";
>> +					};
>> +					usb2-3 {
>> +						status = "okay";
>> +					};
>> +				};
>> +			};
>> +			usb3 {
>> +				lanes {
>> +					usb3-0 {
>> +						status = "okay";
>> +					};
>> +					usb3-3 {
>> +						status = "okay";
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		ports {
>> +			usb2-1 {
>> +				mode = "host";
>> +				status = "okay";
>> +			};
>> +			usb2-3 {
>> +				mode = "host";
>> +				status = "okay";
>> +			};
>> +			usb3-0 {
>> +				nvidia,usb2-companion = <1>;
>> +				status = "okay";
>> +			};
>> +			usb3-3 {
>> +				nvidia,usb2-companion = <3>;
>> +				nvidia,disable-gen2;
>> +				status = "okay";
>> +			};
>> +		};
>> +	};
>> +
>> +	tegra_xhci: xhci@3610000 {
> 
> Also needs to move into /cbb. Also, you can drop the tegra_xhci label
> here since we never reference the controller from elsewhere.
> 
> Also make sure to update the name here to match the changes in 5/6.
> 
Got it. Thanks for the reminder.
> Thierry
> 
>> +		status = "okay";
>> +		phys =	<&{/padctl@3520000/pads/usb2/lanes/usb2-1}>,
>> +			<&{/padctl@3520000/pads/usb2/lanes/usb2-3}>,
>> +			<&{/padctl@3520000/pads/usb3/lanes/usb3-0}>,
>> +			<&{/padctl@3520000/pads/usb3/lanes/usb3-3}>;
>> +		phy-names = "usb2-1", "usb2-3", "usb3-0", "usb3-3";
>> +	};
>>  };
>> -- 
>> 2.17.1
>>
