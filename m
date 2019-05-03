Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995DFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7706F20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfECIFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:05:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfECIFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:05:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3EC0AD89;
        Fri,  3 May 2019 08:05:06 +0000 (UTC)
Subject: Re: [PATCH 24/24] osst: add a SPDX tag to osst.c
To:     Willem Riede <osst@riede.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chriosstoph Hellwig <hch@losst.de>
References: <20190501161417.32592-1-hch@lst.de>
 <20190501161417.32592-25-hch@lst.de>
 <70277444-5b5b-6e3c-5af3-c658a841b144@suse.de> <20190502125312.GA2560@lst.de>
 <10a8c8f5-879c-685f-f43c-d5af678b2187@suse.de>
 <CAKnBiiaSyW27tCqU4i6zStF3AoLPcndSL2gjz1b17LdoFddiiw@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c9a58611-13e2-8e13-b573-b504032c017c@suse.de>
Date:   Fri, 3 May 2019 10:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKnBiiaSyW27tCqU4i6zStF3AoLPcndSL2gjz1b17LdoFddiiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/19 9:55 PM, Willem Riede wrote:
> On Thu, May 2, 2019 at 7:19 AM Hannes Reinecke <hare@suse.de 
> <mailto:hare@suse.de>> wrote:
> 
>     On 5/2/19 2:53 PM, Christoph Hellwig wrote:
>      > On Thu, May 02, 2019 at 08:06:38AM +0200, Hannes Reinecke wrote:
>      >> On 5/1/19 6:14 PM, Christoph Hellwig wrote:
>      >>> osst.c is the only osst file missing licensing information.  Add a
>      >>> GPLv2 tag for the default kernel license.
>      >>>
>      >>> Signed-off-by: Chriosstoph Hellwig <hch@losst.de
>     <mailto:hch@losst.de>>
>      >
>      > FYI, my s/st/osst/ on the commit message message up my signoff, this
>      > should be:
>      >
>      > Signed-off-by: Christoph Hellwig <hch@lst.de <mailto:hch@lst.de>>
>      >
>     Maybe it's time to kill osst.c for good ...
> 
> 
> Yes. I've been thinking about doing just that. The devices it supports 
> are now thoroughly obsolete. The manufacturer has gone out of business. 
> All my test drives have broken down over time, so I can't even test any 
> changes any more.
> 
Just when I thought to reach out to you :-)

Thing is, we've done numerous changes to the 'st' driver in the course 
of the years, most of which seem to have avoided osst :-(

So what's your suggestion here?
Just drop it completely?
Or can we somehow fold the OnStream-specific things back into st.c?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
