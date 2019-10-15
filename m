Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433DECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DC220873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfJOB1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:27:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbfJOB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:27:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78678B186;
        Tue, 15 Oct 2019 01:27:22 +0000 (UTC)
Date:   Mon, 14 Oct 2019 18:26:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
Message-ID: <20191015012604.eonteqarhvgmrzuc@linux-p48b>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-7-manfred@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019, Manfred Spraul wrote:
>Invalid would be:
>	smp_mb__before_atomic();
>	atomic_set();

fyi I've caught a couple of naughty users:

   drivers/crypto/cavium/nitrox/nitrox_main.c
   drivers/gpu/drm/msm/adreno/a5xx_preempt.c

Thanks,
Davidlohr
