Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F99C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D2E218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLRO2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbfLRO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:28:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIER4Mm069056
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:28:38 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wymc33pem-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:28:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 18 Dec 2019 14:28:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 14:28:30 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIESTsL54395062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 14:28:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90FF14204C;
        Wed, 18 Dec 2019 14:28:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3704142047;
        Wed, 18 Dec 2019 14:28:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 14:28:28 +0000 (GMT)
Subject: Re: [PATCH] integrity: Expose data structures required for
 include/linux/integrity.h
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Florent Revest <revest@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kpsingh@chromium.org
Date:   Wed, 18 Dec 2019 09:28:27 -0500
In-Reply-To: <1576676087.4579.396.camel@linux.ibm.com>
References: <20191217134748.198011-1-revest@chromium.org>
         <e9e366d3-6c5d-743b-ffde-6b95b85884a2@schaufler-ca.com>
         <1576624105.4579.379.camel@linux.ibm.com>
         <2ae5127d76cbf78140fb2d6108c9ec70c7d8ae5d.camel@chromium.org>
         <1576676087.4579.396.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121814-0016-0000-0000-000002D631E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121814-0017-0000-0000-0000333870E3
Message-Id: <1576679307.4579.401.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912180120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'ing Matthew]

On Wed, 2019-12-18 at 08:34 -0500, Mimi Zohar wrote:
> On Wed, 2019-12-18 at 12:03 +0100, Florent Revest wrote:
> > On Tue, 2019-12-17 at 18:08 -0500, Mimi Zohar wrote:
> > > On Tue, 2019-12-17 at 08:25 -0800, Casey Schaufler wrote:
> > > > On 12/17/2019 5:47 AM, Florent Revest wrote:
> > > > > From: Florent Revest <revest@google.com>
> > > > > 
> > > > > include/linux/integrity.h exposes the prototype of
> > > > > integrity_inode_get().
> > > > > However, it relies on struct integrity_iint_cache which is
> > > > > currently
> > > > > defined in an internal header, security/integrity/integrity.h.
> > > > > 
> > > > > To allow the rest of the kernel to use integrity_inode_get,
> > > > 
> > > > Why do you want to do this?
> > > 
> > > ditto
> > 
> > My team works on KRSI (eBPF MAC policies presented at LSS by KP Singh).
> > https://lkml.org/lkml/2019/9/10/393 We identified file hashes gathered
> > from the integrity subsystem as an interesting field that we could
> > potentially someday expose to eBPF programs through helpers.
> > 
> > One of the reason behind writing KRSI is to replace a custom kernel
> > auditing module that currently needs to redefine those structures to
> > access them. I imagine other kernel modules could benefit from a file
> > hash API too.
> > 
> > This is the least intrusive patch I could come up with that allows us
> > to lookup a hash from an inode. I was surprised to find that
> > integrity_inode_get was exposed but not the structures it returns.
> > 
> > If the community is interested in a different file hash API, I'd be
> > happy to iterate on this patch based on your feedback.
> 
> There's a major difference between returning just the file hash and
> making the integrity_iint_cache structure public.  Peter Moody's
> original code queried the cache[1].  Why do you need access to the
> structure itself?
> 
> FYI, if/when we get to IMA namespacing, the cache structure will
> change.
> 
> [1] ima: add the ability to query ima for the hash of a given file.

If you're using Peter's patch, or something similar, I'd appreciate
your taking the time to upstream it.

Mimi

> 
> > 
> > > > >  this patch
> > > > > moves the definition of the necessary structures from a private
> > > > > header
> > > > > to a global kernel header.
> > 
> 

