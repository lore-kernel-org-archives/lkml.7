Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27EE206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfDQOfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:35:38 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54556 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730463AbfDQOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:35:38 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HEYWib022327;
        Wed, 17 Apr 2019 09:35:32 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ruc6ndwjg-1;
        Wed, 17 Apr 2019 09:35:32 -0500
Received: from EDIEX01.ad.cirrus.com (unknown [198.61.84.80])
        by mail1.cirrus.com (Postfix) with ESMTP id B4299611C8A7;
        Wed, 17 Apr 2019 09:35:31 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 17 Apr
 2019 15:35:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 17 Apr 2019 15:35:31 +0100
Received: from [198.90.251.142] (edi-sw-dsktp006.ad.cirrus.com [198.90.251.142])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EB5E32DB;
        Wed, 17 Apr 2019 15:35:30 +0100 (BST)
Subject: Re: [PATCH 1/5] regulator: arizona: Switch to SPDX identifier
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20190417141633.4730-1-axel.lin@ingics.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <c01e0254-6276-90a2-4dea-f0281162c6ab@opensource.cirrus.com>
Date:   Wed, 17 Apr 2019 15:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190417141633.4730-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=960 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904170100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/19 15:16, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/arizona-ldo1.c    | 19 +++++++------------
>   drivers/regulator/arizona-micsupp.c | 19 +++++++------------
>   2 files changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
> index bf3ab405eed1..e4bc7b1e5ccd 100644
> --- a/drivers/regulator/arizona-ldo1.c
> +++ b/drivers/regulator/arizona-ldo1.c
> @@ -1,15 +1,10 @@
> -/*
> - * arizona-ldo1.c  --  LDO1 supply for Arizona devices
> - *
> - * Copyright 2012 Wolfson Microelectronics PLC.
> - *
> - * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// arizona-ldo1.c  --  LDO1 supply for Arizona devices
> +//
> +// Copyright 2012 Wolfson Microelectronics PLC.
> +//
> +// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
> index 120de94caf02..be0d46da51a1 100644
> --- a/drivers/regulator/arizona-micsupp.c
> +++ b/drivers/regulator/arizona-micsupp.c
> @@ -1,15 +1,10 @@
> -/*
> - * arizona-micsupp.c  --  Microphone supply for Arizona devices
> - *
> - * Copyright 2012 Wolfson Microelectronics PLC.
> - *
> - * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// arizona-micsupp.c  --  Microphone supply for Arizona devices
> +//
> +// Copyright 2012 Wolfson Microelectronics PLC.
> +//
> +// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> 

Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>

