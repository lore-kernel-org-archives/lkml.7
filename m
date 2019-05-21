Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC314C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21FB21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FgSTNGfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfEURhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:37:06 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:37776 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbfEURhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1558460225;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=hc0/BUKgUjDfp5UyEzfAVwM6axcjh6mZxMvpraGYMr8=;
        b=FgSTNGfrqsrblnIl/lCTiPv3wlbz+X9x9z5hJXCDH1UaOVOWqa/dMcb4vkX0BxhK
        YeaQMGsZAZj1BeHhkHC79v+BSEfUb4EUB4DKL2alF9QDP1fFZ52gCHnuezf6LkqkjY7
        9sk+ILbNN+wpagdH+/bXQS7gYYj3wbqMpKGdz+Wk=
Date:   Tue, 21 May 2019 17:37:05 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        me@tobin.cc, vbabka@suse.cz, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: remove /proc/slab_allocators
In-Reply-To: <1558036661-17577-1-git-send-email-cai@lca.pw>
Message-ID: <0100016adb77d817-18d39284-976c-4cac-ad92-b46316534dbe-000000@email.amazonses.com>
References: <1558036661-17577-1-git-send-email-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.05.21-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019, Qian Cai wrote:

> It turned out that DEBUG_SLAB_LEAK is still broken even after recent
> recue efforts that when there is a large number of objects like
> kmemleak_object which is normal on a debug kernel,

Acked-by: Christoph Lameter <cl@linux.com>
