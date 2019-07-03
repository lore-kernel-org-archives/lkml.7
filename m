Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16449C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CAC21871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGCEgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:36:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfGCEgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:36:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x634WSxA048943
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jul 2019 00:36:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgkg3upbj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:36:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 3 Jul 2019 05:36:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 05:36:10 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x634aAlg51445780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 04:36:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E578BAE055;
        Wed,  3 Jul 2019 04:36:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B53FAE045;
        Wed,  3 Jul 2019 04:36:06 +0000 (GMT)
Received: from [9.85.75.18] (unknown [9.85.75.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 04:36:05 +0000 (GMT)
Subject: Re: Reminder: 22 open syzbot bugs in perf subsystem
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzkaller-bugs@googlegroups.com, Oleg Nesterov <oleg@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190702054342.GB27702@sol.localdomain>
 <5a99f556-7449-55da-d901-0249352a5e15@linux.ibm.com>
 <20190703035550.GA633@sol.localdomain>
 <4d6ce02e-9325-4247-3d9b-51cdfcfaee07@linux.ibm.com>
 <20190703041918.GB633@sol.localdomain>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 3 Jul 2019 10:06:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703041918.GB633@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070304-0028-0000-0000-0000037FDC73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070304-0029-0000-0000-0000244018F3
Message-Id: <7dd388d6-628d-23aa-0a97-84e7e0800b74@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/19 9:49 AM, Eric Biggers wrote:
> On Wed, Jul 03, 2019 at 09:29:39AM +0530, Ravi Bangoria wrote:
>> Hi Eric,
>>
>> On 7/3/19 9:25 AM, Eric Biggers wrote:
>>> On Wed, Jul 03, 2019 at 09:09:55AM +0530, Ravi Bangoria wrote:
>>>>
>>>>
>>>> On 7/2/19 11:13 AM, Eric Biggers wrote:
>>>>> --------------------------------------------------------------------------------
>>>>> Title:              possible deadlock in uprobe_clear_state
>>>>> Last occurred:      164 days ago
>>>>> Reported:           201 days ago
>>>>> Branches:           Mainline
>>>>> Dashboard link:     https://syzkaller.appspot.com/bug?id=a1ce9b3da349209c5085bb8c4fee753d68c3697f
>>>>> Original thread:    https://lkml.kernel.org/lkml/00000000000010a9fb057cd14174@google.com/T/#u
>>>>>
>>>>> Unfortunately, this bug does not have a reproducer.
>>>>>
>>>>> No one replied to the original thread for this bug.
>>>>>
>>>>> If you fix this bug, please add the following tag to the commit:
>>>>>     Reported-by: syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
>>>>>
>>>>> If you send any email or patch for this bug, please consider replying to the
>>>>> original thread.  For the git send-email command to use, or tips on how to reply
>>>>> if the thread isn't in your mailbox, see the "Reply instructions" at
>>>>> https://lkml.kernel.org/r/00000000000010a9fb057cd14174@google.com
>>>>>
>>>>
>>>> This is false positive:
>>>> https://marc.info/?l=linux-kernel&m=154925313012615&w=2
>>>>
>>>
>>> What do you mean "false positive"?  Your patch says there can be a deadlock.
>>> Also, your patch hasn't been merged yet.  So doesn't it still need to be fixed?
>>
>> Please see Oleg's reply to the patch:
>> https://marc.info/?l=linux-kernel&m=154946017315554&w=2
>>
>> """
>> But this is false positive, right? if CPU1 calls update_ref_ctr() then
>> either ->mm_users is already zero so binder_alloc_free_page()->mmget_not_zero()
>> will fail, or the caller of update_ref_ctr() has a reference and thus
>> binder_alloc_free_page()->mmput() can't trigger __mmput() ?
>> """
>>
> 
> Even if it's a lockdep false positive you can't ignore it.  People rely on
> lockdep to find bugs, and they will keep sending you bug reports.  So someone
> has to fix something.

Agreed.

> Did you see Oleg's suggestion to change mmput() to
> mmput_async() in binder_alloc_free_page()?
> https://marc.info/?l=linux-kernel&m=155119805728815&w=2
> If you believe that is the right fix,

Yes, fixing it in binderfs looks right to me.

> I can reassign this report to binder
> subsystem and nag the binder maintainers instead...

Yes please :)

