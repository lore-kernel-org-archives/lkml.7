Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5BFC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC49F20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440594AbfIYROg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:14:36 -0400
Received: from verein.lst.de ([213.95.11.211]:59442 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438404AbfIYROf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:14:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40F2468B02; Wed, 25 Sep 2019 19:14:33 +0200 (CEST)
Date:   Wed, 25 Sep 2019 19:14:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: allow 64-bit results in passthru commands
Message-ID: <20190925171433.GA16895@lst.de>
References: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
