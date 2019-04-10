Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2246DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED486217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbfDJMZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfDJMZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:25:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C852083E;
        Wed, 10 Apr 2019 12:25:49 +0000 (UTC)
Date:   Wed, 10 Apr 2019 08:25:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190410082548.04c2e0aa@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
References: <20190410102754.387743324@linutronix.de>
        <20190410103646.130022106@linutronix.de>
        <20190410110818.GA13904@lst.de>
        <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 14:08:19 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 10 Apr 2019, Christoph Hellwig wrote:
> > 
> > Please always send the whole series out to everyone on the To and Cc
> > list, otherwise patch series are not reviewable.  
>  
> Bah. People complain about overly broad cc-lists and the context is on
> lkml. But sure, I just bounced it to you.
> 

What I think is the best in between is to have the cover letter sent to
everyone in the patch series, and then individual patches sent to those
that need to know. git sendmail does this but quilt sendmail does
not :-(   I've been looking at fixing quilt to do the same.

-- Steve
