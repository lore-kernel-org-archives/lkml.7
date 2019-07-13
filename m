Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7DFC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA52083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfGMOAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:00:05 -0400
Received: from bran.ispras.ru ([83.149.199.196]:27345 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfGMOAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:00:05 -0400
Received: from [10.10.3.112] (starling.intra.ispras.ru [10.10.3.112])
        by smtp.ispras.ru (Postfix) with ESMTP id 91207201D0;
        Sat, 13 Jul 2019 17:00:02 +0300 (MSK)
Subject: Re: [PATCH] proc: revert /proc/*/cmdline rewrite
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     oleg@redhat.com, mkubecek@suse.cz, torvalds@linux-foundation.org,
        shasta@toxcorp.com, linux-kernel@vger.kernel.org,
        security@kernel.org
References: <20190713072855.GB23167@avx2> <20190713073209.GC23167@avx2>
From:   Alexey Izbyshev <izbyshev@ispras.ru>
Message-ID: <5a5e6914-6450-319d-0d57-5098913ad47c@ispras.ru>
Date:   Sat, 13 Jul 2019 17:00:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190713073209.GC23167@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/19 10:32 AM, Alexey Dobriyan wrote:
> /proc/*/cmdline continues to cause problems:
> 
> 	https://lkml.org/lkml/2019/4/5/825
> 	Subject get_mm_cmdline and userspace (Perl) changing argv0
> 
> 	https://marc.info/?l=linux-kernel&m=156294831308786&w=4
> 	[PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
> 
> This patch reverts implementation to the last known good state.

I confirm that this revert fixes both issues above on my system (x86_64).

Alexey
