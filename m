Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A63C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C7F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfCFUNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:13:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:13:32 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1cuq-00045w-9t; Wed, 06 Mar 2019 21:13:24 +0100
Date:   Wed, 6 Mar 2019 21:13:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Louis Taylor <louis@kragniz.eu>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] x86/KASLR: always return a value from
 process_mem_region
In-Reply-To: <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1903062112360.1646@nanos.tec.linutronix.de>
References: <20190302184929.28971-1-louis@kragniz.eu> <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de>
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

Louis,

On Wed, 6 Mar 2019, Thomas Gleixner wrote:
> 
> This does not longer apply to mainline because the function does not longer
> have a return value. So if that's important, you need to hash that out with
> the stable folks.

Ignore me. Pilot error. Was on the wrong branch.

Thanks,

	tglx
