Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB76FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9297020850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3dZ//Xyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCSVPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:15:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34330 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:15:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JL94Ww034818;
        Tue, 19 Mar 2019 21:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=dcKsw8mkisCV5hhSZQx7BGCnhTAp9jGTFUGb2YeNbRc=;
 b=3dZ//XygjNp9ueDwRnJqTDJFGYIPWWozO0u32IOxcFLBkC6FDUs8S/wma6bYZKwGAQDi
 0m8XkcH4TIeka7GYacW5AAnRV6D00fWk2sCBbRMlJkUklxsT8NDBA1N/1KddYjBogUvS
 0Iy2rvsLbTKltsolHoSLnFhHKDO7EeK0W++X+Q9SDPjurjTx93u5eHBAkEcVij1AdgiA
 UpYu1tZh3md19TEn0PXu6u9R965kknjtjfoFQDiGpadnhxn1J4HYn/b4LzmOR/V7QiIM
 upCyT57LURe20N8PJXVmpGsCvBnJ7CFbKLVPdlimw8t2TR30JPbEhr7fedU5QPVZ1D3H KQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r8pneqgv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:15:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLFZJn016073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:15:35 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLFYlX028231;
        Tue, 19 Mar 2019 21:15:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 14:15:34 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt fusion: fix indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190207124407.2365-1-colin.king@canonical.com>
Date:   Tue, 19 Mar 2019 17:15:32 -0400
In-Reply-To: <20190207124407.2365-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 7 Feb 2019 12:44:07 +0000")
Message-ID: <yq1o966bm6j.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=748 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are several statements and code blocks there are incorrectly
> indented. Fix these.

Applied to 5.2/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
