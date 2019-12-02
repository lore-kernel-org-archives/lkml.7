Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9FCC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D0120718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLBOii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:38:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727401AbfLBOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:38:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2EbNOq114945;
        Mon, 2 Dec 2019 09:38:20 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6g8frjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 09:38:20 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xB2EbU34115649;
        Mon, 2 Dec 2019 09:38:20 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6g8frj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 09:38:20 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB2EZPje024260;
        Mon, 2 Dec 2019 14:38:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 2wkg25uagu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 14:38:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2EcHOp36897274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 14:38:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 970B7C6057;
        Mon,  2 Dec 2019 14:38:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2902C605B;
        Mon,  2 Dec 2019 14:38:15 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.40.44])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 14:38:15 +0000 (GMT)
Subject: Re: [PATCH -next] x86/efi: remove unused variables
To:     YueHaibing <yuehaibing@huawei.com>, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, zohar@linux.ibm.com,
        dhowells@redhat.com, jwboyer@fedoraproject.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191115130830.13320-1-yuehaibing@huawei.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <0b3695b5-8b90-cb7b-6b12-d340ab1dbf8b@linux.vnet.ibm.com>
Date:   Mon, 2 Dec 2019 09:38:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191115130830.13320-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/19 8:08 AM, YueHaibing wrote:
> commit ad723674d675 ("x86/efi: move common keyring
> handler functions to new file") leave this unused.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   security/integrity/platform_certs/load_uefi.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 4369204..111898a 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -11,11 +11,6 @@
>   #include "../integrity.h"
>   #include "keyring_handler.h"
>   
> -static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
> -static efi_guid_t efi_cert_x509_sha256_guid __initdata =
> -	EFI_CERT_X509_SHA256_GUID;
> -static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
> -
>   /*
>    * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
>    * it does.


Thanks for noticing and fixing this.

Thanks & Regards,

      - Nayna

