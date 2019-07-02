Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A1C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48AF2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGBP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:58:55 -0400
Received: from 8bytes.org ([81.169.241.247]:33836 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGBP6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:58:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 994A5185; Tue,  2 Jul 2019 17:58:51 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:58:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190702155851.GF3310@8bytes.org>
References: <20190701190940.7f23ac15@canb.auug.org.au>
 <20190701200418.GA72724@archlinux-epyc>
 <20190702141803.GA13685@ostrya.localdomain>
 <20190702151817.GD3310@8bytes.org>
 <20190702112125-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702112125-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:23:34AM -0400, Michael S. Tsirkin wrote:
> I can drop virtio iommu from my tree. Where's yours? I'd like to take a
> last look and send an ack.

It is not in my tree yet, because I was waiting for your ack on the
patches wrt. the spec.

Given that the merge window is pretty close I can't promise to take it
into my tree for v5.3 when you ack it, so if it should go upstream this
time its better to keep it in your tree.


Regards,

	Joerg
