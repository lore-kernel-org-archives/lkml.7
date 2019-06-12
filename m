Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F85C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364865;
	bh=VdafxH3HUUcr/7qDsWyG8AqYP2EMihrdCts/1jK5vBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GaXaXrd2uZo+6u6GFfl47qATyS6WRG/uJkhpbwb0/MXWR48GPQwDGQ7dRgIu0J2Io
	 stL0UVGbm6hUa6a4OH/HSpywydRbB+DyCqgZqnvA856cHqWgBHd0ZvIzJkQoTVKFTk
	 tqvTqdPoJMfsg3e7dLJUKfL2Qz2Kj7I8AyrB/07M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfFLSij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfFLSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LvMZCNqyjGCYorMHMnZsk1Wxffwcw4B9xSPUy6NpG7A=; b=c9JbDLf3c3uOxQ7Dq2GrjBPa2j
        OHHAR6cixPlZFhc4jad5gctIARzujfBkPCL9CPCGnE0QtGlopg7uyWI4X8CUktAmstk4wU+KsGfZf
        0YdwMUscmK5ZmuiCtd/89QmN0cHuKZgltWcoIVhAfecgmtvUAonlqGkY8hLVolACCBm+M1NmGZE48
        dfu1p9FJJeVfUNXAJrtUsED7G8Z5bmijQU1FVruXzk9Ylwj12f3iCP5ORZpDpjzPS9Kzwg9Hl9X/n
        D64Xzjfbh6YhOB82ZFJFDNsoOOLFGNaDLMO5Y8Gr9amyn9lxMnrR1Z/HObf3IcQGpzg1NygqaXPvF
        uAMuSm2w==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006Y8-GS; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002B1-3a; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 12/31] docs: xen-tpmfront.txt: convert it to .rst
Date:   Wed, 12 Jun 2019 15:38:15 -0300
Message-Id: <5725f4a1e80540c820a031bc21ae769297d8b32b.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to add this file to the security book,
we need first to convert it to reST.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{xen-tpmfront.txt => xen-tpmfront.rst}    | 103 ++++++++++--------
 1 file changed, 58 insertions(+), 45 deletions(-)
 rename Documentation/security/tpm/{xen-tpmfront.txt => xen-tpmfront.rst} (66%)

diff --git a/Documentation/security/tpm/xen-tpmfront.txt b/Documentation/security/tpm/xen-tpmfront.rst
similarity index 66%
rename from Documentation/security/tpm/xen-tpmfront.txt
rename to Documentation/security/tpm/xen-tpmfront.rst
index 69346de87ff3..98a16ab87360 100644
--- a/Documentation/security/tpm/xen-tpmfront.txt
+++ b/Documentation/security/tpm/xen-tpmfront.rst
@@ -1,4 +1,8 @@
+:orphan:
+
+﻿=============================
 Virtual TPM interface for Xen
+=============================
 
 Authors: Matthew Fioravante (JHUAPL), Daniel De Graaf (NSA)
 
@@ -6,7 +10,8 @@ This document describes the virtual Trusted Platform Module (vTPM) subsystem for
 Xen. The reader is assumed to have familiarity with building and installing Xen,
 Linux, and a basic understanding of the TPM and vTPM concepts.
 
-INTRODUCTION
+Introduction
+------------
 
 The goal of this work is to provide a TPM functionality to a virtual guest
 operating system (in Xen terms, a DomU).  This allows programs to interact with
@@ -24,81 +29,89 @@ This mini-os vTPM subsystem was built on top of the previous vTPM work done by
 IBM and Intel corporation.
 
 
-DESIGN OVERVIEW
+Design Overview
 ---------------
 
-The architecture of vTPM is described below:
+The architecture of vTPM is described below::
 
-+------------------+
-|    Linux DomU    | ...
-|       |  ^       |
-|       v  |       |
-|   xen-tpmfront   |
-+------------------+
-        |  ^
-        v  |
-+------------------+
-| mini-os/tpmback  |
-|       |  ^       |
-|       v  |       |
-|  vtpm-stubdom    | ...
-|       |  ^       |
-|       v  |       |
-| mini-os/tpmfront |
-+------------------+
-        |  ^
-        v  |
-+------------------+
-| mini-os/tpmback  |
-|       |  ^       |
-|       v  |       |
-| vtpmmgr-stubdom  |
-|       |  ^       |
-|       v  |       |
-| mini-os/tpm_tis  |
-+------------------+
-        |  ^
-        v  |
-+------------------+
-|   Hardware TPM   |
-+------------------+
+  +------------------+
+  |    Linux DomU    | ...
+  |       |  ^       |
+  |       v  |       |
+  |   xen-tpmfront   |
+  +------------------+
+          |  ^
+          v  |
+  +------------------+
+  | mini-os/tpmback  |
+  |       |  ^       |
+  |       v  |       |
+  |  vtpm-stubdom    | ...
+  |       |  ^       |
+  |       v  |       |
+  | mini-os/tpmfront |
+  +------------------+
+          |  ^
+          v  |
+  +------------------+
+  | mini-os/tpmback  |
+  |       |  ^       |
+  |       v  |       |
+  | vtpmmgr-stubdom  |
+  |       |  ^       |
+  |       v  |       |
+  | mini-os/tpm_tis  |
+  +------------------+
+          |  ^
+          v  |
+  +------------------+
+  |   Hardware TPM   |
+  +------------------+
 
- * Linux DomU: The Linux based guest that wants to use a vTPM. There may be
+* Linux DomU:
+	       The Linux based guest that wants to use a vTPM. There may be
 	       more than one of these.
 
- * xen-tpmfront.ko: Linux kernel virtual TPM frontend driver. This driver
+* xen-tpmfront.ko:
+		    Linux kernel virtual TPM frontend driver. This driver
                     provides vTPM access to a Linux-based DomU.
 
- * mini-os/tpmback: Mini-os TPM backend driver. The Linux frontend driver
+* mini-os/tpmback:
+		    Mini-os TPM backend driver. The Linux frontend driver
 		    connects to this backend driver to facilitate communications
 		    between the Linux DomU and its vTPM. This driver is also
 		    used by vtpmmgr-stubdom to communicate with vtpm-stubdom.
 
- * vtpm-stubdom: A mini-os stub domain that implements a vTPM. There is a
+* vtpm-stubdom:
+		 A mini-os stub domain that implements a vTPM. There is a
 		 one to one mapping between running vtpm-stubdom instances and
                  logical vtpms on the system. The vTPM Platform Configuration
                  Registers (PCRs) are normally all initialized to zero.
 
- * mini-os/tpmfront: Mini-os TPM frontend driver. The vTPM mini-os domain
+* mini-os/tpmfront:
+		     Mini-os TPM frontend driver. The vTPM mini-os domain
 		     vtpm-stubdom uses this driver to communicate with
 		     vtpmmgr-stubdom. This driver is also used in mini-os
 		     domains such as pv-grub that talk to the vTPM domain.
 
- * vtpmmgr-stubdom: A mini-os domain that implements the vTPM manager. There is
+* vtpmmgr-stubdom:
+		    A mini-os domain that implements the vTPM manager. There is
 		    only one vTPM manager and it should be running during the
 		    entire lifetime of the machine.  This domain regulates
 		    access to the physical TPM on the system and secures the
 		    persistent state of each vTPM.
 
- * mini-os/tpm_tis: Mini-os TPM version 1.2 TPM Interface Specification (TIS)
+* mini-os/tpm_tis:
+		    Mini-os TPM version 1.2 TPM Interface Specification (TIS)
                     driver. This driver used by vtpmmgr-stubdom to talk directly to
                     the hardware TPM. Communication is facilitated by mapping
                     hardware memory pages into vtpmmgr-stubdom.
 
- * Hardware TPM: The physical TPM that is soldered onto the motherboard.
+* Hardware TPM:
+		The physical TPM that is soldered onto the motherboard.
 
 
-INTEGRATION WITH XEN
+Integration With Xen
 --------------------
 
 Support for the vTPM driver was added in Xen using the libxl toolstack in Xen
-- 
2.21.0

