Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F553C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4FA20672
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLBXwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:52:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:7499 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfLBXwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:52:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 15:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="360992449"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2019 15:52:21 -0800
Date:   Mon, 2 Dec 2019 16:04:14 -0800
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
Message-ID: <20191203000413.GD220960@romley-ivt3.sc.intel.com>
References: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
 <1574901584-212957-2-git-send-email-fenghua.yu@intel.com>
 <20191128072338.GA17745@zn.tnic>
 <20191202185334.GA220960@romley-ivt3.sc.intel.com>
 <20191202230642.GD32696@zn.tnic>
 <20191202234244.GC220960@romley-ivt3.sc.intel.com>
 <20191202234927.GE32696@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202234927.GE32696@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 12:49:27AM +0100, Borislav Petkov wrote:
> On Mon, Dec 02, 2019 at 03:42:44PM -0800, Fenghua Yu wrote:
> > Should I send v9 patch set with only the Co-developed-by changes?
> 
> You can wait for other people's review first. And since you sent them
> during the merge window, you probably should wait longer, since people
> are busy with fixing fallout from the current stuff going upstream and
> not reviewing anything new.

Ok.

Thanks.

-Fenghua
