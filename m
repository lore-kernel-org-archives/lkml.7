Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F6BC742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCCA214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1MTmR1kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfGLAd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:33:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46920 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfGLAd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:33:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0TI9Y176520;
        Fri, 12 Jul 2019 00:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=CR4OYKqc+GwvLMLKdlXjil5mKkyZnLad/bNsIqBvDGQ=;
 b=1MTmR1kc6xeljryNij/zrF+P2P/YhulhS8bIW3yR1W+CEG3k8tnt8ljF30eZlFQOj0xA
 43Vz0DG8JcW2nheAPr+LQpvxv1FSJ9gtDTv5mvWf0tRHd0UcG2srR8i8hf7Vn7bx8WGk
 V8Kp/38TOgnxtCn2U984EEHlQjHZhddVhlyiZo4Qv6k6fz6YYFRqZoVmppHHropPdkby
 kgRkOUlnWvmgX/YFkQciY2e9WYU7reUYEiY9KR4d/vQYGBuX9WrwhLzu2vsGWOWDoDLy
 XIgBtOytXDJlbQ7F8jhspxxawuAu0ryxe5wIYAEuxOJC6v57wPXIBI/THemuUv9fg1++ Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tjkkq2ueu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:32:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0RWmw190436;
        Fri, 12 Jul 2019 00:32:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tn1j1uctm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:32:23 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0WMVU017028;
        Fri, 12 Jul 2019 00:32:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:32:22 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <megaraidlinux.pdl@broadcom.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make some symbols static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190702130114.29356-1-yuehaibing@huawei.com>
Date:   Thu, 11 Jul 2019 20:32:18 -0400
In-Reply-To: <20190702130114.29356-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Tue, 2 Jul 2019 21:01:14 +0800")
Message-ID: <yq1k1co854d.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=851
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=907 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> Fix sparse warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c:271:1: warning: symbol 'megasas_issue_dcmd' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_base.c:2227:6: warning: symbol 'megasas_do_ocr' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_base.c:3194:25: warning: symbol 'megaraid_host_attrs' was not declared. Should it be static?

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
