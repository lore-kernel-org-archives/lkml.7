Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A219DC742A1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686F42084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9ZB+DwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfGLAOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:14:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33936 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbfGLAOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:14:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0EiMg167808;
        Fri, 12 Jul 2019 00:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=DzEpnMM0XIAZkQhNkXNTuL7KgSoHSwCJotnMkirnVEQ=;
 b=Y9ZB+DwWn1FBl8gge1tLuPESrvTj1OuQh8MQnbYMyXNAhcffXJwwyDCSLiy8p9B9yLLd
 mrdB6qHBOh+cXEnmNU0G3cQU81KI5/nqgeDA2/132TLNNMMYrM67lWMIrMXZDJhw0Gr/
 RDxp1sKvi1JcsWElMwL+vb2xhwOuDGQcyhC/+tgz9z1xzTbuR2ZYCNEh/VJUHWVBp2J4
 qdg2628rRnyPgCHBqf4Ntar3KPmfwyEQHYvPYLPVhFVKqHLC0BKm/JESImTWXAV1094l
 9FAFrXUrlVQ63BgutRXznAyP0YGR2eWWBKADm/K8Kt6DCkEZc4qdkcnfPzMRYwhGH9Wx vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tjkkq2tgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:14:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0Cg1u150839;
        Fri, 12 Jul 2019 00:14:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tn1j1u2p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:14:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0EYYc026045;
        Fri, 12 Jul 2019 00:14:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:14:34 -0700
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: Re: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
Date:   Thu, 11 Jul 2019 20:14:31 -0400
In-Reply-To: <1560346477-13944-1-git-send-email-avri.altman@wdc.com> (Avri
        Altman's message of "Wed, 12 Jun 2019 16:34:37 +0300")
Message-ID: <yq1ef2w9kig.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=978
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri,

> added 'WITH Linux-syscall-note' exception, which is the officially
> assigned exception identifier for the kernel syscall exception.
> This exception makes it possible to include GPL headers into non GPL
> code, without confusing license compliance tools.

I'd like Arnd to ack the license change since he has made changes
(however mechanical) to the file.

-- 
Martin K. Petersen	Oracle Linux Engineering
