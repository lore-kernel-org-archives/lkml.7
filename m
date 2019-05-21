Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1024FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0C52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VfMr2Hkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfEUIx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:53:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44237 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbfEUIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:53:54 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L8fIda005383;
        Tue, 21 May 2019 10:53:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=UPl9cMLd/jz3BJgxLaiHt4XCIbnglMdgLWCuCTS6vvg=;
 b=VfMr2HkbAldoxufbvO1631fAPiVUF/WVx7wOIB6xoSSCAlVewatvqak8ux9pHEJVXy6L
 1BbU80hb0R3rh39tpKOL4q3StSIUtUvn+tfzLHVLLOe9X6bu6hWfBHygWqZUuP4DVr/w
 Lw7BjptedS47bMtJ4PYkZMaAlfZo34hXjErEz/COFPzXvgfjPS6Urm8Y6lUBWx63eUm8
 pZlmr2P6zoVkbUeyy8d6v+dl90rk2zMm/yLFh/mTZUMZs2PZMlWjYXQbP5lm4cz/t0K3
 cnnrueXj+GZKtNBT8n9+diR8fgT2WKGRaEKYFVjskWRO4ElOQck+PbSH+xZT538Iffpq 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7tu08t1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 10:53:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63D6938;
        Tue, 21 May 2019 08:53:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4E182450;
        Tue, 21 May 2019 08:53:41 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 May
 2019 10:53:41 +0200
Subject: Re: [Linux-stm32][PATCH 0/4] ARM: dts: stm32: add i2s and sai support
 on stm32mp157c
To:     Olivier Moysan <olivier.moysan@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <79b6d8c7-5756-26eb-1e26-534890e712e1@st.com>
Date:   Tue, 21 May 2019 10:53:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 4/25/19 4:10 PM, Olivier Moysan wrote:
> This patchset adds support of STM32 SAI and I2S on stm32mp157c
> 
> Olivier Moysan (4):
>    ARM: dts: stm32: add sai support on stm32mp157c
>    ARM: dts: stm32: add sai pins muxing on stm32mp157
>    ARM: dts: stm32: add i2s support on stm32mp157c
>    ARM: dts: stm32: add i2s pins muxing on stm32mp157
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  92 +++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 158 ++++++++++++++++++++++++++++++
>   2 files changed, 250 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
