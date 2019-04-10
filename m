Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24798C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281A2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="e1lCz0AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfDJMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:53:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32836 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728553AbfDJMx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:53:29 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ACpG9d009600;
        Wed, 10 Apr 2019 14:53:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=QxejyPLWFcfN45woY+dNDsAMB6sZZOVYc218Zx1yiFk=;
 b=e1lCz0AVpEr1LwKuLzUFavQzBFf2LavneLHYkRA6SExu7DBAISLSRNPHX3FwCiBa/iie
 6veQ47Yd4FfF1EvJ6yIBq2xvrpL8jCEFwSvaUv2u0CtmU++1vjw+mG5uQyRiprnu/F3l
 5Gy/QTOOz75BoG6I5GsFdtWow2x2CaSyV3PbZ/GaamZ8cK8g0xIgQB9kmPsYJYSktCoh
 WAXsa5qwWV/p5JplRmkZkoOvK32Fi/qahUaRSuyj7pC0kP3HWlWLHrtwzyAYr6zVSKf+
 pBZ6V3BV9lbHBmPBf8VylKn6jH+IKd8rgjasTaNAGov9siIy9o1WLt8PGe3fIEB+aEtD dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wr695-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 14:53:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F07031;
        Wed, 10 Apr 2019 12:53:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09D9B1FE8;
        Wed, 10 Apr 2019 12:53:17 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 14:53:16 +0200
Subject: Re: [PATCH 0/2] ARM: dts: stm32: add spdifrx support on stm32mp157c
To:     Olivier Moysan <olivier.moysan@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1553854365-19866-1-git-send-email-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c85bb824-2645-5916-1e9d-70c297d9dc12@st.com>
Date:   Wed, 10 Apr 2019 14:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553854365-19866-1-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 3/29/19 11:12 AM, Olivier Moysan wrote:
> This patchset adds support of STM32 SPDFIRX on stm32mp157c
> 
> Olivier Moysan (2):
>    ARM: dts: stm32: add spdifrx support on stm32mp157c
>    ARM: dts: stm32: add spdfirx pins to stm32mp157c
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 13 +++++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 13 +++++++++++++
>   2 files changed, 26 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
