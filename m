Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF1C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C3B214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfDYIWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:22:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfDYIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:22:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P85qbN091457
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 04:22:47 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s37q0v2ne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 04:22:47 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Apr 2019 09:22:45 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 09:22:43 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3P8Mgcd46530680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 08:22:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0DCF11C052;
        Thu, 25 Apr 2019 08:22:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2F1B11C058;
        Thu, 25 Apr 2019 08:22:41 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.63])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Apr 2019 08:22:41 +0000 (GMT)
Date:   Thu, 25 Apr 2019 11:22:40 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/vm: add documentation of memory models
References: <1556101715-31966-1-git-send-email-rppt@linux.ibm.com>
 <a4def881-1df0-6835-4b9a-dc957c979683@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4def881-1df0-6835-4b9a-dc957c979683@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042508-0008-0000-0000-000002DF50E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042508-0009-0000-0000-0000224BA941
Message-Id: <20190425082239.GC10625@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Apr 24, 2019 at 06:08:46PM -0700, Randy Dunlap wrote:
> On 4/24/19 3:28 AM, Mike Rapoport wrote:
> > Describe what {FLAT,DISCONTIG,SPARSE}MEM are and how they manage to
> > maintain pfn <-> struct page correspondence.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  Documentation/vm/index.rst        |   1 +
> >  Documentation/vm/memory-model.rst | 171 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 172 insertions(+)
> >  create mode 100644 Documentation/vm/memory-model.rst
> > 
> 
> Hi Mike,
> I have a few minor edits below...

I kinda expected those ;-)

> > diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
> > new file mode 100644
> > index 0000000..914c52a
> > --- /dev/null
> > +++ b/Documentation/vm/memory-model.rst

...

> > +
> > +With FLATMEM, the conversion between a PFN and the `struct page` is
> > +straightforward: `PFN - ARCH_PFN_OFFSET` is an index to the
> > +`mem_map` array.
> > +
> > +The `ARCH_PFN_OFFSET` defines the first page frame number for
> > +systems that their physical memory does not start at 0.
> 
> s/that/when/ ?  Seems awkward as is.

Yeah, it is awkward. How about

The `ARCH_PFN_OFFSET` defines the first page frame number for
systems with physical memory starting at address different from 0.

> > +
> > +DISCONTIGMEM
> > +============
> > +
> 
> thanks.
> -- 
> ~Randy
> 

-- 
Sincerely yours,
Mike.

