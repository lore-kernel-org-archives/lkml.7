Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D65C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE712173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="UGu79PUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEUImD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:42:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38983 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfEUImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:42:02 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L8fIqW005386;
        Tue, 21 May 2019 10:41:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=QyWJvNYHLKsmU03kGqyqMWFY0xSKENVAb1xh5I0LmvA=;
 b=UGu79PUJOqtgrDum7WsBudYZoYlcDCl1ksh+75EHx+F81wT/RshofvK7wDEOSOCLI2UV
 Gm2qBlpnQtXwLPIptHMKZQ8CWaELA3gn3ArEDUEu6OomHKCYIGaZbhGVInoRV5ZVEnsY
 nJH24r+AUEAncxAnmXoHgw8H3W0pv+wb9W69A+uiVlcndqejok/NVEjayRaDKjBSjtUz
 yDrozQpEza6z4L5s8yjgUn4HWNm48mPe912ZDLesbvTvr//tOgnCIS/j2GQFCa2WRU/W
 o1HmQPz3OAEPpi5f4dWGURnAxRYKyCEUZdhwfdBow1iTsn/mJL8hkTPqXuRczzMTDwR7 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7tu06s7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 10:41:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E86138;
        Tue, 21 May 2019 08:41:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7ABEC243F;
        Tue, 21 May 2019 08:41:47 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 May
 2019 10:41:46 +0200
Subject: Re: [PATCH 0/2] ARM: dts: stm32: qspi update for stm32mp157c-ev1
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1552057823-10876-1-git-send-email-ludovic.Barre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4932a2fd-eca1-d802-812a-7246b3dd12ec@st.com>
Date:   Tue, 21 May 2019 10:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1552057823-10876-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic

On 3/8/19 4:10 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series add sleep pins configuration needed to suspend support
> and add jedec compatible for 2 nor flash of stm32mp157c-ev1.
> 
> Ludovic Barre (2):
>    ARM: dts: stm32: add pinctrl sleep config for qspi on stm32mp157c-ev1
>    ARM: dts: stm32: add jedec compatible for nor flash on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 26 ++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  5 ++++-
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 

Series applied on stm32-next.

Regards
Alex
