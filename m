Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ECBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3D02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfCYV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:28:14 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:58649 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731030AbfCYV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:28:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E87B54FE2;
        Mon, 25 Mar 2019 21:28:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: meal10_2a3ba661ded18
X-Filterd-Recvd-Size: 2729
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:28:10 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Bad file pattern in MAINTAINERS section 'SYNOPSYS DESIGNWARE AXI DMAC DRIVER'
Date:   Mon, 25 Mar 2019 14:28:08 -0700
Message-Id: <20190325212809.27891-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	14995	SYNOPSYS DESIGNWARE AXI DMAC DRIVER
	14996	M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
	14997	S:	Maintained
-->	14998	F:	drivers/dma/dwi-axi-dmac/
	14999	F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/dma/dwi-axi-dmac/':

commit 1fe20f1b84548bbcf48b6659ea171cd46618ea3a
Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date:   Tue Mar 6 14:46:14 2018 +0300

    dmaengine: Introduce DW AXI DMAC driver
    
    This patch adds support for the DW AXI DMAC controller.
    DW AXI DMAC is a part of HSDK development board from Synopsys.
    
    In this driver implementation only DMA_MEMCPY transfers are
    supported.
    
    Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>

 MAINTAINERS                                    |    6 +
 drivers/dma/Kconfig                            |   10 +
 drivers/dma/Makefile                           |    1 +
 drivers/dma/dw-axi-dmac/Makefile               |    1 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1008 ++++++++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  334 ++++++++
 6 files changed, 1360 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/dma/dwi-axi-dmac/' was found
