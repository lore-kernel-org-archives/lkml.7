Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA61C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8FE20873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfJDQkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:40:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:40202 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfJDQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:40:06 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 65D3A2D7;
        Fri,  4 Oct 2019 16:40:06 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] Improvements to the genericirq documentation
Date:   Fri,  4 Oct 2019 10:39:53 -0600
Message-Id: <20191004163955.14419-1-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially I started out just getting rid of :c:func: clutter, but then
noticed that request_irq() wasn't documented - I am guessing that got left
behind when request_threaded_irq() came in.  The second patch fixes that up
as well.

Happy to carry this up or let it go through the IRQ tree, whichever is
preferable.

Jonathan Corbet (2):
  docs: remove :c:func: from genericirq.rst
  docs: Add request_irq() documentation

 Documentation/core-api/genericirq.rst | 52 ++++++++++++++-------------
 include/linux/interrupt.h             | 13 +++++++
 2 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.21.0

