Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329C2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BA520679
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKOTMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:12:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:21836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:12:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 11:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="236177779"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2019 11:12:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2CD843010AB; Fri, 15 Nov 2019 11:12:00 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:12:00 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, markus.t.metzger@intel.com
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20191115191200.GD22747@tassilo.jf.intel.com>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 07:29:17PM +0100, Thomas Gleixner wrote:
> On Fri, 4 Oct 2019, Chang S. Bae wrote:
> > 
> > Updates from v8 [10]:
> > * Internalized the interrupt check in the helper functions (Andy L.)
> > * Simplified GS base helper functions (Tony L.)
> > * Changed the patch order to put the paranoid path changes before the
> >   context switch changes (Tony L.)
> > * Fixed typos (Randy D.) and massaged a few sentences in the documentation
> > * Massaged the FSGSBASE enablement message
> 
> That still lacks what Andy requested quite some time ago in the V8 thread:
> 
>      https://lore.kernel.org/lkml/034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org/
> 
>   "I also think that, before this series can have my ack, it needs an 
>    actual gdb maintainer to chime in, publicly, and state that they have 
>    thought about and tested the ABI changes and that gdb still works on 
>    patched kernels with and without FSGSBASE enabled.  I realize that there 
>    were all kinds of discussions, but they were all quite theoretical, and 
>    I think that the actual patches need to be considered by people who 
>    understand the concerns.  Specific test cases would be nice, too."
> 
> What's the state of this?

Adding Markus.

-Andi
