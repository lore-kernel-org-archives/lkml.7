Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327ACC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCE820717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLBSln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:41:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:43443 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfLBSlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:41:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 10:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="384989972"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2019 10:41:41 -0800
Date:   Mon, 2 Dec 2019 10:53:35 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Andre Przywara <Andre.Przywara@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v8 01/13] selftests/resctrl: Add README for resctrl tests
Message-ID: <20191202185334.GA220960@romley-ivt3.sc.intel.com>
References: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
 <1574901584-212957-2-git-send-email-fenghua.yu@intel.com>
 <20191128072338.GA17745@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128072338.GA17745@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:23:38AM +0100, Borislav Petkov wrote:
> On Wed, Nov 27, 2019 at 04:39:32PM -0800, Fenghua Yu wrote:
> > resctrl tests will be implemented. README is added for the tool first.
> > 
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> What does this SOB chain mean?
> 
> Same question for patches 2,3,4,5,6,7,8,9,13.
> 
> So it seems you wanna say that Babu has contributed somehow but it is
> not clear what/how.

Babu's major contributions are in v5 where he virtually touched every
patch. He sent out v5 and put Signed-off-by: Babu Moger in each patch:
https://lore.kernel.org/patchwork/cover/1033532/

That's why I keep his SOB in v6-v8 in each patch.

Thanks.

-Fenghua

