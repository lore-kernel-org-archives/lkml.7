Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA2C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbfJPHwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:52:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfJPHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:52:43 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7gKGY024964
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:52:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vng3u1rtn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:52:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Wed, 16 Oct 2019 08:52:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:52:38 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7qbFe29753460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:52:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A5DA405C;
        Wed, 16 Oct 2019 07:52:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B929EA4065;
        Wed, 16 Oct 2019 07:52:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:52:36 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 862F8A01B6;
        Wed, 16 Oct 2019 18:52:32 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
Subject: [ANNOUNCE] Call for Sessions - linux.conf.au 2020 Kernel Miniconf
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
Date:   Wed, 16 Oct 2019 18:52:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0020-0000-0000-000003797D21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0021-0000-0000-000021CF9F44
Message-Id: <b15cd04a-b7d0-f14c-38e4-6204858425db@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LCA2020 Kernel Miniconf - Gold Coast, Queensland, Australia - 2020-01-14
------------------------------------------------------------------------

******

LCA Kernel Miniconf submissions open!

Submissions close: 2019-12-08 (early submissions until 2019-11-17)

Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/

More info: https://lca-kernel.ozlabs.org/2020-cfs.html

******

linux.conf.au 2020 will be held at the Gold Coast Convention and 
Exhibition Centre, from 13-17 January 2020. The Kernel Miniconf is 
returning once again to discuss all things kernel.

The Kernel Miniconf is a single-day miniconf track about everything 
related to the kernel and low-level systems programming.

The Kernel Miniconf will focus on a variety of kernel-related topics - 
technical presentations on up-and-coming kernel developments, the future 
direction of the kernel, and kernel development community and process 
matters. Past Kernel Miniconfs have included technical talks on topics 
such as memory management, RCU, scheduling and filesystems, as well as 
talks on Linux kernel community topics such as licensing and Linux 
kernel development process.

We invite submissions on anything related to kernel and low-level 
systems programming. We welcome submissions from developers of all 
levels of experience in the kernel community, covering a broad range of 
topics. The focus of the miniconf will primarily be on Linux, however 
non-Linux talks of sufficient interest to a primarily Linux audience 
will be considered.

Early Close Date: 2019-11-17, midnight Anywhere on Earth (UTC-12)
Final Close Date: 2019-12-08, midnight Anywhere on Earth (UTC-12)
Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/

** For more information: http://lca-kernel.ozlabs.org/2020-cfs.html **

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

