Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FEC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B271A21871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="emQ/hvXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbfIGKvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:51:25 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:55148 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389098AbfIGKvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 06:51:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 87219404D5;
        Sat,  7 Sep 2019 12:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1567853479; x=1569667880; bh=i8w7LjKB4tOUg5tMud4
        hYP3mdSM5cQstrz/mfiLpV20=; b=emQ/hvXDnO56K0NYr5+vKhxNRQz1i81Ptby
        20OJhH2wvnNcjsVq5/cmjJujiKaA4L8oq4/kUOOjanS3eYZJTY8QEtFmPoqC3JIN
        RxUHAXVepjCQuyIWe3rRVqmqpVokMvEgOxjcAbr1Xpce5/T9AVSJuRj0oltZ7orE
        OtKF7mvTL9WkxRgIROaVe+iIZ/tYiMNXqG1N+D9B7fic8TcQlAXNNgAy2pnWG8kz
        Rwy7+kkiwrkWbnA6Yscj9g9q5gwUka3xfFKazUn0F8jUfM8S6U89Ar08F1d2EOz2
        Qfn05fV4FuLUSsZgM+lH65b7jxE/0NhykTJslIl4dlxwBwGHKLRMzPEwiNuZRMDI
        88JBdD9oDzrswMYBYZBdhu1bHlvIound69XHXbTE+Nx5dLRDiqofiaqyOiRgg3JW
        QUNmVfTwHzyDQpFPtfngE1F8EiIdei/tpNSlSldvdoE7YUU7xlFmMfl+lgISRFy6
        4RqhBvmY3B4CrvByXIpty589J4yE9FzDngPpgfp1vvFjM5eDYh5UY2yH+DgK6EXI
        E8cepjCZgaCFZVgmVaU14O8nU+GAqcSRSn0Ua0MyUrJzKH8k217/Dz4SSM4ZKTYl
        TfTyf+n6/FDtXYVloPJK30JrnIKDLDsGvvBduUGtpCSdmQEkrxpkqyHuoJMV1KIL
        0SIxge7M=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jMOGCgfi-Bzb; Sat,  7 Sep 2019 12:51:19 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 4CFF0403F4;
        Sat,  7 Sep 2019 12:51:19 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id E37A33CB7;
        Sat,  7 Sep 2019 12:51:18 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc: replace IFF abbreviation  with 'if and only if'
Date:   Sat,  7 Sep 2019 12:51:16 +0200
Message-Id: <20190907105116.19183-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a normal piece of text the use of 'iff' does not guarantee a correct
interpretation because it is easy to confuse it for a typo (if or iff?).

I believe that IFF should not be used outside a logical/mathematical
expression. For this reason with this patch I am replacing 'iff' with
'if an only if' in text, and I am leaving it as it is in logical formulae.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../admin-guide/cgroup-v1/blkio-controller.rst         |  2 +-
 Documentation/admin-guide/cgroup-v1/cgroups.rst        |  2 +-
 .../admin-guide/cgroup-v1/freezer-subsystem.rst        |  4 ++--
 Documentation/admin-guide/cgroup-v2.rst                |  2 +-
 Documentation/devicetree/bindings/media/st-rc.txt      |  4 ++--
 Documentation/devicetree/bindings/net/ibm,emac.txt     | 10 +++++-----
 .../devicetree/bindings/pinctrl/pinctrl-st.txt         |  2 +-
 Documentation/driver-api/libata.rst                    |  2 +-
 Documentation/i2c/i2c-topology.rst                     | 10 +++++-----
 Documentation/ioctl/hdio.rst                           |  2 +-
 Documentation/locking/spinlocks.rst                    |  4 ++--
 Documentation/locking/ww-mutex-design.rst              |  2 +-
 Documentation/scsi/scsi_eh.txt                         |  4 ++--
 Documentation/spi/spidev.rst                           |  4 ++--
 Documentation/virtual/kvm/api.txt                      |  2 +-
 Documentation/virtual/kvm/halt-polling.txt             |  2 +-
 16 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
index 36d43ae7dc13..8f187396c534 100644
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -52,7 +52,7 @@ Hierarchical Cgroups
 ====================
 
 Throttling implements hierarchy support; however,
-throttling's hierarchy support is enabled iff "sane_behavior" is
+throttling's hierarchy support is enabled if and only if "sane_behavior" is
 enabled from cgroup side, which currently is a development option and
 not publicly available.
 
diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
index b0688011ed06..15bb3ea6a597 100644
--- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
+++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
@@ -573,7 +573,7 @@ cgroup_for_each_descendant_pre() for details.
 ``void css_offline(struct cgroup *cgrp);``
 (cgroup_mutex held by caller)
 
-This is the counterpart of css_online() and called iff css_online()
+This is the counterpart of css_online() and called if and only if css_online()
 has succeeded on @cgrp. This signifies the beginning of the end of
 @cgrp. @cgrp is being removed and the subsystem should start dropping
 all references it's holding on @cgrp. When all references are dropped,
diff --git a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
index 582d3427de3f..1c49e87a14d3 100644
--- a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
+++ b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
@@ -56,7 +56,7 @@ expected.
 The cgroup freezer is hierarchical. Freezing a cgroup freezes all
 tasks belonging to the cgroup and all its descendant cgroups. Each
 cgroup has its own state (self-state) and the state inherited from the
-parent (parent-state). Iff both states are THAWED, the cgroup is
+parent (parent-state). If and only if both states are THAWED, the cgroup is
 THAWED.
 
 The following cgroupfs files are created by cgroup freezer.
@@ -87,7 +87,7 @@ The following cgroupfs files are created by cgroup freezer.
 * freezer.self_freezing: Read only.
 
   Shows the self-state. 0 if the self-state is THAWED; otherwise, 1.
-  This value is 1 iff the last write to freezer.state was "FROZEN".
+  This value is 1 if and only if the last write to freezer.state was "FROZEN".
 
 * freezer.parent_freezing: Read only.
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3b29005aa981..822f9e0971b7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1180,7 +1180,7 @@ PAGE_SIZE multiple when read back.
 		Failed allocation in its turn could be returned into
 		userspace as -ENOMEM or silently ignored in cases like
 		disk readahead.  For now OOM in memory cgroup kills
-		tasks iff shortage has happened inside page fault.
+		tasks if and only if shortage has happened inside page fault.
 
 		This event is not raised if the OOM killer is not
 		considered as an option, e.g. for failed high-order
diff --git a/Documentation/devicetree/bindings/media/st-rc.txt b/Documentation/devicetree/bindings/media/st-rc.txt
index 05c432d08bca..a9438902f6c6 100644
--- a/Documentation/devicetree/bindings/media/st-rc.txt
+++ b/Documentation/devicetree/bindings/media/st-rc.txt
@@ -9,10 +9,10 @@ Required properties:
 	  controller parent.
 	- rx-mode: can be "infrared" or "uhf". This property specifies the L1
 	  protocol used for receiving remote control signals. rx-mode should
-	  be present iff the rx pins are wired up.
+	  be present if and only if the rx pins are wired up.
 	- tx-mode: should be "infrared". This property specifies the L1
 	  protocol used for transmitting remote control signals. tx-mode should
-	  be present iff the tx pins are wired up.
+	  be present if and only if the tx pins are wired up.
 
 Optional properties:
 	- pinctrl-names, pinctrl-0: the pincontrol settings to configure muxing
diff --git a/Documentation/devicetree/bindings/net/ibm,emac.txt b/Documentation/devicetree/bindings/net/ibm,emac.txt
index c0c14aa3f97c..4f0f38edf205 100644
--- a/Documentation/devicetree/bindings/net/ibm,emac.txt
+++ b/Documentation/devicetree/bindings/net/ibm,emac.txt
@@ -45,17 +45,17 @@
 			  Supported values are: "mii", "rmii", "smii", "rgmii",
 			  "tbi", "gmii", rtbi", "sgmii".
 			  For Axon on CAB, it is "rgmii"
-    - mdio-device       : 1 cell, required iff using shared MDIO registers
+    - mdio-device       : 1 cell, required if and only if using shared MDIO registers
 			  (440EP).  phandle of the EMAC to use to drive the
 			  MDIO lines for the PHY used by this EMAC.
-    - zmii-device       : 1 cell, required iff connected to a ZMII.  phandle of
+    - zmii-device       : 1 cell, required if and only if connected to a ZMII.  phandle of
 			  the ZMII device node
-    - zmii-channel      : 1 cell, required iff connected to a ZMII.  Which ZMII
+    - zmii-channel      : 1 cell, required if and only if connected to a ZMII.  Which ZMII
 			  channel or 0xffffffff if ZMII is only used for MDIO.
-    - rgmii-device      : 1 cell, required iff connected to an RGMII. phandle
+    - rgmii-device      : 1 cell, required if and only if connected to an RGMII. phandle
 			  of the RGMII device node.
 			  For Axon: phandle of plb5/plb4/opb/rgmii
-    - rgmii-channel     : 1 cell, required iff connected to an RGMII.  Which
+    - rgmii-channel     : 1 cell, required if and only if connected to an RGMII.  Which
 			  RGMII channel is used by this EMAC.
 			  Fox Axon: present, whatever value is appropriate for each
 			  EMAC, that is the content of the current (bogus) "phy-port"
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
index 48b9be48af18..e56c28ba265f 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
@@ -62,7 +62,7 @@ Optional properties:
   interrupt wired up for this gpio bank.
 
 - interrupt-controller : Indicates this device is a interrupt controller. GPIO
-  bank can be an interrupt controller iff one of the interrupt type either via
+  bank can be an interrupt controller if and only if one of the interrupt type either via
 irqmux or a dedicated interrupt per bank is specified.
 
 - #interrupt-cells: the value of this property should be 2.
diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index 70e180e6b93d..8d2dab0d92cf 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -917,7 +917,7 @@ device depends on situation but the following scheme is recommended.
 
 HBA resetting is implementation specific. For a controller complying to
 taskfile/BMDMA PCI IDE, stopping active DMA transaction may be
-sufficient iff BMDMA state is the only HBA context. But even mostly
+sufficient if and only if BMDMA state is the only HBA context. But even mostly
 taskfile/BMDMA PCI IDE complying controllers may have implementation
 specific requirements and mechanism to reset themselves. This must be
 addressed by specific drivers.
diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index 0c1ae95f6a97..6c14675da52b 100644
--- a/Documentation/i2c/i2c-topology.rst
+++ b/Documentation/i2c/i2c-topology.rst
@@ -41,22 +41,22 @@ following list was correct at the time of writing:
 
 In drivers/i2c/muxes/:
 
-======================    =============================================
+======================    =================================================
 i2c-arb-gpio-challenge    Parent-locked
-i2c-mux-gpio              Normally parent-locked, mux-locked iff
+i2c-mux-gpio              Normally parent-locked, mux-locked if and only if
                           all involved gpio pins are controlled by the
                           same i2c root adapter that they mux.
-i2c-mux-gpmux             Normally parent-locked, mux-locked iff
+i2c-mux-gpmux             Normally parent-locked, mux-locked if and only if
                           specified in device-tree.
 i2c-mux-ltc4306           Mux-locked
 i2c-mux-mlxcpld           Parent-locked
 i2c-mux-pca9541           Parent-locked
 i2c-mux-pca954x           Parent-locked
-i2c-mux-pinctrl           Normally parent-locked, mux-locked iff
+i2c-mux-pinctrl           Normally parent-locked, mux-locked if and only if
                           all involved pinctrl devices are controlled
                           by the same i2c root adapter that they mux.
 i2c-mux-reg               Parent-locked
-======================    =============================================
+======================    =================================================
 
 In drivers/iio/:
 
diff --git a/Documentation/ioctl/hdio.rst b/Documentation/ioctl/hdio.rst
index e822e3dff176..ad02f450d057 100644
--- a/Documentation/ioctl/hdio.rst
+++ b/Documentation/ioctl/hdio.rst
@@ -830,7 +830,7 @@ HDIO_DRIVE_TASKFILE
 	    ============	===============================================
 
 	  Taskfile registers are read back from the drive into
-	  {io|hob}_ports[] after the command completes iff one of the
+	  {io|hob}_ports[] after the command completes if and only if one of the
 	  following conditions is met; otherwise, the original values
 	  will be written back, unchanged.
 
diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
index 66e3792f8a36..895a24cd3f1c 100644
--- a/Documentation/locking/spinlocks.rst
+++ b/Documentation/locking/spinlocks.rst
@@ -106,8 +106,8 @@ and on other architectures it can be worse).
 
 If you have a case where you have to protect a data structure across
 several CPU's and you want to use spinlocks you can potentially use
-cheaper versions of the spinlocks. IFF you know that the spinlocks are
-never used in interrupt handlers, you can use the non-irq versions::
+cheaper versions of the spinlocks. If and only if you know that the spinlocks
+are never used in interrupt handlers, you can use the non-irq versions::
 
 	spin_lock(&lock);
 	...
diff --git a/Documentation/locking/ww-mutex-design.rst b/Documentation/locking/ww-mutex-design.rst
index 1846c199da23..6e5a7e460e73 100644
--- a/Documentation/locking/ww-mutex-design.rst
+++ b/Documentation/locking/ww-mutex-design.rst
@@ -112,7 +112,7 @@ Usage
 
 The algorithm (Wait-Die vs Wound-Wait) is chosen by using either
 DEFINE_WW_CLASS() (Wound-Wait) or DEFINE_WD_CLASS() (Wait-Die)
-As a rough rule of thumb, use Wound-Wait iff you
+As a rough rule of thumb, use Wound-Wait if and only if you
 expect the number of simultaneous competing transactions to be typically small,
 and you want to reduce the number of rollbacks.
 
diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
index 1b7436932a2b..035f76730565 100644
--- a/Documentation/scsi/scsi_eh.txt
+++ b/Documentation/scsi/scsi_eh.txt
@@ -214,7 +214,7 @@ all unrecovered devices.
    scmds.  e.g. resetting a device recovers all failed scmds on the
    device.
 
- - Higher severity actions are taken iff eh_work_q is not empty after
+ - Higher severity actions are taken if and only if eh_work_q is not empty after
    lower severity actions are complete.
 
  - EH reuses failed scmds to issue commands for recovery.  For
@@ -227,7 +227,7 @@ recovered (eh_work_q is empty), scsi_eh_flush_done_q() is invoked to
 either retry or error-finish (notify upper layer of failure) recovered
 scmds.
 
- scmds are retried iff its sdev is still online (not offlined during
+ scmds are retried if and only if its sdev is still online (not offlined during
 EH), REQ_FAILFAST is not set and ++scmd->retries is less than
 scmd->allowed.
 
diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
index f05dbc5ccdbc..1b549f966365 100644
--- a/Documentation/spi/spidev.rst
+++ b/Documentation/spi/spidev.rst
@@ -93,8 +93,8 @@ settings for data transfer parameters:
 	pass a pointer to a byte which will
 	return (RD) or assign (WR) the SPI transfer mode.  Use the constants
 	SPI_MODE_0..SPI_MODE_3; or if you prefer you can combine SPI_CPOL
-	(clock polarity, idle high iff this is set) or SPI_CPHA (clock phase,
-	sample on trailing edge iff this is set) flags.
+	(clock polarity, idle high if and only if this is set) or SPI_CPHA (clock phase,
+	sample on trailing edge if and only if this is set) flags.
 	Note that this request is limited to SPI mode flags that fit in a
 	single byte.
 
diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index e54a3f51ddc5..1e5b519f5f6f 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -5014,7 +5014,7 @@ kvm_vcpu_events, which allows userspace to distinguish between pending
 and injected exceptions.
 
 
-* For the new DR6 bits, note that bit 16 is set iff the #DB exception
+* For the new DR6 bits, note that bit 16 is set if and only if the #DB exception
   will clear DR6.RTM.
 
 7.18 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
diff --git a/Documentation/virtual/kvm/halt-polling.txt b/Documentation/virtual/kvm/halt-polling.txt
index 4f791b128dd2..4bc425b6769b 100644
--- a/Documentation/virtual/kvm/halt-polling.txt
+++ b/Documentation/virtual/kvm/halt-polling.txt
@@ -61,7 +61,7 @@ interval then the host will never poll for long enough (limited by the global
 max) to wakeup during the polling interval so it may as well be shrunk in order
 to avoid pointless polling. The polling interval is shrunk in the function
 shrink_halt_poll_ns() and is divided by the module parameter
-halt_poll_ns_shrink, or set to 0 iff halt_poll_ns_shrink == 0.
+halt_poll_ns_shrink, or set to 0 if and only if halt_poll_ns_shrink == 0.
 
 It is worth noting that this adjustment process attempts to hone in on some
 steady state polling interval but will only really do a good job for wakeups
-- 
2.21.0

