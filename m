Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97599206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfC1AQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:16:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1AQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:16:11 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9IiG-0005s6-LK; Thu, 28 Mar 2019 01:16:08 +0100
Date:   Thu, 28 Mar 2019 01:16:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wei Yang <richard.weiyang@gmail.com>
cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
In-Reply-To: <20190327220513.p4qrgxhvmvgooxjv@master>
Message-ID: <alpine.DEB.2.21.1903280111480.1789@nanos.tec.linutronix.de>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com> <20190212021215.13247-5-richardw.yang@linux.intel.com> <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de> <20190327220513.p4qrgxhvmvgooxjv@master>
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

Wei,

On Wed, 27 Mar 2019, Wei Yang wrote:
> On Sun, Mar 24, 2019 at 03:29:04PM +0100, Thomas Gleixner wrote:
> >Note, it's a combo of changes (including your patch 1/6) and needs to be
> >split up. It would be nice if you have time to split it up into separate
> >patches, add proper changelogs and test the heck out of it on both 32 and
> >64 bit. If you don't have time, please let me know.
> >
> 
> Thanks for your suggestions :-)
> 
> Just get my head up, will try to understand the code and test on both
> arch.
> 
> BTW, do you have some suggestions in the test? Currently I just use
> bootup test. Basicly I think this is fine to cover the cases. Maybe you
> would have some better idea.

This is about bootup in the first place. After that memory hotplug which
you can emulate with qemu/kvm IIRC.

The important part about testing is to have systems which expose a wide
variety memory layouts.

Thanks,

	tglx

