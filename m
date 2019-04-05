Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC0C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F4021855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDEVxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:53:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:53:44 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCWmL-0005Za-L9; Fri, 05 Apr 2019 23:53:41 +0200
Date:   Fri, 5 Apr 2019 23:53:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/microcode: Deprecate MICROCODE_OLD_INTERFACE
In-Reply-To: <20190405133010.24249-4-bp@alien8.de>
Message-ID: <alpine.DEB.2.21.1904052353210.1802@nanos.tec.linutronix.de>
References: <20190405133010.24249-1-bp@alien8.de> <20190405133010.24249-4-bp@alien8.de>
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

On Fri, 5 Apr 2019, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> This is the ancient loading interface which requires special tools to be
> used. The bigger problem with it is that it is as inadequate for proper
> loading of microcode as the late microcode loading interface is because
> it happens just as late.
> 
> iucode_tool's manpage already warns people that it is deprecated.
> 
> Deprecate it and turn it off by default along with a big warning in the
> Kconfig help. It will go away sometime in the future.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
