Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088DC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255B52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfGJGpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:45:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbfGJGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:45:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6A6iL17116144
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:44:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tn8fv51fe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:44:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 10 Jul 2019 07:44:55 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Jul 2019 07:44:53 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6A6iprZ54853712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 06:44:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6137042042;
        Wed, 10 Jul 2019 06:44:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E172E42047;
        Wed, 10 Jul 2019 06:44:50 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jul 2019 06:44:50 +0000 (GMT)
Subject: Re: [PATCH] s390/zcrypt: remove the exporting of
 ap_query_configuration
To:     Denis Efremov <efremov@linux.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190709122507.11158-1-efremov@linux.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Wed, 10 Jul 2019 08:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190709122507.11158-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071006-0016-0000-0000-00000290D7CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071006-0017-0000-0000-000032EE8EC0
Message-Id: <a71450e5-892c-3841-22d6-9f5c7b2d4ca4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.19 14:25, Denis Efremov wrote:
> The function ap_query_configuration is declared static and marked
> EXPORT_SYMBOL, which is at best an odd combination. Because the
> function is not used outside of the drivers/s390/crypto/ap_bus.c
> file it is defined in, this commit removes the EXPORT_SYMBOL() marking.
>
> Fixes: f1b0a4343c41 ("s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.")
> Fixes: 050349b5b71d ("s390/zcrypt: externalize AP config info query")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index b9fc502c58c2..379e43b79006 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -208,7 +208,6 @@ static inline int ap_query_configuration(struct ap_config_info *info)
>  		return -EINVAL;
>  	return ap_qci(info);
>  }
> -EXPORT_SYMBOL(ap_query_configuration);
>  
>  /**
>   * ap_init_configuration(): Allocate and query configuration array.
This function was exported a while ago for KVM code. However, never used.
So removing the export is the right thing. Thanks Denis

Heiko/Vasily will you pick this patch please?

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

