Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2EDC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108D2184D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfIBD3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:29:37 -0400
Received: from ozlabs.org ([203.11.71.1]:36435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbfIBD3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:29:36 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFv33Bqxz9sNk; Mon,  2 Sep 2019 13:29:35 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3bbd2343734e44de92238eea1a5cd3ad32a6baf0
In-Reply-To: <54f67bb7ac486c1350f2fa8905cd279f94b9dfb1.1566382841.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: set STACK_END_MAGIC earlier on the init_stack
Message-Id: <46MFv33Bqxz9sNk@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:29:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 10:20:51 UTC, Christophe Leroy wrote:
> Today, the STACK_END_MAGIC is set on init_stack in start_kernel().
> 
> To avoid a false 'Thread overran stack, or stack corrupted' message
> on early Oopses, setup STACK_END_MAGIC as soon as possible.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3bbd2343734e44de92238eea1a5cd3ad32a6baf0

cheers
