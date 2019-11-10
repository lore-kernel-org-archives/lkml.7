Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE13C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5041720818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKJSTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:19:00 -0500
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:47920
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKJSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:19:00 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1iTrnX-0002aN-O6
        for linux-kernel@vger.kernel.org; Sun, 10 Nov 2019 19:18:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash controller
Date:   Sun, 10 Nov 2019 20:37:45 +0300
Message-ID: <7gul9g-je5.ln1@banana.localnet>
References: <20191107073521.11413-1-gerg@kernel.org> <20191107092053.Horde.i3MVcW9RqZDOQBMADZX9fuc@www.vdorst.com> <20191110123531.5a27206a@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.3.3-bananian (armv7l))
Cc:     driverdev-devel@linuxdriverproject.org,
        linux-mediatek@lists.infradead.org, linux-mtd@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.drivers.mtd Boris Brezillon <boris.brezillon@collabora.com> wrote:
> +Richard and Miquel

> On Thu, 07 Nov 2019 09:20:53 +0000
> René van Dorst <opensource@vdorst.com> wrote:

> > Quoting gerg@kernel.org:
> > 
> > > From: Greg Ungerer <gerg@kernel.org>

[..skipp..]

> > +CC DENG Qingfang, Chuanhong Guo, Weijie Gao to the list.
> > 
> > Hi Greg,
> > 
> > Thanks for posting this driver.
> > 
> > But I would like to mention that the openwrt community is currently  
> > working on a
> > new version which is based a newer version of the MediaTek vendor driver.
> > That version is currently targeted for the openwrt 4.19 kernel.
> > See full pull request [1] and NAND driver patch [2]
> > 
> > It would be a shame if duplicate work has been done.

> Sorry, but if there's duplicate effort that's kinda your (OpenWRT folks)
> fault: since when OpenWRT is the central point for kernel drivers?
> Correct me if I'm wrong, but I don't remember seeing this driver posted
> to the MTD ML. Plus, the driver you're pointing to still implements the
> legacy hooks and is based on 4.19, and it has been decided that all new
> NAND controller drivers should implement the new ->exec_op() hook
> instead.

I'm already sent to Greg Ungerer 5.3 variant of this patch.
but it:
- PIO only (old driver from 3.4.x kernel have "DMA")
- strange SLOW (4.19 on same hardware is faster)

you may grab it from http://lc.vrtpro.ru/lede/5.3-new-mtk7621-nand-driver.patch

