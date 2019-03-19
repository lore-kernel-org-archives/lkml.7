Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555062146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aVn4VwuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfCSVe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:34:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfCSVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:34:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JLYm01028228;
        Tue, 19 Mar 2019 21:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=+hVwuZG4ZG+BScDUQij2/8ehEg4bknjtiEX+69gqIYk=;
 b=aVn4VwuXfjqSHZN/Mzg7xGIfJE0A3gXIKbNDmEqmwjoA5qr6QdPC3npWShItYW0qTozg
 crkjt/QdGOTd31xp3o2Fp3DASTmJj6uvhwArablvNLvlHho8QjLLzZbbSgIKg6IJmgHk
 G/sfTDr+j89dgh5yaE4hVAfIL1UUUNBlYk8mZ+i7uMO8fH+4duqLzI3XMofdjy789p7G
 lfDe6/dLPYSnKDV35rX7pBCA52DwIf1lBn5YcyTCkrPiuuc5UsdLhZ+JHemoL6gH8VCK
 WspvflDQRU/z/7tgJIMSlXIIWyZWsoONx7BI4PS1LmZBDnr1AGt+9ikomBQBkbj35tPw RQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r8ssrf8kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:34:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLYmaq006598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:34:48 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2JLYlW4029212;
        Tue, 19 Mar 2019 21:34:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 14:34:46 -0700
To:     "Milan P. Gandhi" <mgandhi@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, dan.carpenter@oracle.com
Subject: Re: [PATCH 0/2] scsi: qla2xxx: Fix for a formatting issue and typo in qla_bsg.c
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190312124937.GA13922@machine1>
Date:   Tue, 19 Mar 2019 17:34:44 -0400
In-Reply-To: <20190312124937.GA13922@machine1> (Milan P. Gandhi's message of
        "Tue, 12 Mar 2019 18:19:37 +0530")
Message-ID: <yq1ftriblaj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=854 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Milan,

> This patch series fixes below two formatting/typos in qla_bsg.c:
> 1. Corrected alignment at the start of comment section
> 2. Fixed 'iiDMA' cmd spelling

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
