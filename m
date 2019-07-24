Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A7CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD882253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5Waj2liY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGXCQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:16:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:16:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2Es4w041109;
        Wed, 24 Jul 2019 02:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=5FVDCC7Apm7qYwOYQxK4ViNWLzGUlIfAjJuhTo1BmxQ=;
 b=5Waj2liY6R46wEGahUIYMG7ZGTIQfyQmIHzkAtQyf2VoaFrHs3LfV0A7gq7hDEoUI2ok
 Q2gYMEtFtBreKhnjIj7gU/gHi+lKehv6EZNu1ptIoEu+BcINNONGwHeWLkyEBd71wFTe
 G/9mHxtlx2UJy5Kni18AsJUhr/v/SaISaJwhDU2DmLkOvqx7NXggKROxuB5Tvfqxfl9i
 UKBmVWLDbaCPJ1Llpg+PrK/u88uAucIcWvs4SZJeMLBfHf5Y6bQkGUPVTlSJEXJm2TfN
 2nIVmLzw5rXMSbciC/lEUdpeve5zFmrkQW0RM6gCHstGMRSOKb93Ra7xbzjGNAhv6K7n Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tx61bt78x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:16:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2CtkA092432;
        Wed, 24 Jul 2019 02:16:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tx60xkhyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:16:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6O2G412002666;
        Wed, 24 Jul 2019 02:16:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:16:03 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <megaraidlinux.pdl@broadcom.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make some functions static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190723143450.33916-1-yuehaibing@huawei.com>
Date:   Tue, 23 Jul 2019 22:16:01 -0400
In-Reply-To: <20190723143450.33916-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Tue, 23 Jul 2019 22:34:50 +0800")
Message-ID: <yq1sgqwqise.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=901
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=967 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> Fix sparse warnings:
>
> drivers/scsi/megaraid/megaraid_sas_fusion.c:541:1: warning: symbol
> 'megasas_alloc_cmdlist_fusion' was not declared. Should it be static?

Applied to 5.3/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
