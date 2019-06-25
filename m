Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A994C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468FF204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfFYK4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:56:53 -0400
Received: from gofer.mess.org ([88.97.38.141]:35075 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfFYK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:56:52 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 2E5D260E3B; Tue, 25 Jun 2019 11:56:51 +0100 (BST)
Date:   Tue, 25 Jun 2019 11:56:50 +0100
From:   Sean Young <sean@mess.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] media: ttpci: add RC_CORE dependency
Message-ID: <20190625105650.scnahq2e5xgdnt2c@gofer.mess.org>
References: <20190617111718.2277220-1-arnd@arndb.de>
 <20190617111718.2277220-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617111718.2277220-3-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:16:53PM +0200, Arnd Bergmann wrote:
> The ttpci driver now uses the rc-core, so we need to ensure it
> is enabled:
> 
> ERROR: "rc_unregister_device" [drivers/media/pci/ttpci/dvb-ttpci.ko] undefined!
> ERROR: "rc_allocate_device" [drivers/media/pci/ttpci/dvb-ttpci.ko] undefined!
> ERROR: "rc_free_device" [drivers/media/pci/ttpci/dvb-ttpci.ko] undefined!
> ERROR: "rc_keydown" [drivers/media/pci/ttpci/dvb-ttpci.ko] undefined!
> ERROR: "rc_register_device" [drivers/media/pci/ttpci/dvb-ttpci.ko] undefined!
> 
> Fixes: 71f49a8bf5c5 ("media: ttpci: use rc-core for the IR receiver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for the patch, unfortunately this was already fixed in
commit 12e23ebb396e6ffea88b8c5e483059a297326afb (which was accepted
after you sent your patch).

Thanks
Sean
