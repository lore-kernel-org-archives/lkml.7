Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DDAC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E5D2229B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfGVIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:53:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfGVIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:53:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpU4h-0001w3-Ec; Mon, 22 Jul 2019 10:53:39 +0200
Date:   Mon, 22 Jul 2019 10:53:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@kernel.org
Subject: Re: [PATCH] x86/irq/64: fix the missing update on comment
In-Reply-To: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1907221051580.1782@nanos.tec.linutronix.de>
References: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
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

Cao,

On Fri, 19 Jul 2019, Cao jin wrote:

> Commit e6401c130931 ("x86/irq/64: Split the IRQ stack into its own pages")
> missed to update one piece of comment as it did to its peer in Xen, which
> will confuse people who still need to read comment.
> 
> A bonus fix to identation in ZO's linker script: spaces -> tab.

Please don't add 'bonus' changes. A patch which fixes a stale comment has
nothing to do with a indentation change in an unrelated file.

Thanks,

	tglx

