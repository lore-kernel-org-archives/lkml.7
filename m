Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57977C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391AE20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OjX4Davv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfDZDVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:21:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13548 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDZDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:21:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc279250000>; Thu, 25 Apr 2019 20:21:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Apr 2019 20:21:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Apr 2019 20:21:12 -0700
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 03:21:09 +0000
Subject: Re: [PATCH v2 03/12] arm64: dts: tegra210: set thermtrip
To:     <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
 <1550744327-4677-4-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <2accde0e-6c6d-fdf9-44fe-479a4330729d@nvidia.com>
Date:   Fri, 26 Apr 2019 11:21:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550744327-4677-4-git-send-email-wni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556248869; bh=fzEjeBf+x6StTaAuZLI5sIZ1lJWjW0CRjRbwtNfe84Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OjX4DavvSitGOvn4vcJYx7GPgCBES/1U+HcVdUDJ2US9txAZR4sQkS6fBvfMktW3Q
         hWSPMqdDM42tknCxzVLvs628Q291tVV0uQICMbYFGypahbMOX1NsJDKQ58MN1Jdf0/
         35wVp5eZyWOXRjlUQgapHwtgwdBsXirNos2nTeTNQhsKTCwKKn/JjIuI0hRECRgF1v
         4PSVIPhraux3r1XOxkrixe1S8KNFSzFtlBVcTFOwmcPDUP9LBD+UklubfLrBAT8RcS
         +ncp//7B3299SO5k7MAEBg/J8ZeDYG9oPN4h5HVUgQ7dRcvfG5MVgjL4+hapE4T9B4
         Ml8IsPClMIScA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Eduardo have picked this series to his branch except dts patches.
Please check
"git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git"
in the linus branch. They will be merged in the next major kernel release.

Could you please take these three dts changes?
Here is the list:
[PATCH v2 03/12] arm64: dts: tegra210: set thermtrip
[PATCH v2 06/12] arm64: dts: tegra210: set gpu hw throttle level
[PATCH v2 10/12] arm64: dts: tegra210: set EDP interrupt line

Thanks.
Wei.

On 21/2/2019 6:18 PM, Wei Ni wrote:
> Set "nvidia,thermtrips" property, it used to set
> HW shutdown temperatures.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 6574396d2257..582d56820bbb 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -1410,6 +1410,9 @@
>  		reset-names = "soctherm";
>  		#thermal-sensor-cells = <1>;
>  
> +		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
> +
>  		throttle-cfgs {
>  			throttle_heavy: heavy {
>  				nvidia,priority = <100>;
> @@ -1429,8 +1432,8 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
>  
>  			trips {
> -				cpu-shutdown-trip {
> -					temperature = <102500>;
> +				cpu-critical-trip {
> +					temperature = <102000>;
>  					hysteresis = <0>;
>  					type = "critical";
>  				};
> @@ -1457,7 +1460,7 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
>  
>  			trips {
> -				mem-shutdown-trip {
> +				mem-critical-trip {
>  					temperature = <103000>;
>  					hysteresis = <0>;
>  					type = "critical";
> @@ -1479,8 +1482,8 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
>  
>  			trips {
> -				gpu-shutdown-trip {
> -					temperature = <103000>;
> +				gpu-critical-trip {
> +					temperature = <102500>;
>  					hysteresis = <0>;
>  					type = "critical";
>  				};
> @@ -1507,7 +1510,7 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
>  
>  			trips {
> -				pllx-shutdown-trip {
> +				pllx-critical-trip {
>  					temperature = <103000>;
>  					hysteresis = <0>;
>  					type = "critical";
> 
