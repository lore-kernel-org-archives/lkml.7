Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0927C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991CB21734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hK/jrgE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfGZQWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:22:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26872 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727461AbfGZQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:22:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QG7fWM014148;
        Fri, 26 Jul 2019 18:22:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=8uknQWRYc0ctwojlhiO1IFxUbdNNf9KGmiNaqsxedGA=;
 b=hK/jrgE+HR7IWIPUmAZBr74PpQh9KHWaD3+owSOCBUwcODXMOIvjvCjoufdDHeeT85/6
 OihgaQ8odbwYk2ppO6W/SdZNGlcb9CzOOSMN4o7WffzWivV75G6OdFNdO6IvuZl3uHeR
 Rr41uYaC8zctr1fH5ju7K/R7xFrj0S/66Gaahi6frYu8ifvZUEGlroSbovaUpUsDkE57
 f0oPhrkBXfcQn8Yznf/EkKtPFAwosc3J/SwW8QZdjuISmSo/Pjsq6ltMJH/pTBfsXd5x
 lRxyopZIM7SA9l6PFTgFhkyAPj8zpF/UpMb1xHlvGTJZSO1ydKdIkn/fDZgvFXoma2d6 sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tx60abrvn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Jul 2019 18:22:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49A0D31;
        Fri, 26 Jul 2019 16:22:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B2514FB8;
        Fri, 26 Jul 2019 16:22:26 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Jul
 2019 18:22:25 +0200
Subject: Re: [PATCH v2 0/4] regulator: add support for the STM32 ADC booster
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <1561968865-22037-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d8bc0f0d-adc6-abd6-f248-94c72b360b00@st.com>
Date:   Fri, 26 Jul 2019 18:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1561968865-22037-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 7/1/19 10:14 AM, Fabrice Gasnier wrote:
> Add support for the 3.3V booster regulator embedded in stm32h7 and stm32mp1
> devices, that can be used to supply ADC analog input switches.
> It's useful to reach full ADC performance when their supply is below 2.7V
> (vdda by default).
> 
> Changes in v2:
> - rebase on top of for-next branch
> 
> Fabrice Gasnier (4):
>    dt-bindings: regulator: add support for the stm32-booster
>    regulator: add support for the stm32-booster
>    ARM: multi_v7_defconfig: enable STM32 booster regulator
>    ARM: dts: stm32: add booster for ADC analog switches on stm32mp157c
> 
>   .../bindings/regulator/st,stm32-booster.txt        |  18 +++
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   6 +
>   arch/arm/configs/multi_v7_defconfig                |   1 +
>   drivers/regulator/Kconfig                          |  11 ++
>   drivers/regulator/Makefile                         |   1 +
>   drivers/regulator/stm32-booster.c                  | 132 +++++++++++++++++++++
>   6 files changed, 169 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
>   create mode 100644 drivers/regulator/stm32-booster.c
> 

DT patch + config applied in stm32-next.

regards
alex
