Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3794FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB3021881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGCRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:41:53 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59168 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:41:53 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 22C5F20072E;
        Wed,  3 Jul 2019 17:41:52 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 528AE212AF; Wed,  3 Jul 2019 19:25:17 +0200 (CEST)
Date:   Wed, 3 Jul 2019 19:25:17 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/35] pcmcia: Use kmemdup rather than duplicating its
 implementation
Message-ID: <20190703172517.GA31242@light.dominikbrodowski.net>
References: <20190703162943.32691-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703162943.32691-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:29:43AM +0800, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
