Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2913EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C0E20823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfFSH4r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:56:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbfFSH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:56:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J7qcLa041280
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:56:45 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t7gjp9npk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:56:45 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 19 Jun 2019 08:56:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 08:56:41 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5J7uesw59441326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 07:56:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA2EB11C050;
        Wed, 19 Jun 2019 07:56:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9769F11C058;
        Wed, 19 Jun 2019 07:56:39 +0000 (GMT)
Received: from localhost (unknown [9.124.35.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 07:56:39 +0000 (GMT)
Date:   Wed, 19 Jun 2019 13:26:37 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] powerpc/ftrace: Update ftrace_location() for powerpc
 -mprofile-kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <186656540d3e6225abd98374e791a13d10d86fab.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190618114509.5b1acbe5@gandalf.local.home>
        <1560881411.p0i6a1dkwk.naveen@linux.ibm.com>
        <1560881840.vz9llflvnf.naveen@linux.ibm.com>
        <20190618143234.78539805@gandalf.local.home>
In-Reply-To: <20190618143234.78539805@gandalf.local.home>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19061907-0020-0000-0000-0000034B6576
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061907-0021-0000-0000-0000219EB760
Message-Id: <1560930937.j2vguryjp3.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Tue, 18 Jun 2019 23:53:11 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> Naveen N. Rao wrote:
>> > Steven Rostedt wrote:  
>> >> On Tue, 18 Jun 2019 20:17:04 +0530
>> >> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >>   
>> >>> @@ -1551,7 +1551,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>> >>>  	key.flags = end;	/* overload flags, as it is unsigned long */
>> >>>  
>> >>>  	for (pg = ftrace_pages_start; pg; pg = pg->next) {
>> >>> -		if (end < pg->records[0].ip ||
>> >>> +		if (end <= pg->records[0].ip ||  
>> >> 
>> >> This breaks the algorithm. "end" is inclusive. That is, if you look for
>> >> a single byte, where "start" and "end" are the same, and it happens to
>> >> be the first ip on the pg page, it will be skipped, and not found.  
>> > 
>> > Thanks. It looks like I should be over-riding ftrace_location() instead.  
>> > I will update this patch.  
>> 
>> I think I will have ftrace own the two instruction range, regardless of 
>> whether the preceding instruction is a 'mflr r0' or not. This simplifies 
>> things and I don't see an issue with it as of now. I will do more 
>> testing to confirm.
>> 
>> - Naveen
>> 
>> 
>> --- a/arch/powerpc/kernel/trace/ftrace.c
>> +++ b/arch/powerpc/kernel/trace/ftrace.c
>> @@ -951,6 +951,16 @@ void arch_ftrace_update_code(int command)
>>  }
>>  
>>  #ifdef CONFIG_MPROFILE_KERNEL
>> +/*
>> + * We consider two instructions -- 'mflr r0', 'bl _mcount' -- to be part
>> + * of ftrace. When checking for the first instruction, we want to include
>> + * the next instruction in the range check.
>> + */
>> +unsigned long ftrace_location(unsigned long ip)
>> +{
>> +	return ftrace_location_range(ip, ip + MCOUNT_INSN_SIZE);
>> +}
>> +
>>  /* Returns 1 if we patched in the mflr */
>>  static int __ftrace_make_call_prep(struct dyn_ftrace *rec)
>>  {
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 21d8e201ee80..122e2bb4a739 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -1573,7 +1573,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>>   * the function tracer. It checks the ftrace internal tables to
>>   * determine if the address belongs or not.
>>   */
>> -unsigned long ftrace_location(unsigned long ip)
>> +unsigned long __weak ftrace_location(unsigned long ip)
>>  {
>>  	return ftrace_location_range(ip, ip);
>>  }
> 
> Actually, instead of making this a weak function, let's do this:
> 
> 
> In include/ftrace.h:
> 
> #ifndef FTRACE_IP_EXTENSION
> # define FTRACE_IP_EXTENSION	0
> #endif
> 
> 
> In arch/powerpc/include/asm/ftrace.h
> 
> #define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE
> 
> 
> Then we can just have:
> 
> unsigned long ftrace_location(unsigned long ip)
> {
> 	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
> }

Thanks, that's indeed nice. I hope you don't mind me adding your SOB for 
that.

- Naveen


