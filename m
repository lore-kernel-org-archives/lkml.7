Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA7EC072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3457420C01
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfERLPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 07:15:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERLPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 07:15:03 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 455jHT6z5wz9s4Y; Sat, 18 May 2019 21:15:01 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 397d2300b08cdee052053e362018cdb6dd65eea2
X-Patchwork-Hint: ignore
In-Reply-To: <a4e5d99c5173797b7242652be99801a9bb5d68fc.1557406475.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix flush_hash_pages() on SMP
Message-Id: <455jHT6z5wz9s4Y@ozlabs.org>
Date:   Sat, 18 May 2019 21:15:01 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-09 at 12:59:38 UTC, Christophe Leroy wrote:
> flush_hash_pages() runs with data translation off, so current
> task_struct has to be accesssed using physical address.
> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Fixes: f7354ccac844 ("powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/397d2300b08cdee052053e362018cdb6

cheers
