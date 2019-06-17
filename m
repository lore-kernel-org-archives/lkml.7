Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8937DC31E59
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623552087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Xn3sBMkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfFQM3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:29:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35114 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728039AbfFQM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:28:19 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HCLCqf009408;
        Mon, 17 Jun 2019 14:28:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=E9NXlEGXNnvQZ3RULpw4oSl2qhYRA7pqUq0NxFi2maM=;
 b=Xn3sBMkfKYiuf6tnzB0nw/OrQ40k70XSyR3NVXIQ0Tyf8cgYlIClW771t+KqxiHkmQ7J
 Sl3H+GM6khJ7nB8zFPqU5RKM2siZIzdyCvSVaD5aKjcSSHjRcnbjam5zH5mCB9XunpMO
 drxsAYB1f4oqSBPcsHMCIIWdBf1e47fdq6Q+Vvx6dIJOXt5GJI7mRoDWbx42/zhySbHj
 n02S3xT2j0qnnBLjypHU37Nx73VwNIkVgTozZ9Efpyinwz+CThn65YlcQzo38Bq1KwUr
 OVjJM2CQXCXAbHWjBFf+SbrmMOQqBAQGJHB1ILAFIZNc85414UIu0s/PM+LfPiiOVVGT pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhte0v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Jun 2019 14:28:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 935DB3A;
        Mon, 17 Jun 2019 12:28:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69B6829A9;
        Mon, 17 Jun 2019 12:28:06 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Jun
 2019 14:28:05 +0200
Subject: Re: [PATCH v4 0/4] Add Avenger96 board support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <loic.pallardy@st.com>
References: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e34e8160-d16e-bf18-e7c3-240098908df2@st.com>
Date:   Mon, 17 Jun 2019 14:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 6/12/19 9:54 AM, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds Avenger96 board support. This board is one of the
> Consumer Edition boards of the 96Boards family from Arrow Electronics
> featuring STM32MP157A MPU and has the following features:
> 
> SoC: STM32MP157AAC
> PMIC: STPMIC1A
> RAM: 1024 Mbyte @ 533MHz
> Storage: eMMC v4.51: 8 Gbyte
>           microSD Socket: UHS-1 v3.01
> Ethernet Port: 10/100/1000 Mbit/s, IEEE 802.3 Compliant
> Wireless: WiFi 5 GHz & 2.4GHz IEEE 802.11a/b/g/n/ac
>            Bluetooth®v4.2 (BR/EDR/BLE)
> USB: 2x Type A (USB 2.0) Host and 1x Micro B (USB 2.0) OTG
> Display: HDMI: WXGA (1366x768)@ 60 fps, HDMI 1.4
> LED: 4x User LED, 1x WiFi LED, 1x BT LED
> 
> More information about this board can be found in 96Boards website:
> https://www.96boards.org/product/avenger96/
> 
> Thanks,
> Mani
> 

Thanks to extend the stm32 family!
I just format commit message title for device tree patches ("ARM: dts: 
stm32 ...").

Rob, I took also the dt-binding patches.

Series applied on stm32-next.

Regards
Alex


