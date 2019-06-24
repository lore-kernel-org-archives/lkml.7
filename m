Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA9620820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfFXN6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:58:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfFXN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:58:17 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfPU6-0003pF-L7; Mon, 24 Jun 2019 15:58:14 +0200
Date:   Mon, 24 Jun 2019 15:58:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org
Subject: Re: [PATCH 1/6] x86/xen: Mark xen_hvm_need_lapic() and xen_hvm_need_lapic()
 as __init
In-Reply-To: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
Message-ID: <alpine.DEB.2.21.1906241554210.32342@nanos.tec.linutronix.de>
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
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

On Sun, 23 Jun 2019, Zhenzhong Duan wrote:

> .. as they are only called at early bootup stage. In fact, other
> functions in x86_hyper_xen_hvm.init.* are all marked as __init.
> 
> Unexport xen_hvm_need_lapic as it's never used outside.

Can you please provide a cover letter for your patch series and explain
what this whole exercise is about.

I'm seing some __init anotations in various files and then functional xen
changes which seem to be completely unrelated and independent.

Please split such stuff, e.g. the unrelated __init annotations so they can
be picked up and merged and the real functional stuff is then self
contained.

If the __init annotation touches the same code as the functional changes,
then keep them together, but please do not burden reviewers and maintainers
with guess work to decode what is what.

Thanks,

	tglx
