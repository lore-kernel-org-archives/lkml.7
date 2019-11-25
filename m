Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3473C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E1E20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKYKq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:46:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfKYKq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:46:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3cx0Bx1z9sQw; Mon, 25 Nov 2019 21:46:56 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 46ddcb3950a28c0df4815e8dbb8d4b91d5d9f22d
In-Reply-To: <4f88d7e6fda53b5f80a71040ab400242f6c8cb93.1566400889.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: tell if a bad page fault on data is read or write.
Message-Id: <47M3cx0Bx1z9sQw@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:46:56 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 15:21:55 UTC, Christophe Leroy wrote:
> DSISR has a bit to tell if the fault is due to a read or a write.
> 
> Display it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/46ddcb3950a28c0df4815e8dbb8d4b91d5d9f22d

cheers
