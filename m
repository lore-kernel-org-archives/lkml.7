Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F831C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E462147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfD3Orb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:47:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:34293 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3Orb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:47:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="144881740"
Received: from ruehl-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.47.22])
  by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2019 07:47:28 -0700
Date:   Tue, 30 Apr 2019 17:47:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmorris@namei.org
Subject: Re: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20190430144727.GA7901@linux.intel.com>
References: <20190416130740.7ff9e561@canb.auug.org.au>
 <20190416153608.GA11353@linux.intel.com>
 <CACdnJuvat4=kXD6NMnMw5E8M4KB_1nBP6Simi8gBUChdBs7eRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvat4=kXD6NMnMw5E8M4KB_1nBP6Simi8gBUChdBs7eRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:40:48PM -0700, Matthew Garrett wrote:
> On Tue, Apr 16, 2019 at 8:36 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > Matthew, looking at the code I guess the includes are in wrong order
> > i.e. early_ioremap.h should be included before tpm_eventlog.h. Do you
> > agree that this is the correct conclusion? I can do the update.
> 
> Yes, I believe that that's the correct fix.

I'll hold  up until the previous flush of patches is in
security/next-general (bug fixes for v5.1 changes).

/Jarkko
