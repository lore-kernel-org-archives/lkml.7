Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46CE21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfFNOJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:09:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727382AbfFNOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:09:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EE7fcd083904
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:09:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t4b9acwxp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:09:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 14 Jun 2019 15:09:22 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 15:09:20 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EE9JIx34341126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 14:09:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC1DA405B;
        Fri, 14 Jun 2019 14:09:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36580A4054;
        Fri, 14 Jun 2019 14:09:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.199])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 14:09:18 +0000 (GMT)
Subject: Re: linux-next: build failure after merge of the integrity tree
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janne Karhunen <janne.karhunen@gmail.com>
Date:   Fri, 14 Jun 2019 10:09:07 -0400
In-Reply-To: <20190614153459.49c3d075@canb.auug.org.au>
References: <20190614153459.49c3d075@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061414-0028-0000-0000-0000037A52F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061414-0029-0000-0000-0000243A5037
Message-Id: <1560521347.4072.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, 2019-06-14 at 15:34 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the integrity tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/infiniband/core/device.c: In function 'ib_core_init':
> drivers/infiniband/core/device.c:2531:8: error: implicit declaration of function 'register_blocking_lsm_notifier'; did you mean 'register_lsm_notifier'? [-Werror=implicit-function-declaration]
>   ret = register_blocking_lsm_notifier(&ibdev_lsm_nb);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         register_lsm_notifier
> drivers/infiniband/core/device.c:2550:2: error: implicit declaration of function 'unregister_blocking_lsm_notifier'; did you mean 'unregister_lsm_notifier'? [-Werror=implicit-function-declaration]
>   unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   unregister_lsm_notifier
> 
> Caused by commit
> 
>   bafe78e69508 ("LSM: switch to blocking policy update notifiers")
> 
> CONFIG_SECURITY is not set for this build and the !CONFIG_SECURITY
> declarations were not fixed up in linux/security.h.
> 
> I have used the integrity tree from next-20190613 for today.

Thank you!  A new version of the patch has been push to the next-
integrity branch.

Mimi

