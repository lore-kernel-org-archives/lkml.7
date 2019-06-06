Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFC220717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4T1oZGmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfFFV5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:57:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfFFV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:57:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56LrwEP083818;
        Thu, 6 Jun 2019 21:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ugG8dGBQaOC/IxUQonaZpN9nBlakgdaPO7yxwAulV0M=;
 b=4T1oZGmTae2n1+WDy5u/NhpuHLbJz3WRy8xZZtko29BFgkSakpNdcZp2LlTqZRnoe1b5
 Raao/yqVI2EMt/WCUNm1WWkyvfREOPIrRe/8negi8fBxpYmolqe7ADb7XI1ePbx6Kx2u
 eJedgPSOOP7CS3+hs0JXoubCOTVKPGVPYiOVBlWX9JuPDSyAagHtA71lnym4CRUpcSqk
 YJze1pyuYCpNqZsob/oJdGc7LX/M9y0mnJxe1cUNw9gM39A9dsg7O+bZXkSkhhBndHpk
 sTSe5qtPRnl1jG+EfsYnp6nJwaBmQwKCJi/YT7pbFRcY0ejspzGCp6m+8acMRbu0UKvM Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2suj0qu1x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 21:57:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56Lt85f151089;
        Thu, 6 Jun 2019 21:55:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2swngmrn83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 21:55:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x56LtJBr020167;
        Thu, 6 Jun 2019 21:55:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 14:55:18 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] scsi: lpfc: Avoid unused function warnings
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190606052421.103469-1-natechancellor@gmail.com>
Date:   Thu, 06 Jun 2019 17:55:16 -0400
In-Reply-To: <20190606052421.103469-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Wed, 5 Jun 2019 22:24:21 -0700")
Message-ID: <yq1sgsmmla3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=986
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> When building powerpc pseries_defconfig or powernv_defconfig:
>
> drivers/scsi/lpfc/lpfc_nvmet.c:224:1: error: unused function
> 'lpfc_nvmet_get_ctx_for_xri' [-Werror,-Wunused-function]
> drivers/scsi/lpfc/lpfc_nvmet.c:246:1: error: unused function
> 'lpfc_nvmet_get_ctx_for_oxid' [-Werror,-Wunused-function]
>
> These functions are only compiled when CONFIG_NVME_TARGET_FC is enabled.
> Use that same condition so there is no more warning. While the fixes
> commit did not introduce these functions, it caused these warnings.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
