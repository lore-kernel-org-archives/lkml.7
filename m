Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD5C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2BB20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ex9Eg7dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgAIJBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:01:18 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24492 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729069AbgAIJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:01:17 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0098vluo027339;
        Thu, 9 Jan 2020 10:01:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=VrpNqw1ml8Zy129ySb4TfJry+4/8mCEXYVXi+jrwUo4=;
 b=Ex9Eg7dwD08Sqq4AnJ4VKMz3942ON5mW6GSfi09pXE0WW191YtZAisAaWCGBdxfOM/c0
 +L36s7Y8wXA2XNDhbMWlBE3xDgKh0vt4Lp3ZqT1EUHJHNQK0MBS4qJf55ikNF+tpwJdu
 17xK4xrsqfKIbIEIpEkJo/rW/325R8lIcAlTHUqcbK6oYl/eCU1bUp3bXa1CCp6y5AkQ
 XmaNsD3S+ebYb1xpG3BUge2ypZ7lY5wAY2+YlqIpFUimdLhzF+lsBl0Ts2qJivyvioMg
 IrtcXNwgrJZvnCQr5o3b9hiGz8gMT+FqzJXdT7SNR4O4LJSPQxDx3BJri8lVEXNzPM7C VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur0ggh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 10:01:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8495A10002A;
        Thu,  9 Jan 2020 10:01:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AFAB2A4D7B;
        Thu,  9 Jan 2020 10:01:04 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Jan
 2020 10:01:03 +0100
Subject: Re: [PATCH 0/3] Convert STM32 ROMEM to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191219144117.21527-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c3326bf5-f3f8-489b-5245-3b9fd47324bb@st.com>
Date:   Thu, 9 Jan 2020 10:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219144117.21527-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 12/19/19 3:41 PM, Benjamin Gaignard wrote:
> Convert STM32 ROMEM to json-schema and fix the issues detected on stm32 dtsi
> files.
> Note that stm32mp1 patch should be applied on top of the stm32-next tree.
> 
> Benjamin Gaignard (3):
>    dt-bindings: nvmem: Convert STM32 ROMEM to json-schema
>    ARM: dts: stm32: change nvmem node name on stm32f429
>    ARM: dts: stm32: change nvmem node name on stm32mp1
> 
>   .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ---------------
>   .../devicetree/bindings/nvmem/st,stm32-romem.yaml  | 46 ++++++++++++++++++++++
>   arch/arm/boot/dts/stm32f429.dtsi                   |  2 +-
>   arch/arm/boot/dts/stm32mp151.dtsi                  |  2 +-
>   4 files changed, 48 insertions(+), 33 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>   create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> 

DT patches applied on stm32-next.

Thanks
Alex
