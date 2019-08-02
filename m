Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE0C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED68B206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MN/Q2oLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbfHBHiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:38:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41613 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbfHBHiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:38:20 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x727VHxA012501;
        Fri, 2 Aug 2019 09:38:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Zw6evvLZ8m6yaLR9mnd1DofpirwbXXRGnDJlhc2emck=;
 b=MN/Q2oLphZuK3zpF/91e42j0g5rerDQVszJgfHJb6267Q/n1f2cyZWxsYifFNiwylaOr
 +MtI8WLee7Traxh+laMvtDIKmUiC8hAXlsKiXF26Md3JqB9ofkVtEhcLGk8IkV630aZS
 uAxU5Yf86Z9QQMVx0x+/njhllyuaK5sY0oplUVXCRtBVJ8Cqy4q3mvfk1cBnNTiO080r
 NgwGEDxlNCi5KXbUsvTyWhK5JjGfQUQYmhlTTwsyO/w77S9jIzW7iI/hTQ+StazVdcpm
 AJHZWEEnkN+eesbHRZ1B4WsnQKLB5+wAK07IeVsRANcBUkCvdbKCxfJoqQ0Woufc1/E5 mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u3vd05r9c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 09:38:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E44BB3A;
        Fri,  2 Aug 2019 07:38:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C3F862073A6;
        Fri,  2 Aug 2019 09:38:05 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 2 Aug
 2019 09:38:05 +0200
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
To:     <patrice.chotard@st.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <soc@kernel.org>
References: <20190731072204.32160-1-patrice.chotard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d7e1c7d9-d905-1b37-159b-cc3d981af8da@st.com>
Date:   Fri, 2 Aug 2019 09:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731072204.32160-1-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Patrice

On 7/31/19 9:22 AM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Enable support for QSPI block on STM32 SoCs.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 6a40bc2ef271..78d1d93298af 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -403,6 +403,7 @@ CONFIG_SPI_SH_MSIOF=m
>   CONFIG_SPI_SH_HSPI=y
>   CONFIG_SPI_SIRF=y
>   CONFIG_SPI_STM32=m
> +CONFIG_SPI_STM32_QSPI=m
>   CONFIG_SPI_SUN4I=y
>   CONFIG_SPI_SUN6I=y
>   CONFIG_SPI_TEGRA114=y
> 

Applied on stm32-next.

Thanks.
Alex
