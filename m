Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D593C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C52075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+vfXSTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFECYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:24:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55768 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFECYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:24:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552DpeE048287;
        Wed, 5 Jun 2019 02:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=7u0fqKpO3Y/6UfFmgymXRbjPTDuNK68XzOqEUVtqxRY=;
 b=B+vfXSTUbVuGJ8aREp/JPBa5s9UsLB1ltByTR8TzKVfhUtWWCWCZXJYkjEOIvyB1/KlN
 o/ELxy8YMcvnMtT16octI+gbW4HxicWdeoY8taSsznQDf8srO1qWLVK9T4J1VrWjBhpm
 Z7WoUYZ3Oxhni72ZbkQxgWwWWQiTyls94zzBciLHt3sMB25pTUax+jRJJqBoI9fXXe/j
 j/TdIxpn1y4h4yCkNjJ5ozTXeGpzJUJC4Q2cUKYZuwAKHTFnGQdJH6KSCS4AdK1GJSHA
 lSQ8UAmy+fyTNnZPEGsFzYhOMRuV6EoAAm5RKM3LrwfkAWnWoi+tF4iMus55ofzWIXVV lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2suevdghw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:21:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552KVx5117073;
        Wed, 5 Jun 2019 02:21:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2swnh9wt7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:21:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x552LocA018967;
        Wed, 5 Jun 2019 02:21:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 19:21:50 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/6] hisi_sas: Some misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1559123927-160502-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 04 Jun 2019 22:21:48 -0400
In-Reply-To: <1559123927-160502-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 29 May 2019 17:58:41 +0800")
Message-ID: <yq1zhmwrcub.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=827
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=879 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces some misc patches for the driver. Nothing
> particularly stands out, maybe apart from a patch to delete a PHY's
> timer when necessary.

Applied to 5.3/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
