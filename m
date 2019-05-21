Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB6EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469B421019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfEUGyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:54:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57794 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfEUGyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:54:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2BBDE68B05; Tue, 21 May 2019 08:53:47 +0200 (CEST)
Date:   Tue, 21 May 2019 08:53:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: target: use struct_size() in kmalloc()
Message-ID: <20190521065346.GG30402@lst.de>
References: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok to me, although for a fixed size argument the whole overflow
detection thing in struct_size() is rather pointless..

