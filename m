Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66E3C28CC3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A32075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Msi7d3HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFECcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:32:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFECcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:32:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552P1Mo055394;
        Wed, 5 Jun 2019 02:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8kqXKOWnoHA8qak4imt15sgfDuJ/AZQepvguaPc7Kjg=;
 b=Msi7d3HDqYKjiUOZOgfqSf5chxVCWjVInoCcMDOgLATjLx74tx5SPZNeudJjeGiarOWe
 EeSnXrOUO5tVciI1ORE8DgLtwYkyRJubjSjEQc5CJTHsYU0G8OyB7EGXTa69aVDWp3ZA
 qFkYkBwiJO5+uU8w3Tjx5l7k2CHDIY/WzzzcEyCsTWt2UoBE5Vn4yfonDooc82bwuIiE
 ortMqSvr46qkPfP3JT6S9vEVsa9vvPL6FGwpxU6kmwkp/VKv+n6LIrb+J4067opWNL3U
 F6ecZOjGd5hdxliVm/h69Q5Z34fVqDWT2nJwhtpEiYHGTgExP6UbOywQTbhNVgkG3uaj mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2suevdgjke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:32:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552Ub9R097804;
        Wed, 5 Jun 2019 02:32:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2swnhbwvxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:32:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x552WAE6003746;
        Wed, 5 Jun 2019 02:32:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 19:32:10 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jsmart2021@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: lpfc: Make some symbols static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190531152841.13684-1-yuehaibing@huawei.com>
Date:   Tue, 04 Jun 2019 22:32:07 -0400
In-Reply-To: <20190531152841.13684-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Fri, 31 May 2019 23:28:41 +0800")
Message-ID: <yq1imtkrcd4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=741 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> Fix sparse warnings:
>
> drivers/scsi/lpfc/lpfc_sli.c:115:1: warning: symbol 'lpfc_sli4_pcimem_bcopy' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_sli.c:7854:1: warning: symbol 'lpfc_sli4_process_missed_mbox_completions' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:223:27: warning: symbol 'lpfc_nvmet_get_ctx_for_xri' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:245:27: warning: symbol 'lpfc_nvmet_get_ctx_for_oxid' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_init.c:75:10: warning: symbol 'lpfc_present_cpu' was not declared. Should it be static?

Applied to 5.3/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
