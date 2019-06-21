Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5129AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BCC20652
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFUCJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 22:09:28 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:46664 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUCJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 22:09:27 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990396AbfFUCJX1JN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Fri, 21 Jun 2019 04:09:23 +0200
Date:   Fri, 21 Jun 2019 03:09:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FDDI: defza: Include linux/io-64-nonatomic-lo-hi.h
In-Reply-To: <20190620221224.27352-1-paul.burton@mips.com>
Message-ID: <alpine.LFD.2.21.1906210307020.21654@eddie.linux-mips.org>
References: <20190620221224.27352-1-paul.burton@mips.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019, Paul Burton wrote:

> Maciej, David, if you'd be happy to provide an Ack so that I can take
> this through the mips-next branch that would be great; that'll let me
> apply it prior to the asm/io.h change.

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 Sure, thanks for doing this work.

  Maciej
