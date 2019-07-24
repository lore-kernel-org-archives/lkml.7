Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60211C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3537122ADF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfGXOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:00:56 -0400
Received: from ozlabs.org ([203.11.71.1]:45801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfGXOA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:00:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45txnx6zqPz9s3l;
        Thu, 25 Jul 2019 00:00:53 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian@brauner.io>,
        Arseny Solokha <asolokha@kb.kras.ru>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
In-Reply-To: <20190724093132.orflnhvyiff75yrd@brauner.io>
References: <20190722133701.g3w5g4crogqb7oi5@brauner.io> <87ftmwknr9.fsf@kb.kras.ru> <20190724093132.orflnhvyiff75yrd@brauner.io>
Date:   Thu, 25 Jul 2019 00:00:51 +1000
Message-ID: <87lfwn5y7g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:
> On Wed, Jul 24, 2019 at 12:25:14PM +0700, Arseny Solokha wrote:
>> Hi,
>> 
>> may I also ask to provide ppc_clone3 symbol also for 32-bit powerpc? Otherwise
>> Michael's patch breaks build for me:
>
> Makes sense. Michael, are you planning on picking this up? :)

Yes I obviously (I hope) am not going to merge a patch that breaks the
32-bit build :)

I'll send a v2.

cheers
