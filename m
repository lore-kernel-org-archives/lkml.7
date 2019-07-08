Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342CB204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGHBTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfGHBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfp1QQwz9sNj; Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7f9c929a7ff203eae60b4225bb6824c3eb31796c
In-Reply-To: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556865423.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] powerpc: Move PPC_HA() PPC_HI() and PPC_LO() to ppc-opcode.h
Message-Id: <45hnfp1QQwz9sNj@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-03 at 06:40:15 UTC, Christophe Leroy wrote:
> PPC_HA() PPC_HI() and PPC_LO() macros are nice macros. Move them
> from module64.c to ppc-opcode.h in order to use them in other places.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7f9c929a7ff203eae60b4225bb6824c3eb31796c

cheers
