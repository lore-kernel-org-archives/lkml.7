Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4759C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5642073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKOS3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:29:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44357 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfKOS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:29:24 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVgLO-0005NM-Ry; Fri, 15 Nov 2019 19:29:19 +0100
Date:   Fri, 15 Nov 2019 19:29:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
In-Reply-To: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
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

On Fri, 4 Oct 2019, Chang S. Bae wrote:
> 
> Updates from v8 [10]:
> * Internalized the interrupt check in the helper functions (Andy L.)
> * Simplified GS base helper functions (Tony L.)
> * Changed the patch order to put the paranoid path changes before the
>   context switch changes (Tony L.)
> * Fixed typos (Randy D.) and massaged a few sentences in the documentation
> * Massaged the FSGSBASE enablement message

That still lacks what Andy requested quite some time ago in the V8 thread:

     https://lore.kernel.org/lkml/034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org/

  "I also think that, before this series can have my ack, it needs an 
   actual gdb maintainer to chime in, publicly, and state that they have 
   thought about and tested the ABI changes and that gdb still works on 
   patched kernels with and without FSGSBASE enabled.  I realize that there 
   were all kinds of discussions, but they were all quite theoretical, and 
   I think that the actual patches need to be considered by people who 
   understand the concerns.  Specific test cases would be nice, too."

What's the state of this?

Thanks,

	tglx
