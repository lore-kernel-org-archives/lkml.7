Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD3CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DAB2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfDJMI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:08:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfDJMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:08:28 -0400
Received: from [147.83.201.128] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEC1h-0006u2-4B; Wed, 10 Apr 2019 14:08:25 +0200
Date:   Wed, 10 Apr 2019 14:08:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
In-Reply-To: <20190410110818.GA13904@lst.de>
Message-ID: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de> <20190410110818.GA13904@lst.de>
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

On Wed, 10 Apr 2019, Christoph Hellwig wrote:

> On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> > Replace the indirection through struct stack_trace with an invocation of
> > the storage array based interface.
> 
> This seems to be missing some context, at least stack_trace_save does
> not actually exist in mainline.
> 
> Please always send the whole series out to everyone on the To and Cc
> list, otherwise patch series are not reviewable.
 
Bah. People complain about overly broad cc-lists and the context is on
lkml. But sure, I just bounced it to you.

Thanks,

	tglx

