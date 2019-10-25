Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02719CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10020867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TXkFXHkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502178AbfJYKAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:00:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10832 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438786AbfJYKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:00:42 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9P9kCW5017181;
        Fri, 25 Oct 2019 12:00:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=cozhLOP/37XHtN9akdSzaH/2qnPq6K4echcclxy+KZc=;
 b=TXkFXHkPEU3YQyVYzb9uETHLewUEcm4VYOkFLCIiagWyg6yvr5VtyDVLt1xM6EIfK+YB
 rrT0QWElr6UQEkCJOASOn4AkLgZh+1KzAT3puvp6+7kKmyuqcTGjb93r1WIdAji4sNom
 3jngv160BScgGbaR16DayNw4QEBbIBQfakPDMwADPbdpBHWnX3h7mwycs+N1HE1cLYZ3
 G8vfBOtTNPdShRWDCXXcJFDKptjG9EfnQ0yfpUhNPFuahMaFI6Js12KGoJzDosbS7Qng
 XaYdnMmZDUCgVsWrOFJQdk072kI8Rpiuym9Y60R8RxrcYLDTFde+y6g1Mgfyv6Q80aJK HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vt9s56yt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 12:00:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22A8410002A;
        Fri, 25 Oct 2019 12:00:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F5062C2E7C;
        Fri, 25 Oct 2019 12:00:32 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 25 Oct
 2019 12:00:31 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add hdmi audio support to
 stm32mp157a-dk1 board
To:     Olivier Moysan <olivier.moysan@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191010130247.32027-1-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c08018be-a785-57d4-d74f-833d644efff1@st.com>
Date:   Fri, 25 Oct 2019 12:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010130247.32027-1-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_05:2019-10-23,2019-10-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi olivier

On 10/10/19 3:02 PM, Olivier Moysan wrote:
> Add HDMI audio support through Sil9022 HDMI transceiver
> on stm32mp157a-dk1 board.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 

Applied on stm32-next.

Thanks.
Alex

> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> index 5ad4cef9e971..7a20640c00a9 100644
> --- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
> +++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> @@ -92,7 +92,7 @@
>   			"Playback" , "MCLK",
>   			"Capture" , "MCLK",
>   			"MICL" , "Mic Bias";
> -		dais = <&sai2a_port &sai2b_port>;
> +		dais = <&sai2a_port &sai2b_port &i2s2_port>;
>   		status = "okay";
>   	};
>   };
> @@ -173,6 +173,7 @@
>   		reset-gpios = <&gpioa 10 GPIO_ACTIVE_LOW>;
>   		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
>   		interrupt-parent = <&gpiog>;
> +		#sound-dai-cells = <0>;
>   		status = "okay";
>   
>   		ports {
> @@ -185,6 +186,13 @@
>   					remote-endpoint = <&ltdc_ep0_out>;
>   				};
>   			};
> +
> +			port@3 {
> +				reg = <3>;
> +				sii9022_tx_endpoint: endpoint {
> +					remote-endpoint = <&i2s2_endpoint>;
> +				};
> +			};
>   		};
>   	};
>   
> @@ -370,6 +378,23 @@
>   	};
>   };
>   
> +&i2s2 {
> +	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc PLL3_Q>, <&rcc PLL3_R>;
> +	clock-names = "pclk", "i2sclk", "x8k", "x11k";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2s2_pins_a>;
> +	pinctrl-1 = <&i2s2_pins_sleep_a>;
> +	status = "okay";
> +
> +	i2s2_port: port {
> +		i2s2_endpoint: endpoint {
> +			remote-endpoint = <&sii9022_tx_endpoint>;
> +			format = "i2s";
> +			mclk-fs = <256>;
> +		};
> +	};
> +};
> +
>   &ipcc {
>   	status = "okay";
>   };
> 
