Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FB0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0520740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfKYKrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:47:14 -0500
Received: from ozlabs.org ([203.11.71.1]:34319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfKYKrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3d771tmz9sR1; Mon, 25 Nov 2019 21:47:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d538aadc2718a95bfd80095c66ea814824535b34
In-Reply-To: <b4f03a68ee8e68773c8973d74ec35f9c82c72871.1568295907.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@infradead.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] powerpc/ioremap: warn on early use of ioremap()
Message-Id: <47M3d771tmz9sR1@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 13:49:44 UTC, Christophe Leroy wrote:
> Powerpc now has EARLY_IOREMAP.
> 
> Next step is to convert all early users of ioremap() to
> early_ioremap().
> 
> Add a warning to help locate those users.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d538aadc2718a95bfd80095c66ea814824535b34

cheers
