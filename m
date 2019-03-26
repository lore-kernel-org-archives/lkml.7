Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E874EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AC320857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfCZLTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:19:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15608 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbfCZLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:18:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QB6l8W017864;
        Tue, 26 Mar 2019 12:18:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbh3xr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 12:18:45 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9112D31;
        Tue, 26 Mar 2019 11:18:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66AA95539;
        Tue, 26 Mar 2019 11:18:44 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 12:18:43 +0100
Subject: Re: [PATCH 0/3] ARM: dts: stm32: IPCC mailbox support on STM32MP157c
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1551431919-23410-1-git-send-email-fabien.dessenne@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <1ab227d3-5024-021d-f11c-78e14a997804@st.com>
Date:   Tue, 26 Mar 2019 12:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551431919-23410-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien

On 3/1/19 10:18 AM, Fabien Dessenne wrote:
> Support IPCC mailbox on STM32MP157c-ed1 and STM32MP157a-dk1 boards.
> 
> Fabien Dessenne (3):
>    ARM: dts: stm32: add IPCC mailbox support on STM32MP157c
>    ARM: dts: stm32: enable IPCC mailbox support on STM32MP157c-ed1
>    ARM: dts: stm32: enable IPCC mailbox support on STM32MP157a-dk1
> 
>   arch/arm/boot/dts/stm32mp157a-dk1.dts |  4 ++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts |  4 ++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 15 +++++++++++++++
>   3 files changed, 23 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
