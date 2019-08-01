Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67620C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2D3206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P6VIyyI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfHAVkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:40:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41099 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389222AbfHAVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so32640780pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2qplkPoUTr5hGBgTaNkezKbmSuibZ+H7u6PV+xZWyg=;
        b=P6VIyyI/HAJhEeyGiRWyljp8ODO93HG+EUNzo84jUGK8wf3NShTQoDBzBPuyc0OjyC
         6n6M3ED4RgQ+hUl5X4VPtG9xQm9+WgjJxU8VQwwBfgUSEDLu/BzgHwNk7TEXBqqyULPm
         Aj3Gr2OL8lPsy96v4TQp82mzVTAlpMZjvrKw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2qplkPoUTr5hGBgTaNkezKbmSuibZ+H7u6PV+xZWyg=;
        b=Ck7y82NFI+Qtrs27bX992pROmGy4J0hrpBj01ckQr3GeBDogIgZ+kvm0OWefm2p4Fg
         3ZcThOv5nzd6PkTAHaGYpoTFtvAzY7YpP03/Uh27slthTCHDQWOXT91a939W1OS70ZRm
         c/GbvkkXdiRIRWmPRHbF2shtyw6pPQ8h76V9BXvIuHApTaSdjutBSSHGWYTpmFd+JACk
         wguXXw1cjW8fmAHn2JMrxBWHxLyM6jLNytgGhGPXUGfW+xemg9IMRVfpnoPSFCfXAjec
         ov1GYjHtIAYpdoFSXodxaH8NOXBKrZ8a50VHnwjSmtfVcvIvY/O0eiAIW2FuOaxX18tu
         KoDQ==
X-Gm-Message-State: APjAAAW23JJ03Hk4IMTLIKSiKTz4GNnbDiK2w/O7ibmSlePyc2CoU81y
        YJmePZHeZtdEoblKX3U9XtmfIp4p
X-Google-Smtp-Source: APXvYqyMzUdobW/GKbojrKZ3UeIT0CmEcL2hf5DseshCm+J3rBESh9wYBE2gSe5R+xn0DxolmFCMgw==
X-Received: by 2002:a17:902:2987:: with SMTP id h7mr33582822plb.37.1564695582052;
        Thu, 01 Aug 2019 14:39:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 4/7] docs: rcu: Correct links referring to titles
Date:   Thu,  1 Aug 2019 17:39:19 -0400
Message-Id: <20190801213922.158860-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro's auto conversion broken these links, fix them.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../Tree-RCU-Memory-Ordering.rst              | 17 ++--
 .../RCU/Design/Requirements/Requirements.rst  | 90 ++++++++-----------
 2 files changed, 47 insertions(+), 60 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 1011b5db1b3d..248b1222f918 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -230,15 +230,14 @@ Tree RCU Grace Period Memory Ordering Components
 Tree RCU's grace-period memory-ordering guarantee is provided by a
 number of RCU components:
 
-#. `Callback Registry <#Callback%20Registry>`__
-#. `Grace-Period Initialization <#Grace-Period%20Initialization>`__
-#. `Self-Reported Quiescent
-   States <#Self-Reported%20Quiescent%20States>`__
-#. `Dynamic Tick Interface <#Dynamic%20Tick%20Interface>`__
-#. `CPU-Hotplug Interface <#CPU-Hotplug%20Interface>`__
-#. `Forcing Quiescent States <Forcing%20Quiescent%20States>`__
-#. `Grace-Period Cleanup <Grace-Period%20Cleanup>`__
-#. `Callback Invocation <Callback%20Invocation>`__
+#. `Callback Registry`_
+#. `Grace-Period Initialization`_
+#. `Self-Reported Quiescent States`_
+#. `Dynamic Tick Interface`_
+#. `CPU-Hotplug Interface`_
+#. `Forcing Quiescent States`_
+#. `Grace-Period Cleanup`_
+#. `Callback Invocation`_
 
 Each of the following section looks at the corresponding component in
 detail.
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 876e0038bb58..a33b5fb331b4 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -36,16 +36,14 @@ technologies in interesting new ways.
 All that aside, here are the categories of currently known RCU
 requirements:
 
-#. `Fundamental Requirements <#Fundamental%20Requirements>`__
-#. `Fundamental Non-Requirements <#Fundamental%20Non-Requirements>`__
-#. `Parallelism Facts of Life <#Parallelism%20Facts%20of%20Life>`__
-#. `Quality-of-Implementation
-   Requirements <#Quality-of-Implementation%20Requirements>`__
-#. `Linux Kernel Complications <#Linux%20Kernel%20Complications>`__
-#. `Software-Engineering
-   Requirements <#Software-Engineering%20Requirements>`__
-#. `Other RCU Flavors <#Other%20RCU%20Flavors>`__
-#. `Possible Future Changes <#Possible%20Future%20Changes>`__
+#. `Fundamental Requirements`_
+#. `Fundamental Non-Requirements`_
+#. `Parallelism Facts of Life`_
+#. `Quality-of-Implementation Requirements`_
+#. `Linux Kernel Complications`_
+#. `Software-Engineering Requirements`_
+#. `Other RCU Flavors`_
+#. `Possible Future Changes`_
 
 This is followed by a `summary <#Summary>`__, however, the answers to
 each quick quiz immediately follows the quiz. Select the big white space
@@ -57,13 +55,11 @@ Fundamental Requirements
 RCU's fundamental requirements are the closest thing RCU has to hard
 mathematical requirements. These are:
 
-#. `Grace-Period Guarantee <#Grace-Period%20Guarantee>`__
-#. `Publish-Subscribe Guarantee <#Publish-Subscribe%20Guarantee>`__
-#. `Memory-Barrier Guarantees <#Memory-Barrier%20Guarantees>`__
-#. `RCU Primitives Guaranteed to Execute
-   Unconditionally <#RCU%20Primitives%20Guaranteed%20to%20Execute%20Unconditionally>`__
-#. `Guaranteed Read-to-Write
-   Upgrade <#Guaranteed%20Read-to-Write%20Upgrade>`__
+#. `Grace-Period Guarantee`_
+#. `Publish/Subscribe Guarantee`_
+#. `Memory-Barrier Guarantees`_
+#. `RCU Primitives Guaranteed to Execute Unconditionally`_
+#. `Guaranteed Read-to-Write Upgrade`_
 
 Grace-Period Guarantee
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -689,16 +685,11 @@ infinitely long, however, the following sections list a few
 non-guarantees that have caused confusion. Except where otherwise noted,
 these non-guarantees were premeditated.
 
-#. `Readers Impose Minimal
-   Ordering <#Readers%20Impose%20Minimal%20Ordering>`__
-#. `Readers Do Not Exclude
-   Updaters <#Readers%20Do%20Not%20Exclude%20Updaters>`__
-#. `Updaters Only Wait For Old
-   Readers <#Updaters%20Only%20Wait%20For%20Old%20Readers>`__
-#. `Grace Periods Don't Partition Read-Side Critical
-   Sections <#Grace%20Periods%20Don't%20Partition%20Read-Side%20Critical%20Sections>`__
-#. `Read-Side Critical Sections Don't Partition Grace
-   Periods <#Read-Side%20Critical%20Sections%20Don't%20Partition%20Grace%20Periods>`__
+#. `Readers Impose Minimal Ordering`_
+#. `Readers Do Not Exclude Updaters`_
+#. `Updaters Only Wait For Old Readers`_
+#. `Grace Periods Don't Partition Read-Side Critical Sections`_
+#. `Read-Side Critical Sections Don't Partition Grace Periods`_
 
 Readers Impose Minimal Ordering
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1056,11 +1047,11 @@ it would likely be subject to limitations that would make it
 inappropriate for industrial-strength production use. Classes of
 quality-of-implementation requirements are as follows:
 
-#. `Specialization <#Specialization>`__
-#. `Performance and Scalability <#Performance%20and%20Scalability>`__
-#. `Forward Progress <#Forward%20Progress>`__
-#. `Composability <#Composability>`__
-#. `Corner Cases <#Corner%20Cases>`__
+#. `Specialization`_
+#. `Performance and Scalability`_
+#. `Forward Progress`_
+#. `Composability`_
+#. `Corner Cases`_
 
 These classes is covered in the following sections.
 
@@ -1692,21 +1683,18 @@ The Linux kernel provides an interesting environment for all kinds of
 software, including RCU. Some of the relevant points of interest are as
 follows:
 
-#. `Configuration <#Configuration>`__.
-#. `Firmware Interface <#Firmware%20Interface>`__.
-#. `Early Boot <#Early%20Boot>`__.
-#. `Interrupts and non-maskable interrupts
-   (NMIs) <#Interrupts%20and%20NMIs>`__.
-#. `Loadable Modules <#Loadable%20Modules>`__.
-#. `Hotplug CPU <#Hotplug%20CPU>`__.
-#. `Scheduler and RCU <#Scheduler%20and%20RCU>`__.
-#. `Tracing and RCU <#Tracing%20and%20RCU>`__.
-#. `Energy Efficiency <#Energy%20Efficiency>`__.
-#. `Scheduling-Clock Interrupts and
-   RCU <#Scheduling-Clock%20Interrupts%20and%20RCU>`__.
-#. `Memory Efficiency <#Memory%20Efficiency>`__.
-#. `Performance, Scalability, Response Time, and
-   Reliability <#Performance,%20Scalability,%20Response%20Time,%20and%20Reliability>`__.
+#. `Configuration`_
+#. `Firmware Interface`_
+#. `Early Boot`_
+#. `Interrupts and NMIs`_
+#. `Loadable Modules`_
+#. `Hotplug CPU`_
+#. `Scheduler and RCU`_
+#. `Tracing and RCU`_
+#. `Energy Efficiency`_
+#. `Scheduling-Clock Interrupts and RCU`_
+#. `Memory Efficiency`_
+#. `Performance, Scalability, Response Time, and Reliability`_
 
 This list is probably incomplete, but it does give a feel for the most
 notable Linux-kernel complications. Each of the following sections
@@ -2344,10 +2332,10 @@ implementations, non-preemptible and preemptible. The other four flavors
 are listed below, with requirements for each described in a separate
 section.
 
-#. `Bottom-Half Flavor (Historical) <#Bottom-Half%20Flavor>`__
-#. `Sched Flavor (Historical) <#Sched%20Flavor>`__
-#. `Sleepable RCU <#Sleepable%20RCU>`__
-#. `Tasks RCU <#Tasks%20RCU>`__
+#. `Bottom-Half Flavor (Historical)`_
+#. `Sched Flavor (Historical)`_
+#. `Sleepable RCU`_
+#. `Tasks RCU`_
 
 Bottom-Half Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.22.0.770.g0f2c4a37fd-goog

