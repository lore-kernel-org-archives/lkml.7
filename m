Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F5C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74914214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfGOIB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:01:29 -0400
Received: from verein.lst.de ([213.95.11.211]:58706 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbfGOIB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:01:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 13AEA68B05; Mon, 15 Jul 2019 10:01:26 +0200 (CEST)
Date:   Mon, 15 Jul 2019 10:01:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Misha Nasledov <misha@nasledov.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NVME: ignore subnqn for ADATA SX6000LNP
Message-ID: <20190715080125.GA31791@lst.de>
References: <20190715071149.GA24206@nasledov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715071149.GA24206@nasledov.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.3 manually as our quirk list has growned vs whatever
tree you prepared it against.
