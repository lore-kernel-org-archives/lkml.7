Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DDFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F720854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ywpaxjjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbfDJOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:14:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729037AbfDJOOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:14:30 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AECxWD032626;
        Wed, 10 Apr 2019 16:14:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=PqC5BucNDMtSX7BTqc2wgESAc8A9Zkt8nn5xIbqPpU4=;
 b=ywpaxjjC9cqbBuFQi4Sq6QFRr94pJ8CXGTpJ45EA6t2qJOtdAEwDZxsCMn9kPB5CP1Sx
 Q6tRcpdPRg11n0I8oSD5DHRVWvkT/DLph7D+iQEqGu6Zjfl/nXwqg8U0+pEKSu32h3lp
 qDWoVmC8Gbr3aGuF7JdKYx3ChJo27CYrDK8+jHlS0dpkHxwCj2Y3q9oCZkw/TIxN/ASp
 SBqQmcLKyzehcSmTlOIaz2p7xAPtI6uQLR9aTlqp52KH1+ylCCB7mEp6WcANtEq0Pi8y
 O446pIZMkusP7m6MP5N7x4sL5SYkKjGs4vDAWGNe7/DlZ1SfCSFYoOF5Pb3XAV6quZmu Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rprcfgd9g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 16:14:21 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D511A34;
        Wed, 10 Apr 2019 14:14:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF9B7255E;
        Wed, 10 Apr 2019 14:14:20 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 16:14:20 +0200
Subject: Re: [PATCH] ARM: dts: stm32: enable cec on stm32mp157a-dk1 board
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
References: <1553862545-6066-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4e1c85e8-69c7-d511-4f3c-92208d96c852@st.com>
Date:   Wed, 10 Apr 2019 16:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553862545-6066-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 3/29/19 1:29 PM, Yannick Fertré wrote:
> Enable CEC (Consumer Electronics Control) device.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> index 1b1886d..61bc23a 100644
> --- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
> +++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> @@ -46,6 +46,13 @@
>   	};
>   };
>   

Applied on stm32-next.

Thanks.
Alex
