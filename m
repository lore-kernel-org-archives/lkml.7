Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78361C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507F52075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SLO8PHw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKOKuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:50:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35290 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfKOKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:50:15 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFAnPtd001023;
        Fri, 15 Nov 2019 11:50:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=vbNZvQAxWj5aasRHQhk+/qrLFDSdRYRbFikBMduiqK8=;
 b=SLO8PHw1uy4a+p8zkrQ3TXntGbMRI2YlKVg54MJi1bHZhtSDMVktT2weZh08kqmidMye
 F2MVk+poLx/m4YvuyuSZIlW2PJNcmYMBKklbc4gmx+uRbZSoG1zn1k7hCc2jf2+ZY/LP
 smypEYhvomkyxFCYp2W2A0s9PrrqLzv5k8P7E7XdrLjwn0T5m9N2fxGG4jo84eajGywR
 HezBM2bafiKlt+acJORJ/S4P4rbRQ+yE5M3xo+rrExTdrTZHcaxNLv64QyNN6cM6WxSk
 ncX0Y/17oPxCVbpBdcqWz4IrJS1q2M83qSGekBixm4OFVkK04WPD7Ag973ZTnsO2IQA0 iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psk3hcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 11:50:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FE86100048;
        Fri, 15 Nov 2019 11:50:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1EB652B494A;
        Fri, 15 Nov 2019 11:50:02 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov
 2019 11:50:01 +0100
Subject: Re: [PATCH 0/4] Update sdmmc nodes for STM32MP1
To:     Yann Gautier <yann.gautier@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191106100938.11368-1-yann.gautier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <dc5b32b3-4bac-e53e-1fe4-74098231168f@st.com>
Date:   Fri, 15 Nov 2019 11:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106100938.11368-1-yann.gautier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann

On 11/6/19 11:09 AM, Yann Gautier wrote:
> The STM32MP1 SoC embeds 3 instances of the SDMMC internal peripheral.
> The sdmmc2 and sdmmc3 nodes are added in the SoC DT file, as well as
> the required pins configuration.
> The boards DT files are also updated:
> - An eMMC is connected on SDMMC2 on STM32MP157C-ED1 and EV1 boards
> - SDMMC3  can be used on the GPIO expansion pins on EV1 and DK1/DK2
> boards.
> 
> Yann Gautier (4):
>    ARM: dts: stm32: update slew-rate properties for sdmmc1 on stm32mp157
>    ARM: dts: stm32: add sdmmc2 & 3 nodes for STM32MP157 SoC
>    ARM: dts: stm32: enable sdmmc2 node for stm32mp157c-ed1 board
>    ARM: dts: stm32: add sdmmc3 node for STM32MP1 boards
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 200 +++++++++++++++++++++-
>   arch/arm/boot/dts/stm32mp157a-dk1.dts     |  12 ++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts     |  16 ++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  12 ++
>   arch/arm/boot/dts/stm32mp157c.dtsi        |  33 +++-
>   5 files changed, 263 insertions(+), 10 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
