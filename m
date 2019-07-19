Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C86C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911DB2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfGSM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:29:01 -0400
Received: from verein.lst.de ([213.95.11.211]:39717 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfGSM3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:29:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AC9368B02; Fri, 19 Jul 2019 14:28:59 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:28:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
Message-ID: <20190719122859.GA30193@lst.de>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yikes, that things looks worse and worse.  I think at this point we'll
have to defer the support to 5.4 unfortunately as it is getting more
and more involved..
