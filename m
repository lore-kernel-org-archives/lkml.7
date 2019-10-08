Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C554FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931FC20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfbkRcii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfJHEC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:02:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42624 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfJHEC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:02:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x983wnk5116279;
        Tue, 8 Oct 2019 04:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Ilfr1eHeOWF1J0ewUy9pj/4tQ904lPTR8mQXIqUj+/Y=;
 b=rfbkRciixrWbJ33j5RS/or1ncTNLH+fq1CxXbAYSKJHjI+X40xPAp99AIHQQup8Gdtp8
 IHEZDL0n0nEl7UfxfqCMKrY3W6PU5YQWDdr6JqEfQhQfD9iifCvj/BC/0M3QC3uPOySH
 THBUrqi4YJdIiUY2OykQ/wkCrhkTr5XRWm6aa6G0hZNxnIXTf+ypOp6qO2dV8eVeMJIG
 Yn15JdngEgLn/IsW8KP8rXOIgeKGfBqj1GWgk6KTMJiZCnIcPMVqY2Ahg0d1CCyb9gHP
 2UI6G9/AylaxZIMjD4Ul7QaoUd6NPXmMsZcWfElmiMO/PdetFwLHn7iTC5DWlDtJfO9U KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qamrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 04:02:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9842dBQ032647;
        Tue, 8 Oct 2019 04:02:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vgeuwwspe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 04:02:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9842oAD024259;
        Tue, 8 Oct 2019 04:02:50 GMT
Received: from [10.191.3.27] (/10.191.3.27)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 04:02:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     apw@canonical.com, joe@perches.com
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: checkpatch error
Organization: Oracle Corporation
Message-ID: <02cc0e89-8b48-14f6-aabe-ec1201df59aa@oracle.com>
Date:   Tue, 8 Oct 2019 12:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I run checkpatch.pl with a patch doing reverting operation, it 
reports a false positive error, Should I ignore the error or it's a bug?

0001-Revert-KVM-X86-Fix-setup-the-virt_spin_lock_key-befo.patch
---------------------------------------------------------------
ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit 090d54bcbc54 ("Revert 
"x86/paravirt: Set up the v'
#14:
The similar change for XEN is in commit 090d54bcbc54 ("Revert

total: 1 errors, 0 warnings, 31 lines checked
NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.


# cat 0001-Revert-KVM-X86-Fix-setup-the-virt_spin_lock_key-befo.patch
 From 5d90690ba0476cab223f5e1d13955858b9c91623 Mon Sep 17 00:00:00 2001
From: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Date: Mon, 7 Oct 2019 09:20:58 +0800
Subject: [PATCH v5 1/5] Revert "KVM: X86: Fix setup the virt_spin_lock_key
  before static key get initialized"

This reverts commit 34226b6b70980a8f81fff3c09a2c889f77edeeff.

Commit 8990cac6e5ea ("x86/jump_label: Initialize static branching
early") adds jump_label_init() call in setup_arch() to make static
keys initialized early, so we could use the original simpler code
again.

The similar change for XEN is in commit 090d54bcbc54 ("Revert
"x86/paravirt: Set up the virt_spin_lock_key after static keys get
initialized"")
...


Thanks

Zhenzhong

