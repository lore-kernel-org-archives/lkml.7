Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632C0214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCLBwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:52:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbfCLBwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:52:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C1nJJk054532
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:52:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r5x8wcgv4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:52:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Mar 2019 01:52:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 01:52:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2C1qOJ059047936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 01:52:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96F4B42049;
        Tue, 12 Mar 2019 01:52:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC1F44203F;
        Tue, 12 Mar 2019 01:52:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.30])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 01:52:23 +0000 (GMT)
Subject: Re: [PULL REQUEST] Kernel lockdown patches for 5.2
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Mon, 11 Mar 2019 21:52:13 -0400
In-Reply-To: <CACdnJuszfo4gTUD88p+8jeHU5e3hSdp+GEr8_=F1AMThPb7yWg@mail.gmail.com>
References: <20190306235913.6631-1-matthewgarrett@google.com>
         <1551930990.31706.279.camel@linux.ibm.com>
         <CACdnJuuib7kYEw1o0Bh1p=X+MmJH+pqupECWnWTJ2e2jE2XRkg@mail.gmail.com>
         <CACdnJuszfo4gTUD88p+8jeHU5e3hSdp+GEr8_=F1AMThPb7yWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031201-4275-0000-0000-00000319D1DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031201-4276-0000-0000-000038283833
Message-Id: <1552355533.24794.27.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 17:42 -0700, Matthew Garrett wrote:
> On Wed, Mar 6, 2019 at 8:24 PM Matthew Garrett <mjg59@google.com> wrote:
> >
> > On Wed, Mar 6, 2019 at 7:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > The kexec and kernel modules patches in this patch set continues to
> > > ignore IMA.  This patch set should up front either provide an
> > > alternative solution to coordinate the different signature
> > > verification methods or rely on the architecture specific policy for
> > > that coordination.
> >
> > Hi Mimi,
> >
> > I'm working on a patch for this at the moment which can then be added
> > to either patchset. Is there a tree that contains the proposed Power
> > architecture policy? I want to make sure I don't accidentally end up
> > depending on anything x86.
> 
> I've been digging into this some more, and want to ensure that I get
> the appropriate semantics. Are we happy with the x86 solution for
> module signing (ie, if the arch policy is enabled and the kernel
> supports module signatures, use module signatures rather than IMA
> signatures)? 

There's a slight nuance you're missing.  If the arch policy is enabled
and the kernel supports module signatures, do not add an IMA appraise
rule.  A custom policy could require an IMA signature, as well as the
module appended signature.

Saying only use the module signatures, even if the IMA custom policy
contains a kernel module rule, doesn't make sense.

> If so, that just leaves kexec. For platforms that support
> PE signing for kernels (x86 and arm), are we ok punting to that?

Similarly, if the custom policy has a kexec kernel image policy rule,
it shouldn't be ignored.

> If so
> then to maintain the semantics we have for lockdown in general (ie, no
> way for a user to modify ring 0 code) then I think that would mean
> allowing kexec_file() only when the following criteria are met:
> 
> 1) IMA is appraising kexec with digital signatures, either ima digital
> signatures or ima hashes with associated EVM digital signatures

The kernel image could be signed with an appended signature as well.

> 2) CONFIG_INTEGRITY_TRUSTED_KEYRING is set in order to prevent an
> attacker being able to add a key to the keyring

Agreed

> Does this sound reasonable? Are there any further criteria that are
> required for this?

With the caveats described above.

Mimi

