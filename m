Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EDBCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147FF217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390663AbfJ1PPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:15:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfJ1PPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:15:34 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iP6jk-0005La-2r; Mon, 28 Oct 2019 16:15:16 +0100
Date:   Mon, 28 Oct 2019 16:15:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Tom Rix <trix@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] xfrm : lock input tasklet skb queue
Message-ID: <20191028151447.xwtyh6hfwfvzwmmu@linutronix.de>
References: <CACVy4SUkfn4642Vne=c1yuWhne=2cutPZQ5XeXz_QBz1g67CrA@mail.gmail.com>
 <20191024103134.GD13225@gauss3.secunet.de>
 <ad094bfc-ebb3-012b-275b-05fb5a8f86e5@jv-coder.de>
 <20191025094758.pchz4wupvo3qs6hy@linutronix.de>
 <202da67b-95c7-3355-1abc-f67a40a554e9@jv-coder.de>
 <20191025102203.zmkqvvg5tofaqfw6@linutronix.de>
 <5b45c8f6-1aa2-2e1e-9019-a140988bba80@jv-coder.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b45c8f6-1aa2-2e1e-9019-a140988bba80@jv-coder.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-28 11:44:57 [+0100], Joerg Vehlow wrote:
> I was unable to reproduce it with 5.2.21-rt13. Do you know if something
> changed in network scheduling code or could it be just less likely?

the softirq/BH handling has been rewritten in the v5.0-RT cycle,
v5.0.19-rt11 to be exact. So if that the cause for it (which I hope)
then you should be able to trigger the problem before that release and
not later.

Sebastian
