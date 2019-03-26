Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DFFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5C2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfCZKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:37:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36496 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfCZKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:37:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QAbGVm026987;
        Tue, 26 Mar 2019 11:37:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbgvds-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 11:37:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 766799C;
        Tue, 26 Mar 2019 10:37:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DCD65397;
        Tue, 26 Mar 2019 10:37:28 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 11:37:27 +0100
Subject: Re: [PATCH 0/8] stm32 m4 remoteproc on STM32MP157c
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <695af4c3-b3fe-183f-02c7-fd080048b29c@st.com>
Date:   Tue, 26 Mar 2019 11:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi fabien

On 3/5/19 3:24 PM, Fabien Dessenne wrote:
> STMicrolectronics STM32MP157 MPU are based on a Dual Arm Cortex-A7 core and a
> Cortex-M4.
> This patchset adds the support of the stm32_rproc driver allowing to control
> the M4 remote processor.
> 
> Fabien Dessenne (8):
>    dt-bindings: stm32: add bindings for ML-AHB interconnect
>    dt-bindings: remoteproc: add bindings for stm32 remote processor
>      driver
>    remoteproc: stm32: add an ST stm32_rproc driver
>    ARM: dts: stm32: add m4 remoteproc support on STM32MP157c
>    ARM: dts: stm32: declare copro reserved memories on STM32MP157c-ed1
>    ARM: dts: stm32: enable m4 coprocessor support on STM32MP157c-ed1
>    ARM: dts: stm32: declare copro reserved memories on STM32MP157a-dk1
>    ARM: dts: stm32: enable m4 coprocessor support on STM32MP157a-dk1
> 
>   .../devicetree/bindings/arm/stm32/mlahb.txt        |  30 +
>   .../devicetree/bindings/remoteproc/stm32-rproc.txt |  67 +++
>   arch/arm/boot/dts/stm32mp157a-dk1.dts              |  54 ++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |  54 ++
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |  21 +
>   drivers/remoteproc/Kconfig                         |  15 +
>   drivers/remoteproc/Makefile                        |   1 +
>   drivers/remoteproc/stm32_rproc.c                   | 624 +++++++++++++++++++++
>   8 files changed, 866 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
>   create mode 100644 drivers/remoteproc/stm32_rproc.c
> 

Concerning DT patches, at first glance I don't see obvious issues. I'll 
take Dt patches as soon as driver and bindings patches are acked.

regards
Alex
