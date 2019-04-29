Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F191C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B81020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3b5Pqg12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfD2MCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:02:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfD2MCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:02:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBxL6g196407;
        Mon, 29 Apr 2019 12:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=AWC+vYweHhB5TtC3w+p9EfylxPjcOCdyfISPubqVHVE=;
 b=3b5Pqg12ak73+L2xAMRA9o1vZcf7wnNEH6j3UooKT8txp9YelF1z6EcUJAz5ieOeKePY
 ufTvfP+AlPqpu2gWWRkFe2EjJHv1xFArL9OxE9isX/oC5RG1qqxmWICKRRWRHFt1ABS8
 Kt4vHJSEefdCSt+Nll7T3ut7ZQvFVEO3MevAFzYeT2I+/0jkHOVCjwx0TGjqfQRrTuYk
 Xvi2V5EXslbFgaIKmC6GZgbnLJUaMGrIwoN/gDIYYg4/ddzky/5n4quufiMT5iThDn7V
 8ybwdlliH+ndx8ut4LMa4r0JdvkcisvHFg6LAkWF5BUfPt/d93funz2hiSa17H00F0rS aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s4fqpwte9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:02:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TC0dkY129818;
        Mon, 29 Apr 2019 12:02:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s4d49wdvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:02:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3TC2S0f016842;
        Mon, 29 Apr 2019 12:02:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 05:02:28 -0700
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: qedf: remove set but not used variables
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190423144138.20428-1-yuehaibing@huawei.com>
Date:   Mon, 29 Apr 2019 08:02:26 -0400
In-Reply-To: <20190423144138.20428-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Tue, 23 Apr 2019 22:41:38 +0800")
Message-ID: <yq1muk910kt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290087
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/qedf/qedf_els.c: In function 'qedf_process_els_compl':
> drivers/scsi/qedf/qedf_els.c:149:20: warning: variable 'sc_cmd' set but not used [-Wunused-but-set-variable]
> drivers/scsi/qedf/qedf_els.c:148:28: warning: variable 'task_ctx' set but not used [-Wunused-but-set-variable]
> drivers/scsi/qedf/qedf_els.c: In function 'qedf_send_srr':
> drivers/scsi/qedf/qedf_els.c:612:6: warning: variable 'sid' set but not used [-Wunused-but-set-variable]

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
