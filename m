Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751B82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfCTIOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:14:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34867 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:14:24 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6WMg-0006rr-22; Wed, 20 Mar 2019 09:14:22 +0100
Date:   Wed, 20 Mar 2019 09:14:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Roman Kiryanov <rkir@google.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: power: supply: goldfish_battery: Fix bogus SPDX
 identifier
In-Reply-To: <CAOGAQepj=yW4uQSRHpvnQz71+D8a7+H71XtrApp8YGU65XgoqA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903200905380.1816@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903191529010.2537@nanos.tec.linutronix.de> <CAOGAQepj=yW4uQSRHpvnQz71+D8a7+H71XtrApp8YGU65XgoqA@mail.gmail.com>
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

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
A: No.
Q: Should I include quotations after my reply?

On Tue, 19 Mar 2019, Roman Kiryanov wrote:
> Hi, I am sorry for this warning. I remember I checked all changes I
> sent, maybe missed this one.
> 
> At the bottom the file says
> 
> MODULE_LICENSE("GPL");
> 
> and
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> makes it inconsistent.

No. It does not.

 1) The module license is not a precise license indicator.

 2) SPDX License identifiers are well defined and standardized. 'GPL' is
    NOT a valid SPDX identifier.

The usage of SPDX identifiers and the relevance of the MODULE_LICENSE()
string are well documented in:

    Documentation/process/license-rules.rst

or for your conveniance at:

    https://www.kernel.org/doc/html/latest/process/license-rules.html

Thanks,

	tglx
