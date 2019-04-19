Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA4BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585662171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N2DTxTFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfDSAf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:35:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60562 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDSAf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:35:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3J0T5sT172982;
        Fri, 19 Apr 2019 00:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=0OyZcZI9rEeWv6sgzN0yaarFgvMCoshSbW1JnnLKfUg=;
 b=N2DTxTFv0oVbBHSEXb78wHDnyacqVLFAXJje2NHW5s6/5Qe4JROOOMm6KGLKfbyD6rft
 bCph4IUs2t87Ijm2bqTc+MY5uHjwjJpBK1gXPipg4VRlGhJCUY8VwKmbARdFIzYEJAt1
 Mj/k9qjWVDMCIDYWCuCBfDB5Vm1faBvN+Wt+ZQJJH3jS/YQ4QUt//D/EkIERE7UIumhe
 jHWfJRJmakssKigO5AVmIMAom/iO+gRUM3iK+NcTTUZ9T1SVCKxWwD4RSS9OLhnOuaTb
 EwyfdVPmWw5ASlIZPdPDrHhhD0HCKWfQJbzItaKuqqzNlryCg0XQJE+t4CWeXspveogd 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2rvwk43pxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 00:35:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3J0YThd120394;
        Fri, 19 Apr 2019 00:35:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rwe7b9jje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 00:35:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3J0ZLhV000749;
        Fri, 19 Apr 2019 00:35:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Apr 2019 17:35:20 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: fix spelling mistake "oustanding" -> "outstanding"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190417135109.12872-1-colin.king@canonical.com>
Date:   Thu, 18 Apr 2019 20:35:18 -0400
In-Reply-To: <20190417135109.12872-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 17 Apr 2019 14:51:09 +0100")
Message-ID: <yq1sguebznd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9231 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904190001
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9231 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=797 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904190001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are a couple of spelling mistakes in some kernel info and notice
> messages. Fix these.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
