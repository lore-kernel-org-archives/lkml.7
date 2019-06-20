Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563572083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfFTNt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:49:29 -0400
Received: from ozlabs.org ([203.11.71.1]:32773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFTNt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:49:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45V38P0wjWz9s5c;
        Thu, 20 Jun 2019 23:49:24 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>, paulus@samba.org
Cc:     Larry.Finger@lwfinger.net, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@iki.fi
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
In-Reply-To: <a5fc355e44fb5edea41274329f7c5d04a8dff6fc.camel@kernel.crashing.org>
References: <20190613082446.18685-1-hch@lst.de> <20190619105039.GA10118@lst.de> <87tvcldacn.fsf@concordia.ellerman.id.au> <a5fc355e44fb5edea41274329f7c5d04a8dff6fc.camel@kernel.crashing.org>
Date:   Thu, 20 Jun 2019 23:49:20 +1000
Message-ID: <87k1dgcqov.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Wed, 2019-06-19 at 22:32 +1000, Michael Ellerman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> > Any chance this could get picked up to fix the regression?
>> 
>> Was hoping Ben would Ack it. He's still powermac maintainer :)
>> 
>> I guess he OK'ed it in the other thread, will add it to my queue.
>
> Yeah ack. If I had written it myself, I would have made the DMA bits a
> variable and only set it down to 30 if I see that device in the DT
> early on, but I can't be bothered now, if it works, ship it :-)

OK, we can do that next release if someone's motivated.

> Note: The patch affects all ppc32, though I don't think it will cause
> any significant issue on those who don't need it.

Yeah. We could always hide it behind CONFIG_PPC_PMAC if it becomes a problem.

cheers
