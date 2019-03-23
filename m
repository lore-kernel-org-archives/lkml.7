Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09705218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCWRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:23:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42681 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCWRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:23:43 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7kMn-0005Vp-Gn; Sat, 23 Mar 2019 18:23:33 +0100
Date:   Sat, 23 Mar 2019 18:23:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH tip] tick: tick_shutdown_broadcast() can be static
In-Reply-To: <20190323170405.GA45896@lkp-kbuild03>
Message-ID: <alpine.DEB.2.21.1903231818240.1798@nanos.tec.linutronix.de>
References: <201903240149.MYxIj3WB%lkp@intel.com> <20190323170405.GA45896@lkp-kbuild03>
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

On Sun, 24 Mar 2019, kbuild test robot wrote:

> Fixes: 973f88ca8b15 ("tick: Remove outgoing CPU from broadcast masks")

No, it does not fix it. The result is that you have a static function which
is not called from anywhere. I'll amend the commit with the proper fix.

Thanks for reporting.

       tglx
