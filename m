Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C3C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41DA206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGBPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfGBPYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:24:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29BDB882FF;
        Tue,  2 Jul 2019 15:23:57 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id B86085D6A9;
        Tue,  2 Jul 2019 15:23:40 +0000 (UTC)
Date:   Tue, 2 Jul 2019 11:23:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
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
Message-ID: <20190702112125-mutt-send-email-mst@kernel.org>
References: <20190701190940.7f23ac15@canb.auug.org.au>
 <20190701200418.GA72724@archlinux-epyc>
 <20190702141803.GA13685@ostrya.localdomain>
 <20190702151817.GD3310@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702151817.GD3310@8bytes.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 15:24:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:18:17PM +0200, Joerg Roedel wrote:
> On Tue, Jul 02, 2019 at 03:18:03PM +0100, Jean-Philippe Brucker wrote:
> > Nathan, thanks for noticing and fixing this.
> > 
> > Joerg, the virtio-iommu driver build failed in next because of a
> > dependency on driver-core changes for v5.3. I'm not sure what the best
> > practice is in this case, I guess I will resend the driver as applied
> > onto the latest driver-core, to have it working in v5.3?
> 
> This depends on what the vhost-tree maintainer prefers. I would probably
> merge the current driver-core into the virtio-iommu branch and put a
> fix on-top.
> 
> 
> Regards,
> 
> 	Joerg


I can drop virtio iommu from my tree. Where's yours? I'd like to take a
last look and send an ack.

-- 
MST
