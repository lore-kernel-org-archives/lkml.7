Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D38C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624A62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfCLWuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:50:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:17934 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfCLWuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:50:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 15:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,472,1544515200"; 
   d="scan'208";a="212101963"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2019 15:50:36 -0700
Message-ID: <4c72a04bb87e341ea7c747d509f42136a99a0716.camel@linux.intel.com>
Subject: Re: [mm PATCH v6 6/7] mm: Add reserved flag setting to
 set_page_links
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        davem@davemloft.net, pavel.tatashin@microsoft.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz,
        khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Date:   Tue, 12 Mar 2019 15:50:36 -0700
In-Reply-To: <20190312150727.cb15cbc323a742e520b9a881@linux-foundation.org>
References: <154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
         <154361479877.7497.2824031260670152276.stgit@ahduyck-desk1.amr.corp.intel.com>
         <20181205172225.GT1286@dhcp22.suse.cz>
         <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
         <20181205204247.GY1286@dhcp22.suse.cz>
         <20190312150727.cb15cbc323a742e520b9a881@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 15:07 -0700, Andrew Morton wrote:
> On Wed, 5 Dec 2018 21:42:47 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > I got your explanation. However Andrew had already applied the patches
> > > and I had some outstanding issues in them that needed to be addressed.
> > > So I thought it best to send out this set of patches with those fixes
> > > before the code in mm became too stale. I am still working on what to
> > > do about the Reserved bit, and plan to submit it as a follow-up set.
> > > From my experience Andrew can drop patches between different versions of
> > the patchset. Things can change a lot while they are in mmotm and under
> > the discussion.
> 
> It's been a while and everyone has forgotten everything, so I'll drop
> this version of the patchset.
> 

As far as getting to the reserved bit I probably won't have the time in
the near future. If I were to resubmit the first 4 patches as a
standalone patch set would that be acceptable, or would they be held up
as well until the reserved bit issues is addressed?

- Alex



