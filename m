Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C8BC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 06:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF3F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 06:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfDUGjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 02:39:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbfDUGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 02:39:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3L6XUDd057562
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 02:39:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s0gqeuwh0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 02:39:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 21 Apr 2019 07:39:06 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 21 Apr 2019 07:39:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3L6d2FV52625588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Apr 2019 06:39:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35FB952052;
        Sun, 21 Apr 2019 06:39:02 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6B7BA52050;
        Sun, 21 Apr 2019 06:39:01 +0000 (GMT)
Date:   Sun, 21 Apr 2019 09:38:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419140521.GI7751@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042106-0016-0000-0000-00000271078B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042106-0017-0000-0000-000032CD6817
Message-Id: <20190421063859.GA19926@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=463 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904210050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> > DISCONTIG is essentially deprecated and even parisc plans to move to
> > SPARSEMEM so there is no need to be fancy, this patch simply disables
> > watermark boosting by default on DISCONTIGMEM.
> 
> I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> scenarios.  Grepping the arch/ directories shows:
> 
> alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> arc (for supporting more than 1GB of memory)
> ia64 (looks complicated ...)
> m68k (for multiple chunks of memory)
> mips (does support NUMA but also non-NUMA)
> parisc (both NUMA and non-NUMA)

i386 NUMA as well
 
> I'm not sure that these architecture maintainers even know that DISCONTIGMEM
> is deprecated.  Adding linux-arch to the cc.
> 

-- 
Sincerely yours,
Mike.

