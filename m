Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678ABC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326B920868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfEXHZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:25:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388910AbfEXHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:25:44 -0400
Received: from [5.158.153.53] (helo=nanos.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hU4aE-00078e-7c; Fri, 24 May 2019 09:25:42 +0200
Date:   Fri, 24 May 2019 09:25:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] rslib: RS decoder is severely broken
In-Reply-To: <20190509150929.GA309@mail-personal>
Message-ID: <alpine.DEB.2.21.1905240924430.2166@nanos.tec.linutronix.de>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com> <alpine.DEB.2.21.1904041322160.1685@nanos.tec.linutronix.de> <20190509150929.GA309@mail-personal>
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

On Thu, 9 May 2019, Ferdinand Blomqvist wrote:
> On 2019-04-04 13:24:05, Thomas Gleixner wrote:
> > Ferdinand,
> > 
> > On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:
> > 
> > Thanks for providing that! I'm short of cycles to go through that right
> > now, but will do in the foreseeable future. Feel free to remind me if I
> > don't do so within two weeks.
> 
> A gentle reminder.

Working through it. Need to page in all the details :(

Thanks,

	tglx
