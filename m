Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3218C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E5A20989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGBQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:49:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:52041 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBQtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:49:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x62Gmp8o023457;
        Tue, 2 Jul 2019 11:48:51 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x62Gmoa3023452;
        Tue, 2 Jul 2019 11:48:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 2 Jul 2019 11:48:50 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Replaces long number representation by BIT() macro
Message-ID: <20190702164850.GP18316@gate.crashing.org>
References: <20190613180227.29558-1-leonardo@linux.ibm.com> <87imskihvd.fsf@concordia.ellerman.id.au> <20190702161635.GO18316@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702161635.GO18316@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:16:35AM -0500, Segher Boessenkool wrote:
> On Wed, Jul 03, 2019 at 01:19:34AM +1000, Michael Ellerman wrote:
> > What we could do is switch to the `UL` macro from include/linux/const.h,
> > rather than using our own ASM_CONST.
> 
> You need gas 2.28 or later for that though.

Oh, but apparently I cannot read.  That macro should work fine.


Segher
