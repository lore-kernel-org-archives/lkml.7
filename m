Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF4FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5133E20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfGHBT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:58 -0400
Received: from ozlabs.org ([203.11.71.1]:44575 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbfGHBTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hngB5B6kz9sP6; Mon,  8 Jul 2019 11:19:50 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 658829dfe75c49e879e0c4c9cbcd3bd1e4fbdcf5
In-Reply-To: <2b82a1562fc18d9cef80ad2481957ea2f30f9825.1493799907.git.geliangtang@gmail.com>
To:     Geliang Tang <geliangtang@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/cell: set no_llseek in spufs_cntl_fops
Message-Id: <45hngB5B6kz9sP6@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:50 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2017-05-06 at 15:37:20 UTC, Geliang Tang wrote:
> In spufs_cntl_fops, since we use nonseekable_open() to open, we
> should use no_llseek() to seek, not generic_file_llseek().
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/658829dfe75c49e879e0c4c9cbcd3bd1e4fbdcf5

cheers
