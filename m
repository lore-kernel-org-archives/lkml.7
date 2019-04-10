Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE7C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4490520874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfDJCST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:18:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:15456 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDJCSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:18:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 19:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="160270110"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2019 19:18:16 -0700
Date:   Wed, 10 Apr 2019 10:21:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
Message-ID: <20190410022139.7nwgr4mxseljyy52@shbuild888>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <20190402021419.GA617@jagdpanzerIV>
 <20190402022840.et7sbiamxeutbw2q@shbuild888>
 <20190402022900.GA2219@jagdpanzerIV>
 <20190409134109.ounidzwphouqr3w2@pathway.suse.cz>
 <20190410014705.GB26212@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410014705.GB26212@jagdpanzerIV>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr and Sergey,

On Wed, Apr 10, 2019 at 10:47:05AM +0900, Sergey Senozhatsky wrote:
> On (04/09/19 15:41), Petr Mladek wrote:
> > I suggest to merge the two patches into one. It will
> > still be rather small and easier to review.
> 
> Agreed, was going to suggest the same.

Ok, will merge. Splitting to 2 patches did confuse people.

Thanks,
Feng
