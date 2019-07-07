Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D2C48BDC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B832082F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfGGNPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:15:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfGGNPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:15:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hTbV4SGMz9s4Y;
        Sun,  7 Jul 2019 23:15:34 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Replaces long number representation by BIT() macro
In-Reply-To: <20190702164850.GP18316@gate.crashing.org>
References: <20190613180227.29558-1-leonardo@linux.ibm.com> <87imskihvd.fsf@concordia.ellerman.id.au> <20190702161635.GO18316@gate.crashing.org> <20190702164850.GP18316@gate.crashing.org>
Date:   Sun, 07 Jul 2019 23:15:34 +1000
Message-ID: <87d0imhtop.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Tue, Jul 02, 2019 at 11:16:35AM -0500, Segher Boessenkool wrote:
>> On Wed, Jul 03, 2019 at 01:19:34AM +1000, Michael Ellerman wrote:
>> > What we could do is switch to the `UL` macro from include/linux/const.h,
>> > rather than using our own ASM_CONST.
>> 
>> You need gas 2.28 or later for that though.
>
> Oh, but apparently I cannot read.  That macro should work fine.

:)

Yeah one day we'll be able to drop them entirely, but not yet.

The official minimum is 2.20:
  https://www.kernel.org/doc/html/latest/process/changes.html


But my "old" toolchain is binutils 2.22, so that's effectively the
minimum for anything I test. I'm not sure many people are actually
testing with 2.20.

cheers
