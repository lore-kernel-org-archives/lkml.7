Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB3020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfDBItW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:49:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfDBItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:49:21 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBF6Y-0008Rf-PW; Tue, 02 Apr 2019 10:49:14 +0200
Date:   Tue, 2 Apr 2019 10:49:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Matteo Croce <mcroce@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/4] Introduce the aural error reporting framework
In-Reply-To: <20190401110329.GA12232@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1904021045310.1676@nanos.tec.linutronix.de>
References: <20190401102456.11162-1-mcroce@redhat.com> <20190401110329.GA12232@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019, Peter Zijlstra wrote:
> On Mon, Apr 01, 2019 at 12:24:51PM +0200, Matteo Croce wrote:
> > The buzzer driver is simple, requires just a few register writes to work,
> > the hardware is extremely cheap and is already present on most machines.
> 
> What, no morse-code register dumps?

Aside of that, where is the android-app to customize and decode the
melodies?

I surely want to have the music theme of 'Once Upon a Time in the West' on
kernel crashes.

Thanks,

	tglx




