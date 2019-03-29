Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F612C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53D6206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCgntqV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfC2ORl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:17:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48582 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfC2ORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:17:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEDwlo008451;
        Fri, 29 Mar 2019 14:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=BOXcKucORq6WjwOBFqRhLNwWQFjEI0r0Su0S5puCXlQ=;
 b=iCgntqV4bExBTFgJF8m2eD+wNUsDoaCRCriNnWTOuMfCW2pG/Vpoq6a8Q4CdvMJVn5ab
 wr/NEchynBdlDr14jYTFFPu/6YPUGtwJw+R5Rig2qqf9rWW1UUvoKXXhyKaUSIU8Ghtx
 lI00SaVuhtBr6qPGdqIVazmmjLh10DmSxAujnGyTpepSmmFlKV5/7Z9L4GGj5cmZcxm4
 PqfNgv7MI8gXlyymz+05GjyFWvEgF3H9NjIJddSQAX2ckuM3U6fTtzuv2PEzcEctpBtn
 uMRSgNA/drppKRvVZlUOcXJmG7ll7/p59tfbX6huea7GnuKKmKNJ/tc6D7d4vPT4vmSs yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6djvqnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:17:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEHUON012895
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:17:30 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEHRmv009482;
        Fri, 29 Mar 2019 14:17:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:17:27 -0700
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     QLogic-Storage-Upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: remove unneeded variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
Date:   Fri, 29 Mar 2019 10:17:25 -0400
In-Reply-To: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
        (Ding Xiang's message of "Fri, 29 Mar 2019 11:24:12 +0800")
Message-ID: <yq1va01rci2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=928 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ding,

> "rc" is unneeded,just return SUCCESS

Applied to 5.2/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
