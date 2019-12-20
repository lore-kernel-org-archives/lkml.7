Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DF520866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTUT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:19:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:19:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iiOk9-00089K-FK; Fri, 20 Dec 2019 21:19:25 +0100
Date:   Fri, 20 Dec 2019 21:19:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
Subject: Re: [PATCH v2 2/3] x86/fpu/xstate: Make
 xfeature_is_supervisor()/xfeature_is_user() return bool
Message-ID: <20191220201925.iqmvcnl7zywumv73@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
 <20191212210855.19260-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212210855.19260-3-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-12 13:08:54 [-0800], Yu-cheng Yu wrote:
> In the previous patch, xfeature_is_supervisor()'s description is revised,
> and since xfeature_is_supervisor()/xfeature_is_user() are used only in
> boolean context, make both return bool.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
