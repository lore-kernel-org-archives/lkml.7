Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A94C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F8E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oH/ozLYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGLBcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:32:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGLBcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:32:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1U4Oo020371;
        Fri, 12 Jul 2019 01:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=NXDuTQP1XB+Wm9eBFSp+S1/dpd+7DqWERF846TeJNqQ=;
 b=oH/ozLYEK3K87Zw+IRtEF03KmFdD46y3p1s1bMdlpD3S10aGH0Qn3lT0cYyNPbfSgWZ5
 CUKaWW4f12/92SaVpixXXZN5y3SX5dByNk3Nc1Ux8bP2YEdUvkhxx0EeklF4E0PDIcd3
 pZQ7MrN/VVTDc4DgzS9zdH4rrSMPGYoc7qQGpM5mo9W25C+E4iN1VE84mHgZCyJ84KSj
 FBfl0u2MqAMAvdsE9IktIAxbLNlWK8Xt8kBihukSHn8+r0Uw5o3GT6zgQOL7M07Tc1hB
 WK7P52jo8lczkp5uQYGepweSLlEabgjs7u3hpqve4NjhKejae5f/WauO1TTDnex/iA2t NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkq2yy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:32:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1RlNH103457;
        Fri, 12 Jul 2019 01:30:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tmwgygked-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:30:13 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6C1U9An022240;
        Fri, 12 Jul 2019 01:30:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:30:09 -0700
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        David Carroll <david.carroll@microsemi.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Andrey Jr . Melnikov" <temnota.am@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: Re: [PATCH v2 2/2] scsi: aacraid: Remove references to Series-9 (only)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <2a6f5cc2-40cb-647c-003d-aae594d05062@virtuozzo.com>
        <20190710093113.27936-1-khorenko@virtuozzo.com>
        <20190710093113.27936-3-khorenko@virtuozzo.com>
Date:   Thu, 11 Jul 2019 21:30:07 -0400
In-Reply-To: <20190710093113.27936-3-khorenko@virtuozzo.com> (Konstantin
        Khorenko's message of "Wed, 10 Jul 2019 12:31:13 +0300")
Message-ID: <yq15zo86nvk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=862 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Konstantin,

> The patch removes references to Series 9 adapters following
> 395e5df79a95 ("scsi: aacraid: Remove reference to Series-9"),
> but doesn't touch Series 6 adapters logic.

We'll need some guidance from the Microsemi folks on this issue.

> https://bugzilla.redhat.com/show_bug.cgi?id=1724077
> https://jira.sw.ru/browse/PSBM-95736

These two links don't appear to be publicly accessible and therefore do
not belong in the patch.

-- 
Martin K. Petersen	Oracle Linux Engineering
