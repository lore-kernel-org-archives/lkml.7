Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663852189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="u0db09ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfH2It1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:49:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36661 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfH2It1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:49:27 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T8kxr5031268;
        Thu, 29 Aug 2019 10:48:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=NlGM32ocdpPWCJcOtDVLjpgH+SvU7mlXgBdhDT7M+X8=;
 b=u0db09ugjsVglBswXP+mVOWomLQtCDERzWqyS+4Tpnl9MaCsmoTNFiPCKzdfA50T6D7C
 C+GbQFCz9y6h5qxvB99GS73qVvw+KBZ69vEVNNDHZmhmS15jbzNJVBCyDo2rYNVPA0M7
 AyM0nNRswqEa8rgxhWc9dSev0UQYkJERN5IjBULZUiyCR/eN9O5v/jIbbg2kSa8HokzD
 rtGaXJ45MtbkV2OIbOKlJc3uFrOvxL1SpY0kxAVa5WkVxmObe6Qqx27tr3PO4f2e0oac
 pDQVtheQDemuJ/HUlrZ3smKV1zedt2eG+UZXZqQCz4eKkIaj21L5ZvS8MsZ+wsLUnvfD 2g== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2unujk470g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 29 Aug 2019 10:48:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F4B04D;
        Thu, 29 Aug 2019 08:48:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E22742AD3F3;
        Thu, 29 Aug 2019 10:48:46 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 29 Aug
 2019 10:48:46 +0200
Subject: Re: [PATCH v3 5/5] ARM: dts: stm32: add ddrperfm on stm32mp157c
To:     Gerald BAEZA <gerald.baeza@st.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
 <1566918464-23927-6-git-send-email-gerald.baeza@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8e3170a3-c814-d06e-f1f9-6d4e6a4bed71@st.com>
Date:   Thu, 29 Aug 2019 10:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566918464-23927-6-git-send-email-gerald.baeza@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerald

On 8/27/19 5:08 PM, Gerald BAEZA wrote:
> The DDRPERFM is the DDR Performance Monitor embedded
> in STM32MP1 SOC.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi 
> b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 0c4e6eb..6ea6933 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -1378,6 +1378,14 @@
>                           };
>                   };
> 
> +               ddrperfm: perf@5a007000 {
> +                       compatible = "st,stm32-ddr-pmu";
> +                       reg = <0x5a007000 0x400>;
> +                       clocks = <&rcc DDRPERFM>;
> +                       resets = <&rcc DDRPERFM_R>;
> +                       status = "okay";

No need to add "status = "okay"" here.

regards
Alex

> +               };
> +
>                   usart1: serial@5c000000 {
>                           compatible = "st,stm32h7-uart";
>                           reg = <0x5c000000 0x400>;
> -- 
> 2.7.4
