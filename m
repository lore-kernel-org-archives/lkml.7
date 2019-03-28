Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227DC2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PpCgEMto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfC1BC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:02:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53786 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfC1BC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:02:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S0xvrZ005179;
        Thu, 28 Mar 2019 01:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=WAV8LKAknTO17gQ30JH6QQq9Pm/HmF4YCN7zazjqWIg=;
 b=PpCgEMtorvNvk8GAvEybizQjOZcdzWGzfEcGkX/+0cjjlexN5PAlOleMIko84ulnZ2am
 4kSnPxoyS0dZN+RgSpiP0wqLc3x1WruS0p6mV/h4PzMFbcOvzhvek3EJCdAN6Ca4A9bx
 2t3hqCUs4LM6exqPb9sgV5mFDZi2CEMWrHdcpsQ1Xvla2gsWLM7tGsNI1u2ul6I/lK7u
 AhwZqnXApj+bb40ldTz0icFdvbtoBZ33bzhXAc7bhhpDAW6o3VKd7VY5KDMgb4vAO7cX
 hAt3fmf/K0iR0ThWqq3PwaCTXV8DNMiVQcDwulnV+7e32cWXP8QD1kHziFymMrwhHlQe nw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g13rfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:02:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2S12pvs020703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:02:51 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2S12o0f002860;
        Thu, 28 Mar 2019 01:02:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 18:02:50 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: fix indentation issue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190320165000.29340-1-colin.king@canonical.com>
Date:   Wed, 27 Mar 2019 21:02:47 -0400
In-Reply-To: <20190320165000.29340-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 20 Mar 2019 16:50:00 +0000")
Message-ID: <yq11s2rx13c.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=734 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are a couple of statements that are incorrectly indented, fix
> these.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
