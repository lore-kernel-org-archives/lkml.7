Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866C9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B05A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n/nj47rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfDSAh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:37:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfDSAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:37:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3J0T5sX172982;
        Fri, 19 Apr 2019 00:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=NI89sqVtRpB20dY10piI8btj4E7BD4L25ds4TWxuvhk=;
 b=n/nj47rFq4fdECFtl7OrJ/M/TyZRrVWJ+/axnKNUVesdHrVg4d/A+XGog7OyEhLni+kO
 U7/h+piFb69H//IJEhGxW2kkDyRjcIsJ5RKU0jbzHatja1Uq1PVIt65LMxZ2fIQWxDDM
 dis5ivba1c7IVFd3v6nTuDLxJG7d1cvgPBoztLr6HCSdMGSOwkVBqQWc4AkInAxt8/WL
 B1txH3rxXOc4VY9SVQSfmzzUCnWEHr866yVK5vBmZ8hL5+rUru1OqIZHWyi26gW5yPZs
 yLRscZsn9kxtT9f2WWtgQ6u013abeMC2kt9YMETsgneFxkM4mWIa9LDQoJzbxef0TLRQ wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rvwk43q1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 00:37:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3J0b5K4100683;
        Fri, 19 Apr 2019 00:37:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ry35brf78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 00:37:20 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3J0bJMF004659;
        Fri, 19 Apr 2019 00:37:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Apr 2019 17:37:19 -0700
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: lpfc: Make lpfc_sli4_oas_verify static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190417150554.34844-1-yuehaibing@huawei.com>
Date:   Thu, 18 Apr 2019 20:37:16 -0400
In-Reply-To: <20190417150554.34844-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Wed, 17 Apr 2019 23:05:54 +0800")
Message-ID: <yq1o952bzk3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9231 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904190001
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9231 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904190001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> Fix sparse warning:
>
> drivers/scsi/lpfc/lpfc_init.c:13091:1: warning:
>  symbol 'lpfc_sli4_oas_verify' was not declared. Should it be static?

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
