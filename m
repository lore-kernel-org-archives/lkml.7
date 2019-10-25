Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD19CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACBC21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394401AbfJYJsU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:48:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbfJYJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:48:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iNwCM-0004dr-SG; Fri, 25 Oct 2019 11:47:58 +0200
Date:   Fri, 25 Oct 2019 11:47:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Tom Rix <trix@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] xfrm : lock input tasklet skb queue
Message-ID: <20191025094758.pchz4wupvo3qs6hy@linutronix.de>
References: <CACVy4SUkfn4642Vne=c1yuWhne=2cutPZQ5XeXz_QBz1g67CrA@mail.gmail.com>
 <20191024103134.GD13225@gauss3.secunet.de>
 <ad094bfc-ebb3-012b-275b-05fb5a8f86e5@jv-coder.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ad094bfc-ebb3-012b-275b-05fb5a8f86e5@jv-coder.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-25 11:37:59 [+0200], Joerg Vehlow wrote:
> Hi,
> 
> I always expected this to be applied to the RT patches. That's why
> I originally send my patch to to Sebastian, Thomas and Steven (I added
> them again now. The website of the rt patches says patches for the
> CONFIG_REEMPT_RT patchset should be send to lkml.
> 
> I hope one of the rt patch maintainers will reply here.

I've seen the first patch and it was not mentioned that it was RT
related so I did not pay any attention to it. 
Please repost your v2, please add RT next to patch, please state the RT
version and the actual problem and I take a look.

> Jörg

Sebastian
