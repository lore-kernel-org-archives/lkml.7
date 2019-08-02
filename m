Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6041AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329E220665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zm2XtCa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390730AbfHBIKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:10:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58222 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730124AbfHBIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:09:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7288Bvv009958;
        Fri, 2 Aug 2019 10:09:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=gaaRv63ENU5q6qe9vvfpQktX48Za4fd5PyQsVa2fLQg=;
 b=zm2XtCa+Wcf132W4eBFa5nnuhBxeZPXJGsuW9Hsc0wHERRENLrzDqM4vXQwnRPTmazFc
 DazbXClMUkHKwDWRgMag6Gr5Od5LGuMhWYn2lfjfgEJCMSpHZWpv2QsoFCxVunj3m2mk
 Vs/uVQ6zTniQTUTkQiJ5xcPC2lVQaLteHEA2jV21LnWqvci5CgcWIMKYFiDP86xpgaEv
 DBF8T5Ft2BGJ8gVf7WEAi/RIG2srVnnNgQ/NVbl29JhXLh/CgCiffBpn8OqOuieaV/Qg
 BJn8J3NTePBQlv/OF8D6tifdr8tdjeBRAghQ6D1KN+jBBEv/IvpzgaH9VSISSzd2nTt3 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u2jp4t6fk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 10:09:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE45638;
        Fri,  2 Aug 2019 08:09:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98947207455;
        Fri,  2 Aug 2019 10:09:47 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 2 Aug
 2019 10:09:47 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add DFSDM pins to stm32mp157c
To:     Olivier Moysan <olivier.moysan@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1564645567-13156-1-git-send-email-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a95e5d74-c8e3-42f9-cabf-f42623aee255@st.com>
Date:   Fri, 2 Aug 2019 10:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564645567-13156-1-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 8/1/19 9:46 AM, Olivier Moysan wrote:
> Add DFSDM pins to stm32mp157c.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 39 +++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> index 9eaec9bf8cb8..f96a928cbc49 100644
> --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> @@ -230,6 +230,45 @@
>   				};
>   			};
>   

I use to only take pinconfig which are used in board. So please resend 
with the "board patch".

regards
Alex


> +			dfsdm_clkout_pins_a: dfsdm-clkout-pins-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('B', 13, AF3)>; /* DFSDM_CKOUT */
> +					bias-disable;
> +					drive-push-pull;
> +					slew-rate = <0>;
> +				};
> +			};
> +
> +			dfsdm_clkout_sleep_pins_a: dfsdm-clkout-sleep-pins-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('B', 13, ANALOG)>; /* DFSDM_CKOUT */
> +				};
> +			};
> +
> +			dfsdm_data1_pins_a: dfsdm-data1-pins-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('C', 3, AF3)>; /* DFSDM_DATA1 */
> +				};
> +			};
> +
> +			dfsdm_data1_sleep_pins_a: dfsdm-data1-sleep-pins-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('C', 3, ANALOG)>; /* DFSDM_DATA1 */
> +				};
> +			};
> +
> +			dfsdm_data3_pins_a: dfsdm-data3-pins-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('F', 13, AF6)>; /* DFSDM_DATA3 */
> +				};
> +			};
> +
> +			dfsdm_data3_sleep_pins_a: dfsdm-data3-sleep-pins-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('F', 13, ANALOG)>; /* DFSDM_DATA3 */
> +				};
> +			};
> +
>   			ethernet0_rgmii_pins_a: rgmii-0 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> 
