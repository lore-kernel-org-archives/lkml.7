Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED0C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6FE2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbfIJHFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:05:08 -0400
Received: from verein.lst.de ([213.95.11.211]:56833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfIJHFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:05:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99D8068B02; Tue, 10 Sep 2019 09:05:03 +0200 (CEST)
Date:   Tue, 10 Sep 2019 09:05:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Message-ID: <20190910070503.GA31743@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvm4l1kskny.fsf@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> 
> > The sifive serial driver implements earlycon support,
> 
> It should probably be documented in admin-guide/kernel-parameters.txt.

How so?  Wіth OF and a stdout path you just set earlycon on the
command line without any arguments and it will be found.
