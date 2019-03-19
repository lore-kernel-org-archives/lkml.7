Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342242082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vJ1EOR63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCSSTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:19:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39232 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfCSSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:19:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JIJBmB091372;
        Tue, 19 Mar 2019 18:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=95cbZXjGs9E79bqKLgG23mOBvLE2T8UmyHlJzI35xH8=;
 b=vJ1EOR634kOu3NKPZsV2I8kjZs1YC1yHuAaGxj6U0AD3IMGEJxs58Xdzb9pdBKUDV+fr
 r7OD3/bXcZjKEPgIpMGwlsF3wOz/E90KhisXA2KRwjLfQMxIdjakkXEHG4VuUBg0rJww
 Wg/20MSHHO3LhKtTzIiBWPmVFAFNUcMGmBYd/F3Z6ab+hun8vNZB3fO1wwUjBiX9BMRN
 rGJuWRvhDAMm6r6HkcRTwsQO1JEXuQcMY3crsvXVzYksexodqbmyyeCpIkVlLKpIYozY
 d0hg5HCARo+aiKvVMXGF4hYV4gqJ1hmZe4P/0LH6z+dbdx665KGpJFgMOwIR3HpFPEyP tw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r8pnepqcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:19:40 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2JIJZ1d030673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:19:35 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2JIJZNX020296;
        Tue, 19 Mar 2019 18:19:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 11:19:34 -0700
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi/NCR5380: Remove set but unused variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <dd8814ad55ee7d86b1c7f5f47cd68ff0ff33f8d9.1551995342.git.fthain@telegraphics.com.au>
Date:   Tue, 19 Mar 2019 14:19:32 -0400
In-Reply-To: <dd8814ad55ee7d86b1c7f5f47cd68ff0ff33f8d9.1551995342.git.fthain@telegraphics.com.au>
        (Finn Thain's message of "Fri, 08 Mar 2019 08:49:02 +1100")
Message-ID: <yq1k1guengr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=863 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

Applied to 5.2/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
