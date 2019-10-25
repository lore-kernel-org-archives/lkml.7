Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE04CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5397D20663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aYjOYOL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502501AbfJYKGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:06:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28296 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502231AbfJYKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:05:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9P9kQvn028292;
        Fri, 25 Oct 2019 12:05:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=n2MLxqp2NxcGExWiPF20RRSPXekUyzL4iy5WQSoD2ZM=;
 b=aYjOYOL3VyFlDt4YRVhrG0Ose2rOahNd/PoPgFPdENXNzTxlEdUu371CqoRQ9hG5cmsB
 leolSO7dQizetVC1Nda94JXsHhjziZ9oXJj6CpwDX5PreSJF3QBlBc0z2ZM9ZUtbX6vt
 XVnq+eH6posVSvGYdHQs/mgVnKeq33k3Pk6EkLsT9Xa3JEqexe5xhvZ1ECvno6Z/QMNw
 ERVhq+3np8T4SKWrnCDI4h34jbHCnypL0aXr77N0SOZB60TTU1hQKTLbEAgOKAE1Cesy
 xdn1FotV/GUiGEx0cxf6IzV54RixaxZyiAmmRAFCFfq81qEqXhQNompRdW2jJQpOvsv1 rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vt9s4f2ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 12:05:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6840B100039;
        Fri, 25 Oct 2019 12:05:49 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 558392C2E8B;
        Fri, 25 Oct 2019 12:05:49 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 25 Oct
 2019 12:05:48 +0200
Subject: Re: [PATCH] ARM: dts: stm32f469: remove useless dma-ranges property
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191015123058.14669-1-benjamin.gaignard@st.com>
 <20191015123058.14669-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <dd501071-98b1-9635-ac2e-810b60aa892a@st.com>
Date:   Fri, 25 Oct 2019 12:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015123058.14669-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_05:2019-10-23,2019-10-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 10/15/19 2:30 PM, Benjamin Gaignard wrote:
> Remove dma-ranges from ltdc node since it is already set
> on bus node.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f469-disco.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index a3ff04940aec..c928126d5b7e 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -166,7 +166,6 @@
>   };
>   
>   &ltdc {
> -	dma-ranges;
>   	status = "okay";
>   
>   	port {
>

Applied on stm32-next. For the next time commit header has to be 
formatted like that:

ARM: dts: stm32: .....

Thanks.
Alex
