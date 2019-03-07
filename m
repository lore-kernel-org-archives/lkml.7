Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C921C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B57206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tjCkwYA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGA1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:27:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56736 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGA1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:27:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x270NQFu136589;
        Thu, 7 Mar 2019 00:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=huFwk2zsiUjZXEF8C0UKq8dVOWbSAIvwHqOPGVwgAFs=;
 b=tjCkwYA9wuAzcwHl85PJLpJ2mv7PzGk+DSkmXLga1U6ba/tIWJ6bNgwFS5Og3enYOEzL
 1bkDTlSExN+ZU7IDT4lnbf8B6nkr/P6RJP9DCxB9bi+4QjNwBVr9btfuOdRxE7YnP+kv
 V4yuFUQZQpxhbtLvBdJChbIDxcNXV7MVv4H+DzDJWAfdv2QYDdnZuohIVUvP0wNb3ewy
 u7a+tkgyezbPwBy8bQEUNFZBF59VGzJoqHkWVxXajsxzrhbG6Kf5MOr1Q9VDGddUPQZv
 uI86TdcwWNXT80RUkHia0rBeUlIwJQQ7HuWG7yQB02/PmB5RVpJkp8iuuWr7CTNprJ2/ xg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qyh8uf42b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Mar 2019 00:27:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x270ReWW016831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 00:27:41 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x270Re4t012436;
        Thu, 7 Mar 2019 00:27:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 16:27:39 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/6] hisi_sas: Some misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1551365462-128193-1-git-send-email-john.garry@huawei.com>
Date:   Wed, 06 Mar 2019 19:27:37 -0500
In-Reply-To: <1551365462-128193-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 28 Feb 2019 22:50:56 +0800")
Message-ID: <yq14l8fwmti.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903070000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The patchset contains some misc patches for the driver, including:
> - Workaround for acute scenario of SMP/internal IO timeout and reset racing
> - Clear Affiliation for STP target port (from Luo Jiaxing and Xiang Chen)
> - Fix PHY negotiated linkrate value for when PHY down
> - Some init reg config changes
> - Add support to coalesce and print PHY errors
> - A tidy-up patch

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
