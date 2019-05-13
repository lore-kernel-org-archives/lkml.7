Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4175D208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F20ApXni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEMWdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:33:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMWdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:33:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMSsfw016962;
        Mon, 13 May 2019 22:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ZV4o2oWESAZaEilDpr6pTTuN3dbW0EDyebfCdSxOGmM=;
 b=F20ApXnio5AcHzHJscfXa9XwZfCI6Grzy4mq6xHV6izogsfzcqRX5ST7vWbfOQ5+FTNT
 cqOnnjl5RTA2TH7zV63ss+ObQ2bSQqlqpY+Ymi3mN2S5PxmGoFsyxuyUFjJ+uAxewgI9
 rljL/IYAdVKm7sfpa6XUCm8EORFJ+Hy8S/tdYxAcuNOpkBYUr3oyibeOZbtE8g+cme5j
 x+LaGTWLIQblzlybg8Ubzwz1Z92wR/R02fBNUsMguLc1yrZZGAlx/UyuB7eLjNdiJwWs
 RKn6ER9JPQZeVxHw7NESNk9EhVM4hp5mRHYEgtcoRnyJ9Vx3Mufoj26L7CMhVqw46X6t lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sdq1qa1qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:33:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMVGgp033002;
        Mon, 13 May 2019 22:33:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2sdmeara61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:33:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4DMX4b7012947;
        Mon, 13 May 2019 22:33:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 15:33:04 -0700
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: qedi: remove set but not used variables 'cdev' and 'udev'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190424080256.30012-1-yuehaibing@huawei.com>
Date:   Mon, 13 May 2019 18:33:02 -0400
In-Reply-To: <20190424080256.30012-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Wed, 24 Apr 2019 16:02:56 +0800")
Message-ID: <yq18svagf35.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130150
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=906 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/qedi/qedi_iscsi.c: In function 'qedi_ep_connect':
> drivers/scsi/qedi/qedi_iscsi.c:813:23: warning: variable 'udev' set but not used [-Wunused-but-set-variable]
> drivers/scsi/qedi/qedi_iscsi.c:812:18: warning: variable 'cdev' set but not used [-Wunused-but-set-variable]

Applied to 5.2/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
