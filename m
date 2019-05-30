Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0840324434
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXbde7oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfE3C0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:26:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfE3C0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:26:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2J2nD189689;
        Thu, 30 May 2019 02:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=pde1tJSDf/v1dzfrUCyTZ0Ne/TcdCmJiYYuCRbdaaAQ=;
 b=cXbde7oRdJt6u90rdLxDmer2J5AEPQycaNk0wR0vltLLTu/cLIpqATRvGO/VA+ulx0Qi
 6E5f9PQtG1P6yFoiaprk3quvn5frTLhbwUn4nRG/Gbtu1Q7Q5lvziZS//oO9euhtHeir
 gD6rVpzc9eP1iaLSlpNQCPr88MFJ2uGWpT1BEowOdur6cH/YuF0iEN++belLZOQHulai
 py5AtydfdfZJNIxO88EVLboP2jVpWPq5xwJmql3v+YamjAklqGgWplCfJFOSCKWBmTYh
 pgf6QPWlw49X7xKYsGOWWPZmo1cHnQIii+zTynTqIGmyWvMufk9YEPjAtZ/isZcP32LU yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4tnd7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:25:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2O2uZ032937;
        Thu, 30 May 2019 02:25:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31vkqjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:25:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U2PrOk014617;
        Thu, 30 May 2019 02:25:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:25:53 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <megaraidlinux.pdl@broadcom.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used variables 'host' and 'wait_time'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190525124202.8120-1-yuehaibing@huawei.com>
Date:   Wed, 29 May 2019 22:25:50 -0400
In-Reply-To: <20190525124202.8120-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Sat, 25 May 2019 20:42:02 +0800")
Message-ID: <yq15zpsy8y9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=954
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=991 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_suspend:
> drivers/scsi/megaraid/megaraid_sas_base.c:7269:20: warning: variable host set but not used [-Wunused-but-set-variable]
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_aen_polling:
> drivers/scsi/megaraid/megaraid_sas_base.c:8397:15: warning: variable wait_time set but not used [-Wunused-but-set-variable]
>
> 'host' is never used since introduction in
> commit 31ea7088974c ("[SCSI] megaraid_sas: add hibernation support")
>
> 'wait_time' is not used since commit
> 11c71cb4ab7c ("megaraid_sas: Do not allow PCI access during OCR")

Applied to 5.3/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
