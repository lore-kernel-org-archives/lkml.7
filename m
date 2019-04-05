Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51892C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470321855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDEV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDEV5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:57:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45FEA3099F9F;
        Fri,  5 Apr 2019 21:57:16 +0000 (UTC)
Received: from treble (ovpn-124-124.rdu2.redhat.com [10.10.124.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5221660143;
        Fri,  5 Apr 2019 21:57:15 +0000 (UTC)
Date:   Fri, 5 Apr 2019 16:57:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 17/29] x86/exceptions: Disconnect IST index and stack
 order
Message-ID: <20190405215713.rv46kr5fhl3z3m4z@treble>
References: <20190405150658.237064784@linutronix.de>
 <20190405150929.938480649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405150929.938480649@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 05 Apr 2019 21:57:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:07:15PM +0200, Thomas Gleixner wrote:
> +/*
> + * The exception stack ordering in [cea_]exception_stacks
> + */
> +enum exception_stack_ordering {
> +	ISTACK_DF,
> +	ISTACK_NMI,
> +	ISTACK_DB,
> +	ISTACK_MCE,
> +	N_EXCEPTION_STACKS
> +};

While clever, it reads as "interrupt stack" to me.  ESTACK or IST_STACK
would be infinitely better.

-- 
Josh
