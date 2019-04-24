Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EBF218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfDXIgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:36:44 -0400
Received: from verein.lst.de ([213.95.11.211]:52314 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfDXIgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:36:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B234568AA6; Wed, 24 Apr 2019 10:36:28 +0200 (CEST)
Date:   Wed, 24 Apr 2019 10:36:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nds32: remove __virt_to_bus and __bus_to_virt
Message-ID: <20190424083628.GA15056@lst.de>
References: <20190409102654.25845-1-hch@lst.de> <20190424061423.GA12864@lst.de> <CAEbi=3cpQWymVB0fErJ5-cULm59dmG5QZ+MNH0PB7oOGOpe8hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3cpQWymVB0fErJ5-cULm59dmG5QZ+MNH0PB7oOGOpe8hA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:55:25PM +0800, Greentime Hu wrote:
> Hi Christoph,
> 
> Thank you.
> Acked-by: Greentime Hu <greentime@andestech.com>

Can you queue it up in the nds32 tree?
