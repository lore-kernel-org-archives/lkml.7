Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2FAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EC9205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfHMPhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:37:11 -0400
Received: from verein.lst.de ([213.95.11.211]:58149 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbfHMPhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:37:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FB1368B02; Tue, 13 Aug 2019 17:37:07 +0200 (CEST)
Date:   Tue, 13 Aug 2019 17:37:07 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/17] riscv: clear the instruction cache and all
 registers when booting
Message-ID: <20190813153707.GA8686@lst.de>
References: <20190624054311.30256-1-hch@lst.de> <20190624054311.30256-17-hch@lst.de> <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:26:18PM +0000, Atish Patra wrote:
> That means it should be done for S-mode as well. Right ?

For S-mode the bootloader/sbi should take care of it.
