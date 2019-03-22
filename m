Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C6E218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfCVXS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:18:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfCVXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:18:55 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7TR1-0003nE-J7; Sat, 23 Mar 2019 00:18:47 +0100
Date:   Sat, 23 Mar 2019 00:18:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Sebastian Reichel <sre@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] x86, olpc: Don't split string literals when fixing
 up the DT
In-Reply-To: <20190310162419.11861-3-lkundrak@v3.sk>
Message-ID: <alpine.DEB.2.21.1903230017190.2157@nanos.tec.linutronix.de>
References: <20190310162419.11861-1-lkundrak@v3.sk> <20190310162419.11861-3-lkundrak@v3.sk>
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

On Sun, 10 Mar 2019, Lubomir Rintel wrote:

Please use 'x86/platform/olpc:' as prefix in the subject.

> It was pointed out in a review, and checkpatch.pl complains about this.
> Breaking it down into multiple ofw evaluations works just as well, and
> perhaps even reads better.

perhaps?

Other than that:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
