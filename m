Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE34218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfDXLvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:51:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbfDXLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:51:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OBohKQ153548
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:51:35 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2n2t730c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:51:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 24 Apr 2019 12:51:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 12:51:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OBpS6P52166882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 11:51:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFAB642041;
        Wed, 24 Apr 2019 11:51:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BF134204F;
        Wed, 24 Apr 2019 11:51:28 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Apr 2019 11:51:28 +0000 (GMT)
Date:   Wed, 24 Apr 2019 14:51:26 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
References: <20190423132100.GB7132@redhat.com>
 <cover.1555938375.git.mchehab+samsung@kernel.org>
 <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
 <20190423083135.GA11158@hirez.programming.kicks-ass.net>
 <20190423125519.GA7104@redhat.com>
 <20190423130132.GT4038@hirez.programming.kicks-ass.net>
 <20704.1556031146@warthog.procyon.org.uk>
 <20190423105415.3a69a0cb@lwn.net>
 <20190423172641.612012c8@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423172641.612012c8@coco.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042411-0016-0000-0000-00000273003B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042411-0017-0000-0000-000032CF7194
Message-Id: <20190424115126.GC6278@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 05:26:41PM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 23 Apr 2019 10:54:15 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Tue, 23 Apr 2019 15:52:26 +0100
> > David Howells <dhowells@redhat.com> wrote:
> > 
> > Suggestions / patches on how to improve things for *all* users of the
> > docs are certainly welcome!
> > 
> > I am, incidentally, toying with the idea of trying to put together a
> > documentation microconf at the Linux Plumbers Conference this year.  If
> > anybody out there thinks that's a good idea and would like to
> > participate, please let me know.
> 
> If you add a microconf to LPC, I'm in. 

+1
 
> IMO, we made big advances with documentation, but there's a lot more
> to be done. Having a microconf to discuss those things may help us
> to bring new ideas about how to keep improving it.

The most difficult part, IMHO, is to convince people to document things ;-)
 
> Thanks,
> Mauro
> 

-- 
Sincerely yours,
Mike.

