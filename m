Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B072C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="C4A8aYSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLRQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:48:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24016 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfLRQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:48:09 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIGiM9c017256;
        Wed, 18 Dec 2019 17:47:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=hotd3mZ8fmPE7JI8P99BBUl8p+25O/Q4/tedj2kCByI=;
 b=C4A8aYSBOwg+vBmlAMX12llGQ//NjCOtQ8FmpbZ5cRUEO+J7tDh0lEZRh0RQZwamV1Ss
 csFAi0hoFqJKK6If4VbfnZfczgr/uYSC6oel6hkEHNwYf+7+Ymn8fVA8IeSr8kX/ZHLG
 0ZHh0MHetHtLeEl7sQaZ39ex2XesHT/BQtakVo/GYf/R+30KlCxOFgt4f5gor7p/2fkx
 qZcxDDx3PeC+Iu9AHR9ooUzcwAd3m+zeSAlC5a2jK3F8pCAL6Yi5bjaoakjwU1BXhYFn
 gUtvFcZkaEJryIJenGvOf0LMwMdL5bP3k6WttTu1d/KKFL8Qp+zGi4qPYm72cG++ChE7 cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1nbpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 17:47:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7141310002A;
        Wed, 18 Dec 2019 17:47:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E07D2B4B01;
        Wed, 18 Dec 2019 17:47:58 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec
 2019 17:47:57 +0100
Subject: Re: [PATCH v2 0/3] Convert STM32 dma to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191218144844.7481-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <17dbe601-ac37-21e1-1cb5-1b7a3167bca1@st.com>
Date:   Wed, 18 Dec 2019 17:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218144844.7481-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_05:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 12/18/19 3:48 PM, Benjamin Gaignard wrote:
> version 2: Only contains rebased dtsi file on top of stm32-next after
> DT diversity patches
> 
> This series convert STM32 dma, mdma and dmamux bindings to json-schema.
> Yaml bindings use dma-controller and dma-router schemas where nodes names
> are verified which lead to fix stm32f746, stm32f743 and stm32mp157 device
> tree files.
> 
> 
> Benjamin Gaignard (3):
>    ARM: dts: stm32: fix dma controller node name on stm32f746
>    ARM: dts: stm32: fix dma controller node name on stm32f743
>    ARM: dts: stm32: fix dma controller node name on stm32mp157c
> 
>   arch/arm/boot/dts/stm32f746.dtsi  | 4 ++--
>   arch/arm/boot/dts/stm32h743.dtsi  | 6 +++---
>   arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 

Series applied on stm32-next.

regards
Alex
