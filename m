Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C742075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3QxGgfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfFTVxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:53:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:53:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLmcVH098536;
        Thu, 20 Jun 2019 21:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=kDQao6pEV9HdsFlEB4nEftCDUPOrB/eF7wS+pHAhRRw=;
 b=h3QxGgfYliCuHMG24Vd/aSTO0WiOkw1pba+5vBNAdpNfO8gWbU+9BHoY06+BRfY4/rzs
 fZphZf30Cgc9C5j2WZjCIcGaZfscUXuJmGUGEtuwyF1ZF/vnDvKoinUjZFe5GO/VRi2Z
 +8I0tB3m0cETV26m2a2bslk8/O+NQ1rlrKaIMcr6C65ISsArrvvvQAIA2G0Zx0OPfqJ0
 oTfkNlcbuChQK61JXYnobxMzlMStz1GD3x5b4WMNPBo5QZa74rC1z0r99Wb720fKOnEq
 POInXBaWgmaJsN5GNC3D2PythRNUBOBNI3a9PrXWq9z/hiUX5GaitggBoYiTXKL456Am rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t7809keu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:52:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLpHkr119716;
        Thu, 20 Jun 2019 21:52:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t7rdxda0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:52:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5KLqoHC014433;
        Thu, 20 Jun 2019 21:52:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 14:52:49 -0700
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Subject: Re: [PATCH 1/1] scsi: virtio_scsi: remove unused 'affinity_hint_set'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
Date:   Thu, 20 Jun 2019 17:52:46 -0400
In-Reply-To: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
        (Dongli Zhang's message of "Wed, 19 Jun 2019 15:52:19 +0800")
Message-ID: <yq1imszrkk1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dongli,

> The 'affinity_hint_set' is not used any longer since
> commit 0d9f0a52c8b9 ("virtio_scsi: use virtio IRQ affinity").

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
