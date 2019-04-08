Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B70C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7420880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDHUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:03:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:03:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hDaUN-0007Ke-GY; Mon, 08 Apr 2019 22:03:31 +0200
Date:   Mon, 8 Apr 2019 22:03:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 19/27] x86/fpu: Update xstate's PKRU value on write_pkru()
Message-ID: <20190408200331.wvvt4izcasmotkp6@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-20-bigeasy@linutronix.de>
 <a824d713-a9b1-fa84-4826-be8d980d71e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a824d713-a9b1-fa84-4826-be8d980d71e4@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-08 11:14:28 [-0700], Dave Hansen wrote:
> On 4/3/19 9:41 AM, Sebastian Andrzej Siewior wrote:
> > During the context switch the xstate is loaded which also includes the
> > PKRU value.
> > If xstate is restored on return to userland it is required that the
> > PKRU value in xstate is the same as the one in the CPU.
> 
> All of the protection keys bits in here look ok to me.  Thanks for the
> sustained work to get all those into shape.  I know it's a special
> snowflake.

> Although I paid much closer attention to the PK bits, feel free to add:
> 
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> 
> for the series.

Thank you.

Sebastian
