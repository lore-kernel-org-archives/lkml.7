Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82707C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448AE20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940058;
	bh=nQEAu9teFDxtRoTuLuKpJQOQuUKlRepqoS11epoK240=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T8D4xSWgnqoC2xKyczR0PgQYDXBfWK7EEsDL0GVbbI2rhAQ8TU08qqKEIgCxdt5T6
	 sb9+Uuk6G4Wfw3tr+az3/4vZhzut/Wcu2Vos4/wchOoV14XH0HpiDHTirVp088AkRE
	 rgPEAFIkuTHNk1AU1sHD11XVwIkYJ6c9kmrgacjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfDVNeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:34:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfDVN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AfHjuqQwnX76uUZKJYqO9EVlf2Is7kmbpQnAkbukqhU=; b=XAFk6k+6UhedQ+FLCu3ly4Un3k
        svrSQnipqPuN8s2smeWTtrFs+KMkV7AQsAH6/EfAHhjZkg1F2yNMYkqgxWGRb1MjvPzkjTxsbnNzS
        xzhEvFYN00Ia1YTHvlWi4a+Imn0D9ivLkpAajonSuWdEkqM4t+J5MyZGeEkoE0l27dgXUSAFow1sY
        Jwroc0JG/EcF989kEgtG5XgyA4mrFK6JD/WJ23bwJ41o6fiKF7A7NK2dI6ML6HUfG2tKcVZuw3t2Y
        zu3qGMHj+CNTSBIckxRBmU4xrURPedI8arVG7DSlyBuFgdVHLajDbeyxT/Sxaf5H1sjfNrW7xcq6q
        Kby0kGrw==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzZ-0005Hl-VF; Mon, 22 Apr 2019 13:28:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzT-0005nZ-Pr; Mon, 22 Apr 2019 10:28:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 51/79] docs: xen-tpmfront.txt: convert it to .rst
Date:   Mon, 22 Apr 2019 10:27:40 -0300
Message-Id: <ecdd57aeb9d0854fc6a1205bcf64ef37992624c1.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
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
2.20.1

