Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A4C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908BE20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="c6ntOlc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfLIOoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:44:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbfLIOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:44:10 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9Egjpg017551;
        Mon, 9 Dec 2019 15:43:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=vKx6OPdSeYJTuRGa0bHCD2tYSeg+UtY9A3haTmI2eKA=;
 b=c6ntOlc126VLKeqyu4GAC4nsRoo7L/y/wpleFu9k1K+1s90MlQADGV2W+omSCJCO3CvN
 EyJtnea6Ee3WS9nY/7HUgXOMnAg1Q+E2DGu5F7gHrOtsvZ9pbKRa3nD5kYUmbOR5pt2x
 ah1hkDXaCytdccqyyaH++WgfekYbeVLs76peteDiSzhFC/LaCP31IocckHdvEOA/Xx+X
 Aa4o3Nhws5Np5oqMvE85guQd3c5PJmv/Jwvm91G2SGNdt+7tbr0awKQOFHZkDxxT2G+A
 T6soWnVEfm7PhN1YgDLqZuruHnHt+7AcTziV0LU+HJ8+ZRhQE465zo4K4C/C5hBq7fKu vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wradh7xe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Dec 2019 15:43:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C39910002A;
        Mon,  9 Dec 2019 15:43:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CA812D3765;
        Mon,  9 Dec 2019 15:43:51 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Dec
 2019 15:43:50 +0100
Subject: Re: [PATCH 5/5] ARM: dts: stm32: add phy-names to usbotg_hs on
 stm32mp157c-ev1
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191121161259.25799-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <181a4a40-f54c-3559-aaa9-9443fb2153ac@st.com>
Date:   Mon, 9 Dec 2019 15:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121161259.25799-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie,

On 11/21/19 5:12 PM, Amelie Delaunay wrote:
> phy-names is required by usbotg_hs driver to get the phy, otherwise, it
> considers that there is no phys property.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index 2010f6292a77..228e35e16884 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -355,6 +355,7 @@
>   &usbotg_hs {
>   	dr_mode = "peripheral";
>   	phys = <&usbphyc_port1 0>;
> +	phy-names = "usb2-phy";
>   	status = "okay";
>   };
>   
> 


Series applied on stm32-next.

Note: due to new STM32 diversity I renamed some patches.

Regards
Alex
