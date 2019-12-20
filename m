Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4470BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2066A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLTUwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:52:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:62096 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfLTUwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:52:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 12:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,337,1571727600"; 
   d="scan'208";a="222558285"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 12:52:01 -0800
Message-ID: <8cb182b9b4fc3fa0d781c48af0a8aae1a825cd6e.camel@intel.com>
Subject: Re: [PATCH v2 2/3] x86/fpu/xstate: Make
 xfeature_is_supervisor()/xfeature_is_user() return bool
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 20 Dec 2019 12:33:16 -0800
In-Reply-To: <20191220201925.iqmvcnl7zywumv73@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
         <20191212210855.19260-3-yu-cheng.yu@intel.com>
         <20191220201925.iqmvcnl7zywumv73@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 21:19 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-12 13:08:54 [-0800], Yu-cheng Yu wrote:
> > In the previous patch, xfeature_is_supervisor()'s description is revised,
> > and since xfeature_is_supervisor()/xfeature_is_user() are used only in
> > boolean context, make both return bool.
> > 
> > Suggested-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

