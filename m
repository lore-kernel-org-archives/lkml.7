Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C93C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D52229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGXMrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:47:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:47:23 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqGft-0007mY-GF; Wed, 24 Jul 2019 14:47:17 +0200
Date:   Wed, 24 Jul 2019 14:47:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <lkp@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, LKP <lkp@01.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, philip.li@intel.com
Subject: Re: a0d14b8909 ("x86/mm, tracing: Fix CR2 corruption"): Kernel panic
 - not syncing: No working init found. Try passing init= option to kernel.
 See Linux Documentation/admin-guide/init.rst for guidance.
In-Reply-To: <5d384f96.dD36t9B/8FDRT5y1%lkp@intel.com>
Message-ID: <alpine.DEB.2.21.1907241446150.1791@nanos.tec.linutronix.de>
References: <5d384f96.dD36t9B/8FDRT5y1%lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, kernel test robot wrote:

> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit a0d14b8909de55139b8702fe0c7e80b69763dcfb
> Author:     Peter Zijlstra <peterz@infradead.org>

Fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=b8f70953c1251d8b16276995816a95639f598e70

Thanks,

	tglx
