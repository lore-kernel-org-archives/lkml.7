Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FF2206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLJGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:23:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbfLJGXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:23:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA6CkBB147314
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:23:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtkt1ryk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:23:18 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Tue, 10 Dec 2019 06:23:16 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 06:23:14 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBA6NDTE31588394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 06:23:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01228AE05D;
        Tue, 10 Dec 2019 06:23:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DEC6AE051;
        Tue, 10 Dec 2019 06:23:11 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.37.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Dec 2019 06:23:10 +0000 (GMT)
Date:   Tue, 10 Dec 2019 11:53:08 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "longman@redhat.com" <longman@redhat.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Reply-To: bharata@linux.ibm.com
References: <20190905214553.1643060-1-guro@fb.com>
 <20191209091746.GA16989@in.ibm.com>
 <20191209115649.GA17552@in.ibm.com>
 <20191209180418.GA15797@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209180418.GA15797@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 19121006-0016-0000-0000-000002D35E99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121006-0017-0000-0000-0000333573C3
Message-Id: <20191210062308.GC17552@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 06:04:22PM +0000, Roman Gushchin wrote:
> On Mon, Dec 09, 2019 at 05:26:49PM +0530, Bharata B Rao wrote:
> > On Mon, Dec 09, 2019 at 02:47:52PM +0530, Bharata B Rao wrote:
> Hello, Bharata!
> 
> Thank you very much for the report and the patch, it's a good catch,
> and the code looks good to me. I'll include the fix into the next
> version of the patchset (I can't keep it as a separate fix due to massive
> renamings/rewrites).

Sure, but please note that I did post only the core change without
the associated header includes etc, where I took some short cuts.

> 
> > 
> > But that still doesn't explain why we don't hit this problem on x86.
> 
> On x86 (and arm64) we're using vmap-based stacks, so the underlying memory is
> allocated directly by the page allocator, bypassing the slab allocator.
> It depends on CONFIG_VMAP_STACK.

I turned off CONFIG_VMAP_STACK on x86, but still don't hit any
problems.

$ grep VMAP .config
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set

May be something else prevents this particular crash on x86?

> 
> Btw, thank you for looking into the patchset and trying it on powerpc.
> Would you mind to share some results?

Sure, I will get back with more results, but initial numbers when running
a small alpine docker image look promising.

With slab patches
# docker stats --no-stream
CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
24bc99d94d91        sleek               0.00%               1MiB / 25MiB        4.00%               1.81kB / 0B         0B / 0B             0

Without slab patches
# docker stats --no-stream
CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
52382f8aaa13        sleek               0.00%               8.688MiB / 25MiB    34.75%              1.53kB / 0B         0B / 0B             0

So that's an improvement of MEM USAGE from 8.688MiB to 1MiB. Note that this
docker container isn't doing anything useful and hence the numbers
aren't representative of any workload.

Regards,
Bharata.

