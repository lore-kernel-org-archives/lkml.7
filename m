Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5D62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fZjQNeAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbfGYKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:21:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7438 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389537AbfGYKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:21:00 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PAGBi3023124;
        Thu, 25 Jul 2019 12:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=PuANcSYUEr2h1YiccGZF5KbI11ZnNfnGmreQcfFcH0U=;
 b=fZjQNeAlzyROf+NRDgI5o941gWC5rqhiFUKF7WOkjv6ekb1mK3ZzaWnd1/9gHoh6QATr
 Uv3RD3OZRTek5QmSeNEAXGDJtC8oKhB7JKmA5SlnhyQ3OSRsQzohm+xvNqnI27a5x7pR
 CRcUDQNabZA9KPQIx772g8fVoy+K3aRz0j3WlxKo7ISAZEae0MeZOilBTh2007t1SRZ9
 ddZ/1ThE/uKHHQv+y3tAwp7KLJTHXwtYiz0LXYsIFlv6eLK9dg5bZ5faKgjOXT3DdvYW
 9uifGSCOLaaal21dfTH3iSEA2XMbavAMEBTcEKXfvfn7ZKQld7PXHmt3pIUJBnKb4HT6 Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tx60433ce-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 12:20:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B4223A;
        Thu, 25 Jul 2019 10:20:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31C672945;
        Thu, 25 Jul 2019 10:20:36 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 25 Jul
 2019 12:20:35 +0200
Subject: Re: [PATCH 0/4] ARM: dts: stm32: enable FMC2 NAND controller on
 stm32mp157c-ev1
To:     Christophe Kerello <christophe.kerello@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <olof@lixom.net>, <arnd@arndb.de>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <cc4c56ca-c3cb-fc8c-e223-4b98754d3592@st.com>
Date:   Thu, 25 Jul 2019 12:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On 6/21/19 4:49 PM, Christophe Kerello wrote:
> This patchset adds and enables FMC2 NAND controller used on
> stm32mp157c-ev1.
> 
> Christophe Kerello (4):
>    ARM: dts: stm32: add FMC2 NAND controller support on stm32mp157c
>    ARM: dts: stm32: add FMC2 NAND controller pins muxing on
>      stm32mp157c-ev1
>    ARM: dts: stm32: enable FMC2 NAND controller on stm32mp157c-ev1
>    ARM: multi_v7_defconfig: add FMC2 NAND  controller support
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 44 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     | 16 +++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 19 +++++++++++++
>   arch/arm/configs/multi_v7_defconfig       |  1 +
>   4 files changed, 80 insertions(+)
> 

Series applied on stm32-next.
Note, I changed capital letter in patch1 directly (As I responded late).

Regards
Alex
