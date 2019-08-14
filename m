Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE64C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4E82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfHNMjb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:39:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNMjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:39:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxsYh-0004TO-6K; Wed, 14 Aug 2019 14:39:19 +0200
Date:   Wed, 14 Aug 2019 14:39:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com
Subject: Re: [PATCH 2/9] sched: treewide: use is_kthread()
Message-ID: <20190814123918.4e4i6vffr4kif6dx@linutronix.de>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190814104131.20190-3-mark.rutland@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-14 11:41:24 [+0100], Mark Rutland wrote:
…
> Instances checking multiple PF_* flags at ocne are left as-is for now.

s@ocne@once@

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
