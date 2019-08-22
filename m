Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CBAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34DF2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfHVNJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:15 -0400
Received: from ozlabs.org ([203.11.71.1]:47655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388965AbfHVNJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGt49BMz9sPW; Thu, 22 Aug 2019 23:09:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7ab0b7cb8951d4095d73e203759b74d41916e455
In-Reply-To: <c6cea38f90480268d439ca44a645647e260fff09.1565941808.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Add warning on misaligned copy_page() or clear_page()
Message-Id: <46DlGt49BMz9sPW@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:10 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-16 at 07:52:20 UTC, Christophe Leroy wrote:
> copy_page() and clear_page() expect page aligned destination, and
> use dcbz instruction to clear entire cache lines based on the
> assumption that the destination is cache aligned.
> 
> As shown during analysis of a bug in BTRFS filesystem, a misaligned
> copy_page() can create bugs that are difficult to locate (see Link).
> 
> Add an explicit WARNING when copy_page() or clear_page() are called
> with misaligned destination.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Erhard F. <erhard_f@mailbox.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204371

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7ab0b7cb8951d4095d73e203759b74d41916e455

cheers
