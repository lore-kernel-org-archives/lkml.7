Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D564C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E8E222CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfJDQkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:40:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:40206 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfJDQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:40:07 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id AFC9E6E5;
        Fri,  4 Oct 2019 16:40:06 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: remove :c:func: from genericirq.rst
Date:   Fri,  4 Oct 2019 10:39:54 -0600
Message-Id: <20191004163955.14419-2-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004163955.14419-1-corbet@lwn.net>
References: <20191004163955.14419-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of 5.3, the automarkup extension will do the right thing with function()
notation, so we don't need to clutter the text with :c:func: invocations.
So remove them.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/core-api/genericirq.rst | 50 +++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index 4da67b65cecf..2e6c99e3ce3b 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -26,7 +26,7 @@ Rationale
 =========
 
 The original implementation of interrupt handling in Linux uses the
-:c:func:`__do_IRQ` super-handler, which is able to deal with every type of
+__do_IRQ() super-handler, which is able to deal with every type of
 interrupt logic.
 
 Originally, Russell King identified different types of handlers to build
@@ -43,7 +43,7 @@ During the implementation we identified another type:
 
 -  Fast EOI type
 
-In the SMP world of the :c:func:`__do_IRQ` super-handler another type was
+In the SMP world of the __do_IRQ() super-handler another type was
 identified:
 
 -  Per CPU type
@@ -83,7 +83,7 @@ IRQ-flow implementation for 'level type' interrupts and add a
 (sub)architecture specific 'edge type' implementation.
 
 To make the transition to the new model easier and prevent the breakage
-of existing implementations, the :c:func:`__do_IRQ` super-handler is still
+of existing implementations, the __do_IRQ() super-handler is still
 available. This leads to a kind of duality for the time being. Over time
 the new model should be used in more and more architectures, as it
 enables smaller and cleaner IRQ subsystems. It's deprecated for three
@@ -116,7 +116,7 @@ status information and pointers to the interrupt flow method and the
 interrupt chip structure which are assigned to this interrupt.
 
 Whenever an interrupt triggers, the low-level architecture code calls
-into the generic interrupt code by calling :c:func:`desc->handle_irq`. This
+into the generic interrupt code by calling desc->handle_irq(). This
 high-level IRQ handling function only uses desc->irq_data.chip
 primitives referenced by the assigned chip descriptor structure.
 
@@ -125,27 +125,27 @@ High-level Driver API
 
 The high-level Driver API consists of following functions:
 
--  :c:func:`request_irq`
+-  request_irq()
 
--  :c:func:`free_irq`
+-  free_irq()
 
--  :c:func:`disable_irq`
+-  disable_irq()
 
--  :c:func:`enable_irq`
+-  enable_irq()
 
--  :c:func:`disable_irq_nosync` (SMP only)
+-  disable_irq_nosync() (SMP only)
 
--  :c:func:`synchronize_irq` (SMP only)
+-  synchronize_irq() (SMP only)
 
--  :c:func:`irq_set_irq_type`
+-  irq_set_irq_type()
 
--  :c:func:`irq_set_irq_wake`
+-  irq_set_irq_wake()
 
--  :c:func:`irq_set_handler_data`
+-  irq_set_handler_data()
 
--  :c:func:`irq_set_chip`
+-  irq_set_chip()
 
--  :c:func:`irq_set_chip_data`
+-  irq_set_chip_data()
 
 See the autogenerated function documentation for details.
 
@@ -154,19 +154,19 @@ High-level IRQ flow handlers
 
 The generic layer provides a set of pre-defined irq-flow methods:
 
--  :c:func:`handle_level_irq`
+-  handle_level_irq()
 
--  :c:func:`handle_edge_irq`
+-  handle_edge_irq()
 
--  :c:func:`handle_fasteoi_irq`
+-  handle_fasteoi_irq()
 
--  :c:func:`handle_simple_irq`
+-  handle_simple_irq()
 
--  :c:func:`handle_percpu_irq`
+-  handle_percpu_irq()
 
--  :c:func:`handle_edge_eoi_irq`
+-  handle_edge_eoi_irq()
 
--  :c:func:`handle_bad_irq`
+-  handle_bad_irq()
 
 The interrupt flow handlers (either pre-defined or architecture
 specific) are assigned to specific interrupts by the architecture either
@@ -325,14 +325,14 @@ Delayed interrupt disable
 
 This per interrupt selectable feature, which was introduced by Russell
 King in the ARM interrupt implementation, does not mask an interrupt at
-the hardware level when :c:func:`disable_irq` is called. The interrupt is kept
+the hardware level when disable_irq() is called. The interrupt is kept
 enabled and is masked in the flow handler when an interrupt event
 happens. This prevents losing edge interrupts on hardware which does not
 store an edge interrupt event while the interrupt is disabled at the
 hardware level. When an interrupt arrives while the IRQ_DISABLED flag
 is set, then the interrupt is masked at the hardware level and the
 IRQ_PENDING bit is set. When the interrupt is re-enabled by
-:c:func:`enable_irq` the pending bit is checked and if it is set, the interrupt
+enable_irq() the pending bit is checked and if it is set, the interrupt
 is resent either via hardware or by a software resend mechanism. (It's
 necessary to enable CONFIG_HARDIRQS_SW_RESEND when you want to use
 the delayed interrupt disable feature and your hardware is not capable
@@ -369,7 +369,7 @@ handler(s) to use these basic units of low-level functionality.
 __do_IRQ entry point
 ====================
 
-The original implementation :c:func:`__do_IRQ` was an alternative entry point
+The original implementation __do_IRQ() was an alternative entry point
 for all types of interrupts. It no longer exists.
 
 This handler turned out to be not suitable for all interrupt hardware
-- 
2.21.0

