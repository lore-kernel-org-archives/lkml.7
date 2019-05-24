Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8291CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7D820675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbfEXQJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:09:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389888AbfEXQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:09:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OG6pEo134532
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:09:04 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2spjjmmb9a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:09:04 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 24 May 2019 17:09:03 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 17:08:59 +0100
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4OG8wS918678078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 16:08:58 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A97FF136051;
        Fri, 24 May 2019 16:08:58 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A81013605D;
        Fri, 24 May 2019 16:08:58 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 16:08:57 +0000 (GMT)
Subject: Re: [PATCH v2 2/7] drivers/soc: Add Aspeed XDMA Engine Driver
To:     Arnd Bergmann <arnd@arndb.de>, Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
 <1558383565-11821-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a2HSOsw33VhAk4Z8ARiYn4jG68Ec7fynKbrFWUNDo37Wg@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Fri, 24 May 2019 11:08:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2HSOsw33VhAk4Z8ARiYn4jG68Ec7fynKbrFWUNDo37Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052416-0016-0000-0000-000009B95DC6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011155; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207976; UDB=6.00634444; IPR=6.00988965;
 MB=3.00027034; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-24 16:09:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052416-0017-0000-0000-00004359C69F
Message-Id: <687e4a77-0df1-4982-1edd-9d0559c489fe@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/19 7:02 AM, Arnd Bergmann wrote:
> On Mon, May 20, 2019 at 10:19 PM Eddie James <eajames@linux.ibm.com> wrote:
>> diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
>> new file mode 100644
>> index 0000000..2a4bd13
>> --- /dev/null
>> +++ b/include/uapi/linux/aspeed-xdma.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright IBM Corp 2019 */
>> +
>> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
>> +#define _UAPI_LINUX_ASPEED_XDMA_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * aspeed_xdma_op
>> + *
>> + * upstream: boolean indicating the direction of the DMA operation; upstream
>> + *           means a transfer from the BMC to the host
>> + *
>> + * host_addr: the DMA address on the host side, typically configured by PCI
>> + *            subsystem
>> + *
>> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
>> + */
>> +struct aspeed_xdma_op {
>> +       __u32 upstream;
>> +       __u64 host_addr;
>> +       __u32 len;
>> +};
>> +
>> +#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
> If this is a user space interface, please remove the holes in the
> data structure.


Surely it's 4-byte aligned and there won't be holes??


>
> I don't see how this is actually used in this patch, maybe you meant
> the definition to be part of another patch?


The structure is used in this patch as an argument to aspeed_xdma_start().


Thanks,

Eddie


>
>      Arnd
>

