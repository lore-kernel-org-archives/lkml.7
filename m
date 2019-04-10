Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7220652
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfDJQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:04:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbfDJQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:04:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AG1al2121000
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:04:50 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rshsb70d7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:04:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 10 Apr 2019 17:04:47 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 17:04:44 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3AG4ho034341030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 16:04:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57946A406D;
        Wed, 10 Apr 2019 16:04:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1349FA405F;
        Wed, 10 Apr 2019 16:04:43 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Apr 2019 16:04:43 +0000 (GMT)
Date:   Wed, 10 Apr 2019 18:04:41 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
Subject: Re: rseq/s390: choosing code signature
In-Reply-To: <2074744632.3167.1554911856144.JavaMail.zimbra@efficios.com>
References: <1779981820.2626.1554838342731.JavaMail.zimbra@efficios.com>
        <20190410123258.37f182cf@mschwideX1>
        <514609006.3159.1554911439933.JavaMail.zimbra@efficios.com>
        <20190410175243.6fc3d16a@mschwideX1>
        <2074744632.3167.1554911856144.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041016-0016-0000-0000-0000026D66E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041016-0017-0000-0000-000032C99767
Message-Id: <20190410180441.69e1e85d@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 10, 2019, at 11:52 AM, schwidefsky schwidefsky@de.ibm.com wrote:
> 
> > On Wed, 10 Apr 2019 11:50:39 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> ----- On Apr 10, 2019, at 6:32 AM, schwidefsky schwidefsky@de.ibm.com wrote:
> >>   
> >> > On Tue, 9 Apr 2019 15:32:22 -0400 (EDT)
> >> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >> >     
> >> >> Hi,
> >> >> 
> >> >> We are about to include the code signature required prior to restartable
> >> >> sequences abort handlers into glibc, which will make this ABI choice final.
> >> >> We need architecture maintainer input on that signature value.
> >> >> 
> >> >> That code signature is placed before each abort handler, so the kernel can
> >> >> validate that it is indeed jumping to an abort handler (and not some
> >> >> arbitrary attacker-chosen code). The signature is never executed.
> >> >> 
> >> >> The current discussion thread on the glibc mailing list leads us towards
> >> >> using a trap with uncommon immediate operand, which simplifies integration
> >> >> with disassemblers, emulators, makes it easier to debug if the control
> >> >> flow gets redirected there by mistake, and is nicer for some architecture's
> >> >> speculative execution.
> >> >> 
> >> >> We can have different signatures for each sub-architecture, as long as they
> >> >> don't have to co-exist within the same process. We can special-case with
> >> >> #ifdef for each sub-architecture and endianness if need be. If the architecture
> >> >> has instruction set extensions that can co-exist with the architecture
> >> >> instruction set within the same process, we need to take into account to which
> >> >> instruction the chosen signature value would map (and possibly decide if we
> >> >> need to extend rseq to support many signatures).
> >> >> 
> >> >> Here is an example of rseq signature definition template:
> >> >> 
> >> >> /*
> >> >>  * TODO: document trap instruction objdump output on each sub-architecture
> >> >>  * instruction sets, as well as instruction set extensions.
> >> >>  */
> >> >> #define RSEQ_SIG 0x########
> >> >> 
> >> >> Ideally we'd need a patch on top of the Linux kernel
> >> >> tools/testing/selftests/rseq/rseq-s390.h file that updates
> >> >> the signature value, so I can then pick it up for the glibc
> >> >> patchset.  
> >> > 
> >> > The trap4 instruction is a suitable one. The patch would look like this  
> >> 
> >> Great! I'm picking it up into my rseq tree if that's OK with you.  
> > 
> > Just added the patch to s390/linux:features for the next merge window as well.  
> 
> Sounds good! I'll carry it in my tree to have a comprehensive up-to-date list of
> rseq signatures for all architectures in a single tree. Worse-case the exact same
> change will be pulled from both architecture and rseq trees, which I don't think
> should be an issue, right ?

Should be fine, the worst that can happen is a minor merge conflict.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

