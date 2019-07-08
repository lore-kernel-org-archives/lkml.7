Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3770C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE08521537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfGHO2V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:28:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729760AbfGHO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:28:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68ERMMl115712
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 10:28:20 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm60yvg5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:28:19 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 8 Jul 2019 14:28:19 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 8 Jul 2019 14:28:14 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019070814281388-485737 ;
          Mon, 8 Jul 2019 14:28:13 +0000 
In-Reply-To: <20190708140858.GC23966@mellanox.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@mellanox.com>
Cc:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Doug Ledford" <dledford@redhat.com>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Date:   Mon, 8 Jul 2019 14:28:13 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190708140858.GC23966@mellanox.com>,<20190708130351.2141a39b@canb.auug.org.au>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 8B5D0A35:3AB4C2D3-00258431:004F7CF8;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 37267
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19070814-0163-0000-0000-000006B23BBB
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.001805
X-IBM-SpamModules-Versions: BY=3.00011395; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01229239; UDB=6.00647369; IPR=6.01010498;
 BA=6.00006352; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027634; XFM=3.00000015;
 UTC=2019-07-08 14:28:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-08 08:53:28 - 6.00010139
x-cbparentid: 19070814-0164-0000-0000-0000100845AC
Message-Id: <OF8B5D0A35.3AB4C2D3-ON00258431.004F7CF8-00258431.004F7D00@notes.na.collabserv.com>
Subject: Re:  Re: linux-next: build failure after merge of the rdma tree
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----"Jason Gunthorpe" <jgg@mellanox.com> wrote: -----

>To: "Stephen Rothwell" <sfr@canb.auug.org.au>, "Bernard Metzler"
><bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@mellanox.com>
>Date: 07/08/2019 04:09PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Linux Next Mailing List"
><linux-next@vger.kernel.org>, "Linux Kernel Mailing List"
><linux-kernel@vger.kernel.org>
>Subject: [EXTERNAL] Re: linux-next: build failure after merge of the
>rdma tree
>
>On Mon, Jul 08, 2019 at 01:03:51PM +1000, Stephen Rothwell wrote:
>> Hi all,
>> 
>> After merging the rdma tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>> 
>> In file included from include/asm-generic/percpu.h:7,
>>                  from arch/x86/include/asm/percpu.h:544,
>>                  from arch/x86/include/asm/preempt.h:6,
>>                  from include/linux/preempt.h:78,
>>                  from include/linux/spinlock.h:51,
>>                  from include/linux/seqlock.h:36,
>>                  from include/linux/time.h:6,
>>                  from include/linux/ktime.h:24,
>>                  from include/linux/timer.h:6,
>>                  from include/linux/netdevice.h:24,
>>                  from drivers/infiniband/sw/siw/siw_main.c:8:
>> include/linux/percpu-defs.h:92:33: warning: '__pcpu_unique_use_cnt'
>initialized and declared 'extern'
>>   extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;  \
>>                                  ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:115:2: note: in expansion of macro
>'DEFINE_PER_CPU_SECTION'
>>   DEFINE_PER_CPU_SECTION(type, name, "")
>>   ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of
>macro 'DEFINE_PER_CPU'
>>  static DEFINE_PER_CPU(atomic_t, use_cnt = ATOMIC_INIT(0));
>>         ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:93:26: error: redefinition of
>'__pcpu_unique_use_cnt'
>>   __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;   \
>>                           ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:115:2: note: in expansion of macro
>'DEFINE_PER_CPU_SECTION'
>>   DEFINE_PER_CPU_SECTION(type, name, "")
>>   ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of
>macro 'DEFINE_PER_CPU'
>>  static DEFINE_PER_CPU(atomic_t, use_cnt = ATOMIC_INIT(0));
>
>Bernard, 
>
>This looks like the wrong way to use DEFINE_PER_CPU these days. I'm
>not sure why my compiles don't hit it, or why 0-day didn't say
>something
>
>Looking at the other atomic_t PER_CPU users they just rely on
>automatic zero initialization, so this should just be:
>
>  static DEFINE_PER_CPU(atomic_t, use_cnt);
>
>?
>
>Please confirm ASAP.
>

Hi Jason,

Thanks for  bringing this up. Indeed, that explicit
initialization seem to be inappropriate. Can you please
fix that as you suggest?

Thanks very much,
Bernard.

