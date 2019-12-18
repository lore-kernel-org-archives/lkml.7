Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF95C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0368921582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dLE/tJJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLROYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:24:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41016 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbfLROYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:24:10 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEI8XQ027223;
        Wed, 18 Dec 2019 15:24:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iP+ouA5h5Ds2xOy1AQcTUhmRFYphYpHN7RHHBS1IQHc=;
 b=dLE/tJJThQ588N0gz8sg+Aun1R86QQ4q5iiIX3WKpeK7SXohdeQKn2RM92q13WbF9lDF
 hZ9g87AoWb2SJpVxrU/vOWgwBVtaObfZ7R+/NNMjpWZq2aNkxNFRTBOyXl3mQ5VuALZy
 akpzA00zi8wB5mbbvfYSthQshxIMouWCkiTOxpIRmbYeKgTfQoU86YTotbAVnknEgYl4
 RSfioEuuUx9J6nU9OLSybzqgTB5H/F47A5l6BJquE96f1HEKSahqi+DdZMuZMJVXuHNM
 /7B5ZnPboRF737zclOqJXBUlUk+Qzid62Sk8DubnrvDA5cNh7FsCMCuf33UhyMBXiQ99 ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvqgpvhv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:24:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E9F76100038;
        Wed, 18 Dec 2019 15:23:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DEEC8210D29;
        Wed, 18 Dec 2019 15:23:57 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec
 2019 15:23:57 +0100
Subject: Re: [PATCH] ARM: dts: stm32: update mlahb node according to the
 bindings
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20191218085710.2142-1-arnaud.pouliquen@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <181f8e80-5042-0923-c231-c0bed47a118d@st.com>
Date:   Wed, 18 Dec 2019 15:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218085710.2142-1-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud

On 12/18/19 9:57 AM, Arnaud Pouliquen wrote:
> Update of the mlahb node according to to DT bindings using json-schema
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index ed8b258256d7..be04eab7f139 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -1513,10 +1513,11 @@
>   		};
>   	};
>   
> -	mlahb {
> -		compatible = "simple-bus";
> +	mlahb: ahb {
> +		compatible = "st,mlahb", "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> +		ranges;
>   		dma-ranges = <0x00000000 0x38000000 0x10000>,
>   			     <0x10000000 0x10000000 0x60000>,
>   			     <0x30000000 0x30000000 0x60000>;
> 

For  DT patches, please rebase your patches on stm32-next. Major updates 
have been done for STM DT diversity.

Thanks in advance.

Alex
