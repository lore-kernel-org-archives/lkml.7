Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B274C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F122184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfDEPoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:44:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:24854 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEPoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:44:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 08:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="146892612"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2019 08:44:09 -0700
Date:   Fri, 5 Apr 2019 08:44:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 02/29] x86/dumpstack: Fix off-by-one errors in stack
 identification
Message-ID: <20190405154408.GA19359@linux.intel.com>
References: <20190405150658.237064784@linutronix.de>
 <20190405150928.596372581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405150928.596372581@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:07:00PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> The get_stack_info() function is off-by-one when checking whether an
> address is on a IRQ stack or a IST stack.  This prevents a overflowed IRQ
> or IST stack from being dumped properly.
> 
> [ tglx: Do the same for 32-bit ]
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
