Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6328C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45E620740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfKYKq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:46:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfKYKq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:46:56 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3cv0snbz9sPj; Mon, 25 Nov 2019 21:46:54 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 43f003bb74b9b27da6e719cfc2f7630f5652665a
In-Reply-To: <c19a82b37677ace0eebb0dc8c2120373c29c8dd1.1566219503.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc: refactoring BUG/WARN macros
Message-Id: <47M3cv0snbz9sPj@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:46:54 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 13:06:30 UTC, Christophe Leroy wrote:
> BUG(), WARN() and friends are using a similar inline
> assembly to implement various traps with various flags.
> 
> Lets refactor via a new BUG_ENTRY() macro.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43f003bb74b9b27da6e719cfc2f7630f5652665a

cheers
