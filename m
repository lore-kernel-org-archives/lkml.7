Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24815C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC665213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfCYBQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:16:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:38348 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfCYBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:16:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 18:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128323827"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2019 18:16:42 -0700
Date:   Mon, 25 Mar 2019 09:16:21 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 1/6] x86, mm: remove second argument of split_mem_range()
Message-ID: <20190325011621.GA3541@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
 <20190212021215.13247-2-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.1903241533140.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903241533140.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 03:38:24PM +0100, Thomas Gleixner wrote:
>Wei,
>
>On Tue, 12 Feb 2019, Wei Yang wrote:
>
>Vs. the subject line. 'x86, mm:' is not the proper prefix.
>
># git log path/to/file
>
>gives you usually a pretty good hint, i.e. in this case: 'x86/mm:'
>
>Also the sentence after the colon starts with an upper case letter. So the
>full subject would be:
>
> x86/mm: Remove ......
>

Ah, thanks for your comment! Will change this in next version.

>Other than that. This looks good.
>
>Thanks,
>
>	tglx

-- 
Wei Yang
Help you, Help me
