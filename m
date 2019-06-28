Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B9DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C10208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfF1PLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:11:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:35124 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1PLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:11:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 121F22B4;
        Fri, 28 Jun 2019 15:11:03 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:11:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only
 _bh, not necessarily _irq
Message-ID: <20190628091101.5f4d35e3@lwn.net>
In-Reply-To: <20190627210147.19510-1-c0d1n61at3@gmail.com>
References: <20190627210147.19510-1-c0d1n61at3@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 16:01:47 -0500
Jiunn Chang <c0d1n61at3@gmail.com> wrote:

> The UP.rst file calls for locks acquired within RCU callback functions
> to use _irq variants (spin_lock_irqsave() or similar), which does work,
> but can be overkill.  This commit therefore instead calls for _bh variants
> (spin_lock_bh() or similar), while noting that _irq does work.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---
>  Documentation/RCU/UP.rst | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

jon
