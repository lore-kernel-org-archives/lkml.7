Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A032FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2FA20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VTjcw8ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfDJOKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:10:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13362 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730195AbfDJOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:10:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AE63YV026878;
        Wed, 10 Apr 2019 16:10:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=Gfk+0Sx6HSuhi07b3scMEGQqXsv6BB+RNtOMTePDgdQ=;
 b=VTjcw8ftoiyz31rxHSiyhN6WDm5LYV+CPaKWt5aLLMul9dVPwNX+5A9UDpIi+AlUktmZ
 j9rxyhxsEiJAg6YPCMPbn3Fpffo/1tEXTqVx02eVtWKAMUYkOKXQiG0QQca80zzQOqDX
 boN0ApI7gLlDHTydaSDyOcAgydLFjnsw1chs4Vf+XfbLkpQqFdho0Jf+y0JMHbdDQZbJ
 /Lc8meW1xIlHECkw2jG3JxJJUHiTl6//wqF3RgtqNKlN7gAA/wWE/RQRRMRjYUFWwYHo
 6601Fr2T8Mxq2XnYpgziQQXOUvM5TFL03MiZBnBtHt/DnO7/IiGGy7aWdaRUd0+IrcZf YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rprcfgcff-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 16:10:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F52231;
        Wed, 10 Apr 2019 14:10:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0495523FA;
        Wed, 10 Apr 2019 14:10:09 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 16:10:08 +0200
Subject: Re: [PATCH v1 0/2] add cec pins muxing
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
References: <1553863315-6652-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <88623d7b-1258-2c2b-d3ad-ab0069ca2a9d@st.com>
Date:   Wed, 10 Apr 2019 16:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553863315-6652-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 3/29/19 1:41 PM, Yannick Fertré wrote:
> Add cec pins muxing
> 
> Yannick Fertré (2):
>    ARM: dts: stm32: add cec pins muxing on stm32mp157
>    ARM: dts: stm32: add sleep pinctrl for cec on stm32mp157c
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 

Series applied on stm32-next. Note that I squashed the both patches
as they deal only with pins muxing group definition.

Regards
Alex
