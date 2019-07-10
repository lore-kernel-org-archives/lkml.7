Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CADC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DE02064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfGJQi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:38:57 -0400
Received: from verein.lst.de ([213.95.11.211]:51855 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfGJQi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:38:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4BD2F227A81; Wed, 10 Jul 2019 18:38:53 +0200 (CEST)
Date:   Wed, 10 Jul 2019 18:38:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Subject: Re: [PATCH v2] nvme: fix multipath crash when ANA desactivated
Message-ID: <20190710163853.GB25486@lst.de>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu> <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com> <20190709212904.GB9636@lst.de> <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 07:26:46AM +0200, Marta Rybczynska wrote:
> Christoph, why would you like to put the use_ana function in the header?
> It isn't used anywhere else outside of that file.

nvme_ctrl_use_ana has a single caller in core.c as well.
