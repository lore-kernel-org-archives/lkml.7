Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194ADC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E647920740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Vs3dLVaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfKOKhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:37:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5320 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbfKOKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:37:49 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFAWQiT028677;
        Fri, 15 Nov 2019 11:37:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ousFJn9iJUrzpf2LIHmiL0+y3ehrao/jdi7laTUbdv4=;
 b=Vs3dLVaX2bTHsn6YGNPM0+68RyoakepcWmq3eNhFSSgdV4UCC/xpY4dDjI/bXmxpF4zM
 meRNbVUDv9oMMf8rJ79DMRQd2Q90pht4DLRQWmoEbSQ7eI9KV7w6iaIU6tBHSt6AtaZg
 J5rUBmyYvTNokUcDE5LdL6+01ys9D2HJWFnbRfCgMwaKscQR5yLFjkbya2wMHSWAdzUx
 cJnwS6G+mRNWaU41VOdHp6K8oX8OxH2MEGVGg1iVwSz2NgfxkhVW796GFXunR23RQIdT
 7f3zOQRXeg4VfwUICH90euox84qSjKeu5GpQXvcyQ5ZSJBAi31H6Nltdma6ch9uYJ8V+ AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7psfkmmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 11:37:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA686100034;
        Fri, 15 Nov 2019 11:37:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B7FA2B3F80;
        Fri, 15 Nov 2019 11:37:39 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov
 2019 11:37:39 +0100
Subject: Re: [PATCH 0/4] Update PWM support on stm32mp157 boards
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <afba0f85-b7db-41de-f6f6-bcff1be1b0c0@st.com>
Date:   Fri, 15 Nov 2019 11:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_02:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 11/5/19 1:52 PM, Fabrice Gasnier wrote:
> This series update PWM support on stm32mp157c-ev1 and stm32mp157a-dk1
> boards, e.g. add pinmuxing and use them in board device-tree.
> - Add PWM sleep pins that can be used on stm32mp157c-ev1 board
> - Add PWM pins that can be used on stm32mp157a-dk1 board
> - Add PWM pinctrl sleep state on stm32mp157c-ev1 board
> - Add PWM support on stm32mp157a-dk1 board
> 
> Fabrice Gasnier (4):
>    ARM: dts: stm32: add pwm sleep pin muxing for stm32mp157c-ed1
>    ARM: dts: stm32: add pwm pin muxing for stm32mp157a-dk1
>    ARM: dts: stm32: add pwm sleep pins to stm32mp157c-ev1
>    ARM: dts: stm32: add support for PWM on stm32mp157a-dk1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 99 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157a-dk1.dts     | 85 ++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  9 ++-
>   3 files changed, 190 insertions(+), 3 deletions(-)
> 

Series applied on stm32-next. I just rename patch1 to be more coherent 
with your explanation done in cover letter.

Regards
Alex
