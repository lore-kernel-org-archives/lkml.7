Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0DB2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v36revJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfCZCKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:10:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41354 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfCZCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:10:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q29Kvh059788;
        Tue, 26 Mar 2019 02:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=fiPSubIoBmwHiUK/ziWc5GKMlGMINVr9Dm2mxOoVJJ8=;
 b=v36revJpRsT6TfwwmfxNTrJs6r2Fl5EqTmpj1nXQ98AyOkrAIMYtxfSv75WS5Uc7iTK3
 zK9jHJ1YH77hbmN6OICtA4tebLU6VOiYIritbxw7zo3dFw63K/+YwgzZhFAOGGYJZIIf
 Lnio8XbazjStIE257QU8eMKda8jDOGcVJm0GTxY7PObMZvb1ivy4sbwJqxvfX9gchjxO
 kmcPsQ/K1wZGbSMw9tR2fMWZfLq8RZiyd73URKZD4iEI1ZeD5gOdOuFH6zR9yhsCkhZT
 55NDPAetrMZimAOsXy/Wx2rTQS+qVqsyQjRnoRQt1ITIK1vzLq3LTl0E4s3ocfRa5qfU WQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g0qjsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:10:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2AZWL025025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:10:35 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q2AZ6u024459;
        Tue, 26 Mar 2019 02:10:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 19:10:35 -0700
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] drivers: ufs: Add missing MODULE_* information
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190321132444.28659-1-anders.roxell@linaro.org>
Date:   Mon, 25 Mar 2019 22:10:32 -0400
In-Reply-To: <20190321132444.28659-1-anders.roxell@linaro.org> (Anders
        Roxell's message of "Thu, 21 Mar 2019 14:24:44 +0100")
Message-ID: <yq17ecm1j3b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=985 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Anders,

> When building the ufs-mediatek module the following warning shows up:
>
> WARNING: modpost: missing MODULE_LICENSE() in
>   drivers/scsi/ufs/ufs-mediatek.o
>
> Rework to add MODULE_LICENSE,MODULE_AUTHOR and MODULE_DESCRIPTION.

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
