Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69044C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfCFLo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:44:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:55610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728438AbfCFLo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:44:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13F9DB12F;
        Wed,  6 Mar 2019 11:44:56 +0000 (UTC)
Date:   Wed, 6 Mar 2019 12:44:53 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Oliver <oohall@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
Message-ID: <20190306124453.126d36d8@naga.suse.cz>
In-Reply-To: <87k1hc8iqa.fsf@linux.ibm.com>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
        <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
        <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
        <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
        <87k1hc8iqa.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Mar 2019 14:47:33 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:  
> >>
> >> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> >> <aneesh.kumar@linux.ibm.com> wrote:  
 
> Also even if the user decided to not use THP, by
> echo "never" > transparent_hugepage/enabled , we should continue to map
> dax fault using huge page on platforms that can support huge pages.

Is this a good idea?

This knob is there for a reason. In some situations having huge pages
can severely impact performance of the system (due to host-guest
interaction or whatever) and the ability to really turn off all THP
would be important in those cases, right?

Thanks

Michal
