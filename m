Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15BB20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfGHBTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:52 -0400
Received: from ozlabs.org ([203.11.71.1]:48771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfGHBTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hng72Df7z9sNs; Mon,  8 Jul 2019 11:19:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4f44e8aeaf1937d9148dfcc4c028cd8aff27902e
In-Reply-To: <1562169853-12593-1-git-send-email-info@metux.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     alistair@popple.id.au, kvm-ppc@vger.kernel.org, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] arch: powerpc: Kconfig: pedantic formatting
Message-Id: <45hng72Df7z9sNs@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 16:04:13 UTC, "Enrico Weigelt, metux IT consult" wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Also convert "---help---" as requested on lkml.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f44e8aeaf1937d9148dfcc4c028cd8aff27902e

cheers
