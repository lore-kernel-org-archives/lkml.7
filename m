Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91428C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1CF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKKUhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:37:46 -0500
Received: from verein.lst.de ([213.95.11.211]:51892 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfKKUhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:37:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45C7368B05; Mon, 11 Nov 2019 21:37:43 +0100 (CET)
Date:   Mon, 11 Nov 2019 21:37:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-nvme@lists.infradead.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, hch@lst.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20191111203743.GA25876@lst.de>
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:38:09AM -0800, Alan Mikhak wrote:
> A design goal is to not modify the Linux NVMe target driver
> at all.

As I told you before that is not a "goal" but a fundamental mistake and
against the design philosophy of all major Linux subsystems.  Please fix
your series to move all command parsing to the code based on flags for
fabrics vs PCIe in the few places where they significantly differ.
