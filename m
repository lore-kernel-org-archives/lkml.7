Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA8C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1B021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDXLeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:34:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727373AbfDXLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:34:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OBU8u4138954
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:34:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2n2np1w5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:34:04 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 24 Apr 2019 12:34:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 12:33:58 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OBXvOw43188232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 11:33:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0825A4068;
        Wed, 24 Apr 2019 11:33:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBF48A4064;
        Wed, 24 Apr 2019 11:33:54 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Apr 2019 11:33:54 +0000 (GMT)
Date:   Wed, 24 Apr 2019 14:33:53 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423071354.GB12114@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042411-4275-0000-0000-0000032C0709
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042411-4276-0000-0000-0000383B4F66
Message-Id: <20190424113352.GA6278@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > between 2004 and 2007. If someone is running a 64-bit capable system in
> > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> 
> Can we mark it as BROKEN to see if someone shouts and then remove it
> a year or two down the road?  Or just kill it off now..

How about making SPARSEMEM default for x86-32?

From ac2dc27414e26f799ea063fd1d01e19d70056f43 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 24 Apr 2019 14:32:12 +0300
Subject: [PATCH] x86/Kconfig: make SPARSEMEM default for X86_32

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fd..77b17af 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1609,10 +1609,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
 	depends on NUMA && X86_32
 
-config ARCH_DISCONTIGMEM_DEFAULT
-	def_bool y
-	depends on NUMA && X86_32
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
@@ -1621,7 +1617,7 @@ config ARCH_SPARSEMEM_ENABLE
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on X86_64
+	depends on X86_64 || (NUMA && X86_32)
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
-- 
2.7.4


-- 
Sincerely yours,
Mike.

