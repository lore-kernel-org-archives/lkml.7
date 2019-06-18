Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C636C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0292085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfFRPcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:32:02 -0400
Received: from ms.lwn.net ([45.79.88.28]:50818 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfFRPcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:32:01 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EFDC94FA;
        Tue, 18 Jun 2019 15:32:00 +0000 (UTC)
Date:   Tue, 18 Jun 2019 09:31:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/vm: hwpoison.rst: Fix quote formatting
Message-ID: <20190618093159.26352aed@lwn.net>
In-Reply-To: <20190618145605.21208-1-valentin.schneider@arm.com>
References: <20190618145605.21208-1-valentin.schneider@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:56:05 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> The asterisks prepended to the quoted text currently get translated to
> bullet points, which gets increasingly confusing the smaller your
> screen is (when viewing the sphinx output, that is).
> 
> Convert the whole quote to a literal block.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

That definitely seems worth fixing, and I can apply this.  But a few
things to ponder first...

 - If you convert it to a literal block, the asterisks can remain, making
   for a less intrusive patch.

 - I was wondering if we should just use a kernel-doc directive to pull
   the comment directly from the source, but investigation quickly showed
   that the "overview comment" doesn't actually exist in anything close to
   the quoted form.  See mm/memory-failure.c.

Given that, and things like references to support in "upcoming Intel
CPUs", I suspect that this document is pretty seriously out of date and
needs some more in-depth attention.  If you're playing in this area and
feel like it, updating the document for real would be much appreciated...:)

Thanks,

jon
