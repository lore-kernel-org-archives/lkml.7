Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147CA2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JAsZuyU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfGXQkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:40:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49414 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbfGXQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:40:46 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OGbU5Y003589;
        Wed, 24 Jul 2019 18:40:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=Gu8PL+HPgCs9mmUoJ3vhnljVENbzJVpSz1qAO84aocw=;
 b=JAsZuyU3tjo6HSeBGSxRmEhD7qoTjF+evI+JBGMBu9r3sxJs6ep4hXIYfFolF7+p4goG
 B+gM6Tsdm/GlTegxus7N9bpX94fI5JBvOnIkaqlvcylFBHeSIWrIxwgUg+uoQKsCIih3
 EbnrC1IdesihaOFkTJyJeC+018uaJRUjYYB6TaqXzvkNzy8EU0HVRTEqmErvDzQUq/Wr
 0HgtY9riCzrr6gOicQNZroYF6c+nCp/XqClpqra3FOuz+j/g5iZs0596NGz4rPtc0vne
 SWT4wWoHSN4vAEK9Dw1iooBqOATr/67xRRMzEY4LQUImbfiLQyOf7M0zzThPzSaVpu9A dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tx607xgbp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jul 2019 18:40:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71EBF31;
        Wed, 24 Jul 2019 16:40:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55A73521B;
        Wed, 24 Jul 2019 16:40:33 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Jul
 2019 18:40:32 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add audio codec support on
 stm32mp157a-dk1 board
To:     Olivier Moysan <olivier.moysan@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1562327580-19647-1-git-send-email-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <27476214-07fe-886b-1cab-20902837f29c@st.com>
Date:   Wed, 24 Jul 2019 18:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562327580-19647-1-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 7/5/19 1:53 PM, Olivier Moysan wrote:
> Add support of Cirrus cs42l51 audio codec on stm32mp157a-dk1 board.
> Configuration overview:
> - SAI2A is the CPU interface used for the codec audio playback
> - SAI2B is the CPU interface used for the codec audio record
> - SAI2A is configured as a clock provider for the audio codec
> - SAI2A&B are configured as slave of the audio codec
> - SAI2A&B share the same interface of the audio codec
> 
> Note:
> In master mode, cs42l51 audio codec provides a bitclock
> at 64 x FS, regardless of data width. This means that
> slot width is always 32 bits.
> Set slot width to 32 bits and slot number to 2
> in SAI2A&B endpoint nodes, to match this constraint.
> dai-tdm-slot-num and dai-tdm-slot-width properties are used here,
> assuming that i2s is a special case of tdm, where slot number is 2.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 89 +++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)
> 

...

>   
> +&sai2 {
> +	clocks = <&rcc SAI2>, <&rcc PLL3_Q>, <&rcc PLL3_R>;
> +	clock-names = "pclk", "x8k", "x11k";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sai2a_pins_a>, <&sai2b_pins_b>;
> +	pinctrl-1 = <&sai2a_sleep_pins_a>, <&sai2b_sleep_pins_b>;
> +	status = "okay";
> +
> +	sai2a: audio-controller@4400b004 {
> +		#clock-cells = <0>;
> +		dma-names = "tx";
> +		clocks = <&rcc SAI2_K>;
> +		clock-names = "sai_ck";
> +		status = "okay";
> +
> +		sai2a_port: port {
> +			sai2a_endpoint: endpoint {
> +				remote-endpoint = <&cs42l51_tx_endpoint>;
> +				format = "i2s";
> +				mclk-fs = <256>;
> +				dai-tdm-slot-num = <2>;
> +				dai-tdm-slot-width = <32>;
> +			};
> +		};
> +	};
> +
You could use label to overload sai2a and sai2b. no ?

> +	sai2b: audio-controller@4400b024 {
> +		dma-names = "rx";
> +		st,sync = <&sai2a 2>;
> +		clocks = <&rcc SAI2_K>, <&sai2a>;
> +		clock-names = "sai_ck", "MCLK";
> +		status = "okay";
> +
> +		sai2b_port: port {
> +			sai2b_endpoint: endpoint {
> +				remote-endpoint = <&cs42l51_rx_endpoint>;
> +				format = "i2s";
> +				mclk-fs = <256>;
> +				dai-tdm-slot-num = <2>;
> +				dai-tdm-slot-width = <32>;
> +			};
> +		};
> +	};
> +};
> +
>   &sdmmc1 {
>   	pinctrl-names = "default", "opendrain", "sleep";
>   	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> 
