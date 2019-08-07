Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE892199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfHGHyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:54:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:59697 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbfHGHyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:54:10 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x777pPaJ021791;
        Wed, 7 Aug 2019 02:51:26 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>
Subject: [PATCH v4 0/4] nvme-pci: Support for Apple 201+ (T2 chip) 
Date:   Wed,  7 Aug 2019 17:51:18 +1000
Message-Id: <20190807075122.6247-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series combines the original series and an updated version of the
shared tags patch, and is rebased on nvme-5.4.

This adds support for the controller found in recent Apple machines
which is basically a SW emulated NVME controller in the T2 chip.

The original reverse engineering work was done by
Paul Pawlowski <paul@mrarm.io>.


