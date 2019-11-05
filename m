Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D95C5DF63
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A307721928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbfKEQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:55:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:22346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390060AbfKEQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:55:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 08:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="225073629"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2019 08:55:17 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 197DB300884; Tue,  5 Nov 2019 08:55:17 -0800 (PST)
Date:   Tue, 5 Nov 2019 08:55:17 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, kbuild-all@lists.01.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Add trace points to (nearly) all vectors
Message-ID: <20191105165517.GA373029@tassilo.jf.intel.com>
References: <20191030195619.22244-1-andi@firstfloor.org>
 <201911020947.N041g9eA%lkp@intel.com>
 <20191105014439.GB25308@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105014439.GB25308@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:44:39PM -0800, Andi Kleen wrote:
> On Sat, Nov 02, 2019 at 09:24:50AM +0800, kbuild test robot wrote:
> > Hi Andi,
> > 
> > Thank you for the patch! Yet something to improve:
> 
> I cannot reproduce this.
> 
> And the file clearly has an include for the trace file, so I can't see what
> could be wrong.
> 
> > 
> > [auto build test ERROR on tip/auto-latest]
> > [also build test ERROR on v5.4-rc5 next-20191031]
> 
> Also the config the bot sent doesn't even match next-20191031 nor tip/auto-latest

Never mind -- the config works with make ARCH=i386

Helps when you read the message completely :-)

-Andi
