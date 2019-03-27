Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F1B20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfC0ThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:37:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfC0ThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:37:13 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9EMD-0000KO-E9; Wed, 27 Mar 2019 20:37:05 +0100
Date:   Wed, 27 Mar 2019 20:37:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v4 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
In-Reply-To: <20190327192940.GJ32571@zn.tnic>
Message-ID: <alpine.DEB.2.21.1903272036350.1789@nanos.tec.linutronix.de>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com> <20190325163410.171021-2-Yazen.Ghannam@amd.com> <alpine.DEB.2.21.1903272019190.1789@nanos.tec.linutronix.de> <20190327192940.GJ32571@zn.tnic>
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

On Wed, 27 Mar 2019, Borislav Petkov wrote:

> On Wed, Mar 27, 2019 at 08:19:57PM +0100, Thomas Gleixner wrote:
> > > Cc: <stable@vger.kernel.org> # 5.0.x: c95b323dcd35: x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models
> > 
> > What is this supposed to tell us?
> 
> That's stable speak from Documentation/process/stable-kernel-rules.rst
> for patch prerequisites:
> 
> "Additionally, some patches submitted via :ref:`option_1` may have additional
> patch prerequisites which can be cherry-picked. This can be specified in the
> following format in the sign-off area:
> 
> .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>      Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>      Cc: <stable@vger.kernel.org> # 3.3.x
>      Signed-off-by: Ingo Molnar <mingo@elte.hu>"

Cute. Wasn't aware of that.

Thanks for the education!

       tglx
