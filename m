Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E7EC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 02:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650BC2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 02:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLACej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 21:34:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:20521 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfLACej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 21:34:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2019 18:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,263,1571727600"; 
   d="scan'208";a="204116806"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2019 18:34:35 -0800
Date:   Sun, 1 Dec 2019 10:41:50 +0800
From:   Philip Li <philip.li@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: {standard input}:211: Error: operand out of
 range (128 is not between -128 and 127)
Message-ID: <20191201024150.GA24494@intel.com>
References: <201912010830.w1kwu40L%lkp@intel.com>
 <20191201012423.GK20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201012423.GK20752@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 05:24:23PM -0800, Matthew Wilcox wrote:
> On Sun, Dec 01, 2019 at 08:53:31AM +0800, kbuild test robot wrote:
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   32ef9553635ab1236c33951a8bd9b5af1c3b1646
> > commit: 5a74ac4c4a97bd8b7dba054304d598e2a882fea6 idr: Fix idr_get_next_ul race with idr_remove
> > date:   4 weeks ago
> > config: arc-defconfig (attached as .config)
> > compiler: arc-elf-gcc (GCC) 7.4.0
> 
> Still don't care.  You need to drop this broken compiler from your test cases.
sorry for this, we will blacklist it. And we will upgrade compiler to gcc-7.5
firstly to see whether there're bug fixes at compiler side.


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
