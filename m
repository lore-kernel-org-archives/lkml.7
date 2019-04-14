Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D43C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EBE2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDNKgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:36:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42538 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfDNKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:36:13 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFcUc-0000eX-Uy; Sun, 14 Apr 2019 12:36:11 +0200
Date:   Sun, 14 Apr 2019 12:36:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Huw Davies <huw@codeweavers.com>
cc:     linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/vdso: Remove unused 'mask' member
In-Reply-To: <20190411101205.10006-2-huw@codeweavers.com>
Message-ID: <alpine.DEB.2.21.1904141235240.4917@nanos.tec.linutronix.de>
References: <20190411101205.10006-1-huw@codeweavers.com> <20190411101205.10006-2-huw@codeweavers.com>
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

On Thu, 11 Apr 2019, Huw Davies wrote:

> The 'mask' member of struct vsyscall_gtod_data is unused, so remove
> it.  Its use was removed in commit a51e996d48ac (x86/vdso: Enforce
> 64bit clocksource).

That's true, but we are moving the VDSO to generic code, so the mask will stay.

Thanks,

	tglx
