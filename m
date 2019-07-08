Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B1C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5920861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfGHGBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:01:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38433 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfGHGBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:01:17 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkMiB-0001U9-25; Mon, 08 Jul 2019 08:01:15 +0200
Date:   Mon, 8 Jul 2019 08:01:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Schumacher <timschumi@gmx.de>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: iforce - Remove empty multiline comments
In-Reply-To: <20190708025010.9318-1-timschumi@gmx.de>
Message-ID: <alpine.DEB.2.21.1907080800160.3648@nanos.tec.linutronix.de>
References: <20190708025010.9318-1-timschumi@gmx.de>
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

On Mon, 8 Jul 2019, Tim Schumacher wrote:

> Those are remnants of the SPDX identifier migration, which haven't been
> removed properly.
> 
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> This is probably the highest level of cosmetic-only that a patch
> can achieve, sorry for the noise.
> 
> CCing Thomas Gleixner, since the tool (is it a tool?) that makes
> those SPDX changes would have room for improvement in that regard.
> It seems to expect that all of the license information is contained
> within the same comment block, which wasn't the case for the iforce
> driver.

Right. I noticed too late, that these empty comments were left. Tool was
fixed for later patches.

Thanks for cleaning that up.

       tglx
