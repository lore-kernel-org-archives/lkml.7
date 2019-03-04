Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08058C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB0020842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCDAsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:48:09 -0500
Received: from ozlabs.org ([203.11.71.1]:49233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfCDAsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:48:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44CLwk4pdDz9s6w; Mon,  4 Mar 2019 11:48:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6b1200facc051a3e487a52cbabd745f7c8f4e9f8
X-Patchwork-Hint: ignore
In-Reply-To: <1546441324-19774-2-git-send-email-firoz.khan@linaro.org>
To:     Firoz Khan <firoz.khan@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org, deepa.kernel@gmail.com
Subject: Re: [1/2] powerpc: remove nargs from __SYSCALL
Message-Id: <44CLwk4pdDz9s6w@ozlabs.org>
Date:   Mon,  4 Mar 2019 11:48:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 15:02:03 UTC, Firoz Khan wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the
> system call.
> 
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will
> unifies the implementation with some other architetures
> too.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b1200facc051a3e487a52cbabd745f7

cheers
