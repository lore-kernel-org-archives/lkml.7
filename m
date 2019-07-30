Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E64C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7712121773
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G5BysJ7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfG3QOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:14:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38734 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfG3QOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:14:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGDm0R012637;
        Tue, 30 Jul 2019 16:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=mZvdEtHT1IHCixeTgGoyQtz4Ve18vviw6EtEdtv9tNI=;
 b=G5BysJ7aYfc6U5Pha375DxwLWdJBhki0MY8Vi1jqGNZn9e8laI6FcSAKVpElSNP1zcs2
 Qvxgp+o/fWRjnpwojybHq4TkhElYbw6uWvjqi6S2OUIHZoa2TpeTxO9CdjI/yYYZwCiS
 x8pSzfWrbTTJJluSHxEhN8Gv2ynpeGTfwYmSwb1a8idsHez0HSO9iAWrqaTLm3CTsxSj
 lY3p/VKEPpX2Ju5IYC5sGJrvNbXuFVtYqnGq0So+YdER4qyC7M4Bd6EO98S1vfuPxfFO
 op6jvgKyyvQswfl2i9ToWzXT8gsL2XLNeshQMmhajX/uGZY3csloTkHd5N6Xb4pVNnjA Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u0f8qyh4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:13:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGDTjJ110753;
        Tue, 30 Jul 2019 16:13:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u0bqu8xj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:13:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6UGDhsu016424;
        Tue, 30 Jul 2019 16:13:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 09:13:42 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jthumshirn@suse.de>, <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: aic94xx: Remove unnecessary null check
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190711141539.13892-1-yuehaibing@huawei.com>
Date:   Tue, 30 Jul 2019 12:13:40 -0400
In-Reply-To: <20190711141539.13892-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Thu, 11 Jul 2019 22:15:39 +0800")
Message-ID: <yq18ssfo5zf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=894
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=961 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> kmem_cache_destroy() can handle NULL pointer correctly, so there is
> no need to check NULL pointer before calling kmem_cache_destroy().

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
