Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D01C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E13E208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfFQXIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:08:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfFQXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:08:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36CDE151BDB40;
        Mon, 17 Jun 2019 16:08:50 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:08:47 -0700 (PDT)
Message-Id: <20190617.160847.1537731072625436124.davem@davemloft.net>
To:     linux@rasmusvillemoes.dk
Cc:     mingo@kernel.org, akpm@linux-foundation.org, jbaron@akamai.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 2/8] linux/net.h: use unique identifier for each
 struct _ddebug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190617222034.10799-3-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
        <20190617222034.10799-3-linux@rasmusvillemoes.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Jun 2019 16:08:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Tue, 18 Jun 2019 00:20:28 +0200

> Changes on x86-64 later in this series require that all struct _ddebug
> descriptors in a translation unit uses distinct identifiers. Realize
> that for net_dbg_ratelimited by generating such an identifier via
> __UNIQUE_ID and pass that to an extra level of macros.
> 
> No functional change.
> 
> Cc: netdev@vger.kernel.org
> Acked-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: David S. Miller <davem@davemloft.net>
