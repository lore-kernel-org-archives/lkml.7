Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F119220652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mShZUEjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfDPCVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:21:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35358 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfDPCVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:21:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3G2J2pW127381;
        Tue, 16 Apr 2019 02:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=2VFrU1+5VfifqXMGiGwx+FoOx6doPhBgE/2f6VuZCWE=;
 b=mShZUEjjPvY8hzYJSK4DtHXoqdSv/gLR0Wi/j/oDg2WNFoZjED3qMFqvpG2jhWjKr0uD
 sTpE6aGwnqJRjB/iW61lcSnlz6EHzIZtfIGeGJsO99+ipt0RN1WzlKyhZ42KhTXKyn0W
 NH4WTQufMHlv8mH2z+aFJou8bBqqPQMF2xD0UQAh2pg3ODLoCQsSUxdAXR0i35G0cxy5
 g2TEl4E3gRu1UynAM8FeL2kNJ8DRmg6R3h3SUvuklQV8+VowV9jAQyI3CS73qelpvo5s
 ov2+wjEdE32NRx7wUWStlV1nO1hXJDduuyzFlaaJT0YJatKttoZ+zJK4yVq5TD5SMpYM iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2ru59d1xtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 02:20:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3G2KvW4056429;
        Tue, 16 Apr 2019 02:20:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ru4vsx9vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 02:20:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3G2KphN017856;
        Tue, 16 Apr 2019 02:20:51 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 19:20:50 -0700
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <megaraidlinux.pdl@broadcom.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make megasas_host_device_list_query() static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190413142138.33336-1-yuehaibing@huawei.com>
Date:   Mon, 15 Apr 2019 22:20:48 -0400
In-Reply-To: <20190413142138.33336-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Sat, 13 Apr 2019 22:21:38 +0800")
Message-ID: <yq1wojug073.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904160014
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904160015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> Fix sparse warning:
>
> drivers/scsi/megaraid/megaraid_sas_base.c:4652:1: warning:
>  symbol 'megasas_host_device_list_query' was not declared. Should it be static?

Applied to 5.2/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
