Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE9C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E1F2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437967AbfITJ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:59:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:55575 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405821AbfITJ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:59:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2019 02:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,528,1559545200"; 
   d="scan'208";a="178330120"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2019 02:59:14 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iBFh3-0006XH-2T; Fri, 20 Sep 2019 12:59:13 +0300
Date:   Fri, 20 Sep 2019 12:59:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Kristian Klausen <kristian@klausen.dk>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/asus-wmi.c:464: undefined reference to
 `battery_hook_unregister'
Message-ID: <20190920095913.GF2680@smile.fi.intel.com>
References: <201909201138.uyiNM7oj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909201138.uyiNM7oj%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:23:43AM +0800, kbuild test robot wrote:
> Hi Kristian,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   574cc4539762561d96b456dbc0544d8898bd4c6e
> commit: 7973353e92ee1e7ca3b2eb361a4b7cb66c92abee platform/x86: asus-wmi: Refactor charge threshold to use the battery hooking API
> date:   10 days ago
> config: x86_64-randconfig-e001-201937 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         git checkout 7973353e92ee1e7ca3b2eb361a4b7cb66c92abee
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

The fix is on its way to linux-next followed by new PR to Linus within couple
of days.

-- 
With Best Regards,
Andy Shevchenko


