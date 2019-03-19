Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0zJO0mk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfCSVMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:12:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:12:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JL96l3194546;
        Tue, 19 Mar 2019 21:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=r7gAOTojKGtWORpCkFbRKUCXmOv372NZlNL/w2ARCbs=;
 b=0zJO0mk4SEqVmG6AqQffgeMA+ryS/1STHCKo+W1TqTLHf0Zf0NMUanIKrxWhuMzPCUDn
 kzvhKcpddIqXso3PAkoXvnWNXVS6i8lKxwHxhVtGuA5ni9pmqRqMefpHdUpEMnf/0YEZ
 W5uGge7naiSGRWSyiRHaDtMuO4/ACjrNn8RfWgAJuHQMka6CshIYA10f/twLv7kvAvl4
 P26WzxbGOYt2fsGUqkHmA/P4VObHQYvL6RC/0iBG/ZdOUyVen2RvO9ZcjPOh68tu1gdA
 xBvn9lWpbouugcxZHAPNBvb9HwI0ALREOzEb8T6py9CQtTxQpCfLMwtGDm6Mk3vdPd6Y Lw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r8rjuqajq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:12:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLBxxd020382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:11:59 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLBxMv016453;
        Tue, 19 Mar 2019 21:11:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 14:11:59 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qlogicfas408: clean up a couple of indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190123131004.24460-1-colin.king@canonical.com>
Date:   Tue, 19 Mar 2019 17:11:57 -0400
In-Reply-To: <20190123131004.24460-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 23 Jan 2019 13:10:04 +0000")
Message-ID: <yq1wokubmci.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=884 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> An if statement is indented correctly and an outb statement has a
> redundant empty comment and incorrect indentation. Fix these.

Applied to 5.2/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
