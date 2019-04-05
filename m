Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B726C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D006620989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDEWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:00:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50011 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:00:43 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCWt6-0005ik-O4; Sat, 06 Apr 2019 00:00:40 +0200
Date:   Sat, 6 Apr 2019 00:00:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 17/29] x86/exceptions: Disconnect IST index and stack
 order
In-Reply-To: <20190405215713.rv46kr5fhl3z3m4z@treble>
Message-ID: <alpine.DEB.2.21.1904060000260.1802@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150929.938480649@linutronix.de> <20190405215713.rv46kr5fhl3z3m4z@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019, Josh Poimboeuf wrote:

> On Fri, Apr 05, 2019 at 05:07:15PM +0200, Thomas Gleixner wrote:
> > +/*
> > + * The exception stack ordering in [cea_]exception_stacks
> > + */
> > +enum exception_stack_ordering {
> > +	ISTACK_DF,
> > +	ISTACK_NMI,
> > +	ISTACK_DB,
> > +	ISTACK_MCE,
> > +	N_EXCEPTION_STACKS
> > +};
> 
> While clever, it reads as "interrupt stack" to me.  ESTACK or IST_STACK
> would be infinitely better.

Fair enough.
