Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0348AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72C420693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfGHBTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbfGHBTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:51 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hngB2dh1z9sNx; Mon,  8 Jul 2019 11:19:48 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c197922f0a8072d286dff8001f8ad0d4b95ec1dd
In-Reply-To: <38870b7604726c87e468f365ebe9236994c33f29.1482203132.git.geliangtang@gmail.com>
To:     Geliang Tang <geliangtang@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf/24x7: use rb_entry
Message-Id: <45hngB2dh1z9sNx@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:48 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2016-12-20 at 14:02:17 UTC, Geliang Tang wrote:
> To make the code clearer, use rb_entry() instead of container_of() to
> deal with rbtree.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c197922f0a8072d286dff8001f8ad0d4b95ec1dd

cheers
