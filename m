Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D431B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfC1AZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:25:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1AZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:25:01 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9Iqo-0005yz-47; Thu, 28 Mar 2019 01:24:58 +0100
Date:   Thu, 28 Mar 2019 01:24:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH ghak10 v6 1/2] timekeeping: Audit clock adjustments
In-Reply-To: <alpine.DEB.2.21.1903280106340.1789@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1903280119190.1789@nanos.tec.linutronix.de>
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-2-omosnace@redhat.com> <alpine.DEB.2.21.1903280020390.1789@nanos.tec.linutronix.de> <alpine.DEB.2.21.1903280106340.1789@nanos.tec.linutronix.de>
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

Folks,

either lift the subscriber only limitation for your audit mailing list or
simply not Cc it when posting on LKML.

These bounce messages are annoying and if the moderator sleeps then the
people on that list who might be interested but not Cc'ed and not
subscribed to LKML (which I can understand) are not going to get the info
until someone moderates it.

Please stop that nonsense.

Thanks,

	tglx
