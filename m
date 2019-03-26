Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B0120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfCZRYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:24:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfCZRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:24:08 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8pnv-0002Tu-W4; Tue, 26 Mar 2019 18:24:04 +0100
Date:   Tue, 26 Mar 2019 18:24:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 08/17] x86/speculation: Fix __initconst in bugs.c
In-Reply-To: <20190321220009.29334-9-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1903261817370.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-9-andi@firstfloor.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-551196898-1553621043=:1789"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-551196898-1553621043=:1789
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Thu, 21 Mar 2019, Andi Kleen wrote:

Finally found a fix in the pile of unrelated crap.

Subject: x86/speculation: Fix __initconst in bugs.c

So how does this fix __initconst?

Again from Documentation:

  "The summary phrase in the email¢s Subject should concisely describe the
  patch which that email contains. The summary phrase should not be a
  filename."

Also instead of having the file name in the subject line, which is
completely uninteresting the prefix should be 'x86/cpu/bugs:'

> Fix some of the recently added const tables to use __initconst
> for const data instead of __initdata which causes section attribute
> conflicts.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

This lacks a 'Fixes:' tag.

Thanks,

	tglx
--8323329-551196898-1553621043=:1789--
