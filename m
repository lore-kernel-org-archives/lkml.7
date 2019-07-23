Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDCFC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E953B2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbfGWQzp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:55:45 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64566 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729558AbfGWQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:55:45 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17540326-1500050 
        for multiple; Tue, 23 Jul 2019 17:55:39 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Chuhong Yuan <hslester96@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <156389911703.31349.2020385253528691635@skylake-alporthouse-com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190723103915.3964-1-hslester96@gmail.com>
 <156389911703.31349.2020385253528691635@skylake-alporthouse-com>
Message-ID: <156390093724.31349.11990658707501306462@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 17:55:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2019-07-23 17:25:17)
> Quoting Chuhong Yuan (2019-07-23 11:39:16)
> > Instead of using to_pci_dev + pci_get_drvdata,
> > use dev_get_drvdata to make code simpler.
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> 
> That cuts out some circumlocution,
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

And pushed to dinq, thanks.
-Chris
