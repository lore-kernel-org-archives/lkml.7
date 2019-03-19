Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7F8213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCSVqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:46:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54224 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSVqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:46:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BAF3A146A0A18;
        Tue, 19 Mar 2019 14:46:48 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:46:48 -0700 (PDT)
Message-Id: <20190319.144648.2244362851338248970.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, labbott@redhat.com, fw@deneb.enyo.de,
        pburton@wavecomp.com, deepa.kernel@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190319165123.3967889-1-arnd@arndb.de>
References: <20190319165123.3967889-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Mar 2019 14:46:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Mar 2019 17:51:09 +0100

> Florian Weimer points out an issue with including linux/posix_types.h
> from arbitrary other headers: if an application has defined a macro
> named 'fds_bits', it may stop compiling after a change in the kernel
> headers. Since fds_bits is a non-reserved identifier in C, that is
> considered a bug in the kernel headers.
> 
> The structure definition does not really seem to be helpful here,
> as the kernel no longer provides macros to manipulate it.
 ...
> Fixes: a623a7a1a567 ("y2038: fix socket.h header inclusion")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
