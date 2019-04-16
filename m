Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D063C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B120872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfDPPgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:36:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:41553 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDPPgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:36:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 08:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="292044699"
Received: from cboylan-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.85.237])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 08:36:29 -0700
Date:   Tue, 16 Apr 2019 18:36:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Garrett <mjg59@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20190416153608.GA11353@linux.intel.com>
References: <20190416130740.7ff9e561@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416130740.7ff9e561@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:07:40PM +1000, Stephen Rothwell wrote:
> Hi Jarkko,
> 
> After merging the tpmdd tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

Matthew, looking at the code I guess the includes are in wrong order
i.e. early_ioremap.h should be included before tpm_eventlog.h. Do you
agree that this is the correct conclusion? I can do the update.

Just as a temporary measure I removed the commits from my next branch.

/Jarkko
