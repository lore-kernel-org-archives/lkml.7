Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F3C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78A72080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAGTTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:19:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbgAGTTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:19:49 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007JH4Vd173752;
        Tue, 7 Jan 2020 14:18:36 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8sa441s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 14:18:35 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 007JI0QY019239;
        Tue, 7 Jan 2020 19:18:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 2xajb6w3md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 19:18:35 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 007JIX2X48431424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jan 2020 19:18:33 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 700006E052;
        Tue,  7 Jan 2020 19:18:33 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10D296E050;
        Tue,  7 Jan 2020 19:18:32 +0000 (GMT)
Received: from [9.163.26.112] (unknown [9.163.26.112])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jan 2020 19:18:32 +0000 (GMT)
Subject: Re: [PATCH 3/3] video: aspeed: Update copyright information
To:     Joel Stanley <joel@jms.id.au>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200107034324.38073-1-joel@jms.id.au>
 <20200107034324.38073-4-joel@jms.id.au>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <48c5f0dd-4fa3-919c-9dd7-91afb5da8840@linux.ibm.com>
Date:   Tue, 7 Jan 2020 13:18:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107034324.38073-4-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-07_06:2020-01-07,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/20 9:43 PM, Joel Stanley wrote:
> Use the preferred form for GPL2+, and add IBM and Intel as the authors.
> The driver was initially upstreamed by Eddie from IBM, and has had major
> contributions from Jae at Intel.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   drivers/media/platform/aspeed-video.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index d70b893fd4cf..71e0dbdb37dc 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1,4 +1,6 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2020 IBM Corp.
> +// Copyright (c) 2019 Intel Corporation
>   
>   #include <linux/atomic.h>
>   #include <linux/bitfield.h>
