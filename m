Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F3217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfEUQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:00:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728306AbfEUQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:00:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LFqRpq057714
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:00:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2smk73m1vf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:00:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 21 May 2019 17:00:46 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 17:00:44 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4LG0hix18546822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 16:00:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44A96A4068;
        Tue, 21 May 2019 16:00:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A727BA4066;
        Tue, 21 May 2019 16:00:42 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.239])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 May 2019 16:00:42 +0000 (GMT)
Date:   Tue, 21 May 2019 19:00:40 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: reorder memory-hotplug documentation
References: <1557822213-19058-1-git-send-email-rppt@linux.ibm.com>
 <43092504-a95f-374d-f3db-b961dd8ac428@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43092504-a95f-374d-f3db-b961dd8ac428@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19052116-0028-0000-0000-000003700856
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052116-0029-0000-0000-0000242FB33F
Message-Id: <20190521160040.GE24470@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:41:50PM +0200, David Hildenbrand wrote:
> On 14.05.19 10:23, Mike Rapoport wrote:
> > The "Locking Internals" section of the memory-hotplug documentation is
> > duplicated in admin-guide and core-api. Drop the admin-guide copy as
> > locking internals does not belong there.
> > 
> > While on it, move the "Future Work" section to the core-api part.
> 
> Looks sane, but the future work part is really outdated, can we remove
> this completely?
> 
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> > +
> > +Future Work
> > +===========
> > +
> > +  - allowing memory hot-add to ZONE_MOVABLE. maybe we need some switch like
> > +    sysctl or new control file.
> 
> ... that already works if I am not completely missing the point here
> 
> > +  - showing memory block and physical device relationship.
> 
> ... that is available for s390x only AFAIK
> 
> > +  - test and make it better memory offlining.
> 
> ... no big news ;)
> 
> > +  - support HugeTLB page migration and offlining.
> 
> ... I remember that Oscar was doing something in that area, Oscar?
> 
> > +  - memmap removing at memory offline.
> 
> ... no, we don't want this. However, we should properly clean up zone
> information when offlining
> 
> > +  - physical remove memory.
> 
> ... I don't even understand what that means.
> 
> 
> I'd vote for removing the future work part, this is pretty outdated.
 
Frankly, I haven't looked at the details, just simply moved the text over.
I don't mind sending another mechanical patch that removes the future work
part.

But it would be far better if somebody who's actively working on memory
hotplug would replace it with a description how this actually works ;-)
 
> -- 
> 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

