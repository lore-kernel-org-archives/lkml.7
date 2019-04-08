Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D6C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885A20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742764;
	bh=6wN5KXvCK7L4vBLdVs0VulkGJ54SQBa4YNyjP2bMa3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wO/qLUoy6kBdqKF8M1yWU6usSYjK6efWkbw7i/c07e87Zy5H1I4Cf8P+9rYfsYM+D
	 CEbn/RbTb3oStkLGEMx+GiQAYugkzal1IR9AuzrPiQ39h945vsJzbt47FkvA/zxFWT
	 GygRovXGaqOrId+aeavFaQgSDjl1AJTQJZOP6Pv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfDHQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:59:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfDHQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4sXiFtLpXeSvsRWAfRCRzez8THno7sWJyn162AgckMs=; b=CBrqcYHoy32CdejMkExYdowxG/
        OHFBu1hmf6k6xvDn9Ay5pAuL3EDj5WMRVk40vbTGGwgtAhSIDxfCX/8znU5mI9M/1MaDmR2kXdbP8
        5gV7hgutpZSkKWxhfD+P154L5pOrISoAv8uiP4TjcGZQIP3SU8APQHhsBsxhF4lJIvL7C/dU6ZkTt
        IORFhty5bY9PCXN9g2i73b99VsXIPqDle5un5h7zwhCeTtbcjz4aqeF9h7y0KTU2RWVdZMOUMjhFm
        dB0/85i3X27Kitq3ratnoBTYtD+xGMJAenvjy5jvOeXiva+fRrQCB4mUXWHdRtdyskvg2ZHouBFzN
        Hu5FBjXw==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Sp-7c; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005nP-An; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/10] docs: Add all txt files to documentation
Date:   Mon,  8 Apr 2019 13:58:23 -0300
Message-Id: <d70a2426b9ec33d22c83c18a300efd4148e636aa.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow generating documentation for all files

There are two text files that would require a lot of extra effort
to be parsed by Sphinx, and whose authors strongly prefer to not
do that. So, add those as plain text files. That makes those two
files a little ackward at the html/pdf output, but at least everything
will be there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst                       |   9 ++
 .../DMA-API-HOWTO.rst}                        |   0
 .../{DMA-API.txt => other/DMA-API.rst}        |   0
 .../DMA-ISA-LPC.rst}                          |   0
 .../DMA-attributes.rst}                       |   0
 Documentation/{IPMI.txt => other/IPMI.rst}    |   0
 .../IRQ-affinity.rst}                         |   0
 .../{IRQ-domain.txt => other/IRQ-domain.rst}  |   0
 Documentation/{IRQ.txt => other/IRQ.rst}      |   0
 .../Intel-IOMMU.rst}                          |   0
 Documentation/{SAK.txt => other/SAK.rst}      |   0
 Documentation/{SM501.txt => other/SM501.rst}  |   0
 .../atomic_bitops.rst}                        |   0
 Documentation/{ => other}/atomic_t.txt        |   0
 .../{bt8xxgpio.txt => other/bt8xxgpio.rst}    |   0
 .../{btmrvl.txt => other/btmrvl.rst}          |   0
 .../bus-virt-phys-mapping.rst}                |   0
 .../clearing-warn-once.rst}                   |   0
 .../{cpu-load.txt => other/cpu-load.rst}      |   0
 .../cputopology.rst}                          |   0
 Documentation/{crc32.txt => other/crc32.rst}  |   0
 .../{dcdbas.txt => other/dcdbas.rst}          |   0
 .../debugging-modules.rst}                    |   0
 .../debugging-via-ohci1394.rst}               |   0
 .../{dell_rbu.txt => other/dell_rbu.rst}      |   0
 .../{digsig.txt => other/digsig.rst}          |   0
 .../{efi-stub.txt => other/efi-stub.rst}      |   0
 Documentation/{eisa.txt => other/eisa.rst}    |   0
 .../futex-requeue-pi.rst}                     |   0
 .../gcc-plugins.rst}                          |   0
 .../{highuid.txt => other/highuid.rst}        |   0
 .../{hw_random.txt => other/hw_random.rst}    |   0
 .../{hwspinlock.txt => other/hwspinlock.rst}  |   0
 Documentation/other/index.rst                 | 100 ++++++++++++++++++
 .../{intel_txt.txt => other/intel_txt.rst}    |   0
 .../{io-mapping.txt => other/io-mapping.rst}  |   0
 .../io_ordering.rst}                          |   0
 .../{iostats.txt => other/iostats.rst}        |   0
 .../irqflags-tracing.rst}                     |   0
 Documentation/{isa.txt => other/isa.rst}      |   0
 .../{isapnp.txt => other/isapnp.rst}          |   0
 .../kernel-per-CPU-kthreads.rst}              |   0
 .../{kobject.txt => other/kobject.rst}        |   0
 .../{kprobes.txt => other/kprobes.rst}        |   0
 Documentation/{kref.txt => other/kref.rst}    |   0
 Documentation/{ldm.txt => other/ldm.rst}      |   0
 .../lockup-watchdogs.rst}                     |   0
 Documentation/{lsm.txt => other/lsm.rst}      |   0
 Documentation/{lzo.txt => other/lzo.rst}      |   0
 .../{mailbox.txt => other/mailbox.rst}        |   0
 Documentation/{ => other}/memory-barriers.txt |   0
 .../men-chameleon-bus.rst}                    |   0
 .../{nommu-mmap.txt => other/nommu-mmap.rst}  |   0
 Documentation/{ntb.txt => other/ntb.rst}      |   0
 .../{numastat.txt => other/numastat.rst}      |   0
 .../{padata.txt => other/padata.rst}          |   0
 .../parport-lowlevel.rst}                     |   0
 .../percpu-rw-semaphore.rst}                  |   0
 Documentation/{phy.txt => other/phy.rst}      |   0
 .../{pi-futex.txt => other/pi-futex.rst}      |   0
 Documentation/{pnp.txt => other/pnp.rst}      |   0
 .../preempt-locking.rst}                      |   0
 Documentation/{pwm.txt => other/pwm.rst}      |   0
 .../{rbtree.txt => other/rbtree.rst}          |   0
 .../{remoteproc.txt => other/remoteproc.rst}  |   0
 .../{rfkill.txt => other/rfkill.rst}          |   0
 .../robust-futex-ABI.rst}                     |   0
 .../robust-futexes.rst}                       |   0
 Documentation/{rpmsg.txt => other/rpmsg.rst}  |   0
 Documentation/{rtc.txt => other/rtc.rst}      |   0
 .../{sgi-ioc4.txt => other/sgi-ioc4.rst}      |   0
 .../{siphash.txt => other/siphash.rst}        |   0
 .../smsc_ece1099.rst}                         |   0
 .../speculation.rst}                          |   0
 .../static-keys.rst}                          |   0
 Documentation/{svga.txt => other/svga.rst}    |   0
 .../{switchtec.txt => other/switchtec.rst}    |   0
 .../{sync_file.txt => other/sync_file.rst}    |   0
 Documentation/{tee.txt => other/tee.rst}      |   0
 Documentation/other/text_files.rst            |  12 +++
 .../this_cpu_ops.rst}                         |   0
 .../unaligned-memory-access.rst}              |   0
 .../vfio-mediated-device.rst}                 |   0
 Documentation/{vfio.txt => other/vfio.rst}    |   0
 .../video-output.rst}                         |   0
 .../{xillybus.txt => other/xillybus.rst}      |   0
 Documentation/{xz.txt => other/xz.rst}        |   0
 Documentation/{zorro.txt => other/zorro.rst}  |   0
 88 files changed, 121 insertions(+)
 rename Documentation/{DMA-API-HOWTO.txt => other/DMA-API-HOWTO.rst} (100%)
 rename Documentation/{DMA-API.txt => other/DMA-API.rst} (100%)
 rename Documentation/{DMA-ISA-LPC.txt => other/DMA-ISA-LPC.rst} (100%)
 rename Documentation/{DMA-attributes.txt => other/DMA-attributes.rst} (100%)
 rename Documentation/{IPMI.txt => other/IPMI.rst} (100%)
 rename Documentation/{IRQ-affinity.txt => other/IRQ-affinity.rst} (100%)
 rename Documentation/{IRQ-domain.txt => other/IRQ-domain.rst} (100%)
 rename Documentation/{IRQ.txt => other/IRQ.rst} (100%)
 rename Documentation/{Intel-IOMMU.txt => other/Intel-IOMMU.rst} (100%)
 rename Documentation/{SAK.txt => other/SAK.rst} (100%)
 rename Documentation/{SM501.txt => other/SM501.rst} (100%)
 rename Documentation/{atomic_bitops.txt => other/atomic_bitops.rst} (100%)
 rename Documentation/{ => other}/atomic_t.txt (100%)
 rename Documentation/{bt8xxgpio.txt => other/bt8xxgpio.rst} (100%)
 rename Documentation/{btmrvl.txt => other/btmrvl.rst} (100%)
 rename Documentation/{bus-virt-phys-mapping.txt => other/bus-virt-phys-mapping.rst} (100%)
 rename Documentation/{clearing-warn-once.txt => other/clearing-warn-once.rst} (100%)
 rename Documentation/{cpu-load.txt => other/cpu-load.rst} (100%)
 rename Documentation/{cputopology.txt => other/cputopology.rst} (100%)
 rename Documentation/{crc32.txt => other/crc32.rst} (100%)
 rename Documentation/{dcdbas.txt => other/dcdbas.rst} (100%)
 rename Documentation/{debugging-modules.txt => other/debugging-modules.rst} (100%)
 rename Documentation/{debugging-via-ohci1394.txt => other/debugging-via-ohci1394.rst} (100%)
 rename Documentation/{dell_rbu.txt => other/dell_rbu.rst} (100%)
 rename Documentation/{digsig.txt => other/digsig.rst} (100%)
 rename Documentation/{efi-stub.txt => other/efi-stub.rst} (100%)
 rename Documentation/{eisa.txt => other/eisa.rst} (100%)
 rename Documentation/{futex-requeue-pi.txt => other/futex-requeue-pi.rst} (100%)
 rename Documentation/{gcc-plugins.txt => other/gcc-plugins.rst} (100%)
 rename Documentation/{highuid.txt => other/highuid.rst} (100%)
 rename Documentation/{hw_random.txt => other/hw_random.rst} (100%)
 rename Documentation/{hwspinlock.txt => other/hwspinlock.rst} (100%)
 create mode 100644 Documentation/other/index.rst
 rename Documentation/{intel_txt.txt => other/intel_txt.rst} (100%)
 rename Documentation/{io-mapping.txt => other/io-mapping.rst} (100%)
 rename Documentation/{io_ordering.txt => other/io_ordering.rst} (100%)
 rename Documentation/{iostats.txt => other/iostats.rst} (100%)
 rename Documentation/{irqflags-tracing.txt => other/irqflags-tracing.rst} (100%)
 rename Documentation/{isa.txt => other/isa.rst} (100%)
 rename Documentation/{isapnp.txt => other/isapnp.rst} (100%)
 rename Documentation/{kernel-per-CPU-kthreads.txt => other/kernel-per-CPU-kthreads.rst} (100%)
 rename Documentation/{kobject.txt => other/kobject.rst} (100%)
 rename Documentation/{kprobes.txt => other/kprobes.rst} (100%)
 rename Documentation/{kref.txt => other/kref.rst} (100%)
 rename Documentation/{ldm.txt => other/ldm.rst} (100%)
 rename Documentation/{lockup-watchdogs.txt => other/lockup-watchdogs.rst} (100%)
 rename Documentation/{lsm.txt => other/lsm.rst} (100%)
 rename Documentation/{lzo.txt => other/lzo.rst} (100%)
 rename Documentation/{mailbox.txt => other/mailbox.rst} (100%)
 rename Documentation/{ => other}/memory-barriers.txt (100%)
 rename Documentation/{men-chameleon-bus.txt => other/men-chameleon-bus.rst} (100%)
 rename Documentation/{nommu-mmap.txt => other/nommu-mmap.rst} (100%)
 rename Documentation/{ntb.txt => other/ntb.rst} (100%)
 rename Documentation/{numastat.txt => other/numastat.rst} (100%)
 rename Documentation/{padata.txt => other/padata.rst} (100%)
 rename Documentation/{parport-lowlevel.txt => other/parport-lowlevel.rst} (100%)
 rename Documentation/{percpu-rw-semaphore.txt => other/percpu-rw-semaphore.rst} (100%)
 rename Documentation/{phy.txt => other/phy.rst} (100%)
 rename Documentation/{pi-futex.txt => other/pi-futex.rst} (100%)
 rename Documentation/{pnp.txt => other/pnp.rst} (100%)
 rename Documentation/{preempt-locking.txt => other/preempt-locking.rst} (100%)
 rename Documentation/{pwm.txt => other/pwm.rst} (100%)
 rename Documentation/{rbtree.txt => other/rbtree.rst} (100%)
 rename Documentation/{remoteproc.txt => other/remoteproc.rst} (100%)
 rename Documentation/{rfkill.txt => other/rfkill.rst} (100%)
 rename Documentation/{robust-futex-ABI.txt => other/robust-futex-ABI.rst} (100%)
 rename Documentation/{robust-futexes.txt => other/robust-futexes.rst} (100%)
 rename Documentation/{rpmsg.txt => other/rpmsg.rst} (100%)
 rename Documentation/{rtc.txt => other/rtc.rst} (100%)
 rename Documentation/{sgi-ioc4.txt => other/sgi-ioc4.rst} (100%)
 rename Documentation/{siphash.txt => other/siphash.rst} (100%)
 rename Documentation/{smsc_ece1099.txt => other/smsc_ece1099.rst} (100%)
 rename Documentation/{speculation.txt => other/speculation.rst} (100%)
 rename Documentation/{static-keys.txt => other/static-keys.rst} (100%)
 rename Documentation/{svga.txt => other/svga.rst} (100%)
 rename Documentation/{switchtec.txt => other/switchtec.rst} (100%)
 rename Documentation/{sync_file.txt => other/sync_file.rst} (100%)
 rename Documentation/{tee.txt => other/tee.rst} (100%)
 create mode 100644 Documentation/other/text_files.rst
 rename Documentation/{this_cpu_ops.txt => other/this_cpu_ops.rst} (100%)
 rename Documentation/{unaligned-memory-access.txt => other/unaligned-memory-access.rst} (100%)
 rename Documentation/{vfio-mediated-device.txt => other/vfio-mediated-device.rst} (100%)
 rename Documentation/{vfio.txt => other/vfio.rst} (100%)
 rename Documentation/{video-output.txt => other/video-output.rst} (100%)
 rename Documentation/{xillybus.txt => other/xillybus.rst} (100%)
 rename Documentation/{xz.txt => other/xz.rst} (100%)
 rename Documentation/{zorro.txt => other/zorro.rst} (100%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..02195dff3344 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -122,6 +122,15 @@ Translations
 
    translations/index
 
+Other random documents
+----------------------
+
+.. toctree::
+   :maxdepth: 2
+
+   other/index
+
+
 Indices and tables
 ==================
 
diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/other/DMA-API-HOWTO.rst
similarity index 100%
rename from Documentation/DMA-API-HOWTO.txt
rename to Documentation/other/DMA-API-HOWTO.rst
diff --git a/Documentation/DMA-API.txt b/Documentation/other/DMA-API.rst
similarity index 100%
rename from Documentation/DMA-API.txt
rename to Documentation/other/DMA-API.rst
diff --git a/Documentation/DMA-ISA-LPC.txt b/Documentation/other/DMA-ISA-LPC.rst
similarity index 100%
rename from Documentation/DMA-ISA-LPC.txt
rename to Documentation/other/DMA-ISA-LPC.rst
diff --git a/Documentation/DMA-attributes.txt b/Documentation/other/DMA-attributes.rst
similarity index 100%
rename from Documentation/DMA-attributes.txt
rename to Documentation/other/DMA-attributes.rst
diff --git a/Documentation/IPMI.txt b/Documentation/other/IPMI.rst
similarity index 100%
rename from Documentation/IPMI.txt
rename to Documentation/other/IPMI.rst
diff --git a/Documentation/IRQ-affinity.txt b/Documentation/other/IRQ-affinity.rst
similarity index 100%
rename from Documentation/IRQ-affinity.txt
rename to Documentation/other/IRQ-affinity.rst
diff --git a/Documentation/IRQ-domain.txt b/Documentation/other/IRQ-domain.rst
similarity index 100%
rename from Documentation/IRQ-domain.txt
rename to Documentation/other/IRQ-domain.rst
diff --git a/Documentation/IRQ.txt b/Documentation/other/IRQ.rst
similarity index 100%
rename from Documentation/IRQ.txt
rename to Documentation/other/IRQ.rst
diff --git a/Documentation/Intel-IOMMU.txt b/Documentation/other/Intel-IOMMU.rst
similarity index 100%
rename from Documentation/Intel-IOMMU.txt
rename to Documentation/other/Intel-IOMMU.rst
diff --git a/Documentation/SAK.txt b/Documentation/other/SAK.rst
similarity index 100%
rename from Documentation/SAK.txt
rename to Documentation/other/SAK.rst
diff --git a/Documentation/SM501.txt b/Documentation/other/SM501.rst
similarity index 100%
rename from Documentation/SM501.txt
rename to Documentation/other/SM501.rst
diff --git a/Documentation/atomic_bitops.txt b/Documentation/other/atomic_bitops.rst
similarity index 100%
rename from Documentation/atomic_bitops.txt
rename to Documentation/other/atomic_bitops.rst
diff --git a/Documentation/atomic_t.txt b/Documentation/other/atomic_t.txt
similarity index 100%
rename from Documentation/atomic_t.txt
rename to Documentation/other/atomic_t.txt
diff --git a/Documentation/bt8xxgpio.txt b/Documentation/other/bt8xxgpio.rst
similarity index 100%
rename from Documentation/bt8xxgpio.txt
rename to Documentation/other/bt8xxgpio.rst
diff --git a/Documentation/btmrvl.txt b/Documentation/other/btmrvl.rst
similarity index 100%
rename from Documentation/btmrvl.txt
rename to Documentation/other/btmrvl.rst
diff --git a/Documentation/bus-virt-phys-mapping.txt b/Documentation/other/bus-virt-phys-mapping.rst
similarity index 100%
rename from Documentation/bus-virt-phys-mapping.txt
rename to Documentation/other/bus-virt-phys-mapping.rst
diff --git a/Documentation/clearing-warn-once.txt b/Documentation/other/clearing-warn-once.rst
similarity index 100%
rename from Documentation/clearing-warn-once.txt
rename to Documentation/other/clearing-warn-once.rst
diff --git a/Documentation/cpu-load.txt b/Documentation/other/cpu-load.rst
similarity index 100%
rename from Documentation/cpu-load.txt
rename to Documentation/other/cpu-load.rst
diff --git a/Documentation/cputopology.txt b/Documentation/other/cputopology.rst
similarity index 100%
rename from Documentation/cputopology.txt
rename to Documentation/other/cputopology.rst
diff --git a/Documentation/crc32.txt b/Documentation/other/crc32.rst
similarity index 100%
rename from Documentation/crc32.txt
rename to Documentation/other/crc32.rst
diff --git a/Documentation/dcdbas.txt b/Documentation/other/dcdbas.rst
similarity index 100%
rename from Documentation/dcdbas.txt
rename to Documentation/other/dcdbas.rst
diff --git a/Documentation/debugging-modules.txt b/Documentation/other/debugging-modules.rst
similarity index 100%
rename from Documentation/debugging-modules.txt
rename to Documentation/other/debugging-modules.rst
diff --git a/Documentation/debugging-via-ohci1394.txt b/Documentation/other/debugging-via-ohci1394.rst
similarity index 100%
rename from Documentation/debugging-via-ohci1394.txt
rename to Documentation/other/debugging-via-ohci1394.rst
diff --git a/Documentation/dell_rbu.txt b/Documentation/other/dell_rbu.rst
similarity index 100%
rename from Documentation/dell_rbu.txt
rename to Documentation/other/dell_rbu.rst
diff --git a/Documentation/digsig.txt b/Documentation/other/digsig.rst
similarity index 100%
rename from Documentation/digsig.txt
rename to Documentation/other/digsig.rst
diff --git a/Documentation/efi-stub.txt b/Documentation/other/efi-stub.rst
similarity index 100%
rename from Documentation/efi-stub.txt
rename to Documentation/other/efi-stub.rst
diff --git a/Documentation/eisa.txt b/Documentation/other/eisa.rst
similarity index 100%
rename from Documentation/eisa.txt
rename to Documentation/other/eisa.rst
diff --git a/Documentation/futex-requeue-pi.txt b/Documentation/other/futex-requeue-pi.rst
similarity index 100%
rename from Documentation/futex-requeue-pi.txt
rename to Documentation/other/futex-requeue-pi.rst
diff --git a/Documentation/gcc-plugins.txt b/Documentation/other/gcc-plugins.rst
similarity index 100%
rename from Documentation/gcc-plugins.txt
rename to Documentation/other/gcc-plugins.rst
diff --git a/Documentation/highuid.txt b/Documentation/other/highuid.rst
similarity index 100%
rename from Documentation/highuid.txt
rename to Documentation/other/highuid.rst
diff --git a/Documentation/hw_random.txt b/Documentation/other/hw_random.rst
similarity index 100%
rename from Documentation/hw_random.txt
rename to Documentation/other/hw_random.rst
diff --git a/Documentation/hwspinlock.txt b/Documentation/other/hwspinlock.rst
similarity index 100%
rename from Documentation/hwspinlock.txt
rename to Documentation/other/hwspinlock.rst
diff --git a/Documentation/other/index.rst b/Documentation/other/index.rst
new file mode 100644
index 000000000000..1c294687412a
--- /dev/null
+++ b/Documentation/other/index.rst
@@ -0,0 +1,100 @@
+.. _other_docs:
+
+=================
+Other Kernel docs
+=================
+
+.. toctree::
+    :maxdepth: 1
+
+    atomic_bitops.rst
+    bt8xxgpio.rst
+    btmrvl.rst
+    bus-virt-phys-mapping.rst
+    clearing-warn-once.rst
+    cpu-load.rst
+    cputopology.rst
+    crc32.rst
+    dcdbas.rst
+    debugging-modules.rst
+    debugging-via-ohci1394.rst
+    dell_rbu.rst
+    digsig.rst
+    DMA-API-HOWTO.rst
+    DMA-API.rst
+    DMA-attributes.rst
+    DMA-ISA-LPC.rst
+    efi-stub.rst
+    eisa.rst
+    futex-requeue-pi.rst
+    gcc-plugins.rst
+    highuid.rst
+    hw_random.rst
+    hwspinlock.rst
+    Intel-IOMMU.rst
+    intel_txt.rst
+    io-mapping.rst
+    io_ordering.rst
+    iostats.rst
+    IPMI.rst
+    IRQ-affinity.rst
+    IRQ-domain.rst
+    irqflags-tracing.rst
+    IRQ.rst
+    isapnp.rst
+    isa.rst
+    kernel-per-CPU-kthreads.rst
+    kobject.rst
+    kprobes.rst
+    kref.rst
+    ldm.rst
+    lockup-watchdogs.rst
+    lsm.rst
+    lzo.rst
+    mailbox.rst
+    men-chameleon-bus.rst
+    nommu-mmap.rst
+    ntb.rst
+    numastat.rst
+    padata.rst
+    parport-lowlevel.rst
+    percpu-rw-semaphore.rst
+    phy.rst
+    pi-futex.rst
+    pnp.rst
+    preempt-locking.rst
+    pwm.rst
+    rbtree.rst
+    remoteproc.rst
+    rfkill.rst
+    robust-futex-ABI.rst
+    robust-futexes.rst
+    rpmsg.rst
+    rtc.rst
+    SAK.rst
+    sgi-ioc4.rst
+    siphash.rst
+    SM501.rst
+    smsc_ece1099.rst
+    speculation.rst
+    static-keys.rst
+    svga.rst
+    switchtec.rst
+    sync_file.rst
+    tee.rst
+    this_cpu_ops.rst
+    unaligned-memory-access.rst
+    vfio-mediated-device.rst
+    vfio.rst
+    video-output.rst
+    xillybus.rst
+    xz.rst
+    zorro.rst
+    text_files.rst
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/intel_txt.txt b/Documentation/other/intel_txt.rst
similarity index 100%
rename from Documentation/intel_txt.txt
rename to Documentation/other/intel_txt.rst
diff --git a/Documentation/io-mapping.txt b/Documentation/other/io-mapping.rst
similarity index 100%
rename from Documentation/io-mapping.txt
rename to Documentation/other/io-mapping.rst
diff --git a/Documentation/io_ordering.txt b/Documentation/other/io_ordering.rst
similarity index 100%
rename from Documentation/io_ordering.txt
rename to Documentation/other/io_ordering.rst
diff --git a/Documentation/iostats.txt b/Documentation/other/iostats.rst
similarity index 100%
rename from Documentation/iostats.txt
rename to Documentation/other/iostats.rst
diff --git a/Documentation/irqflags-tracing.txt b/Documentation/other/irqflags-tracing.rst
similarity index 100%
rename from Documentation/irqflags-tracing.txt
rename to Documentation/other/irqflags-tracing.rst
diff --git a/Documentation/isa.txt b/Documentation/other/isa.rst
similarity index 100%
rename from Documentation/isa.txt
rename to Documentation/other/isa.rst
diff --git a/Documentation/isapnp.txt b/Documentation/other/isapnp.rst
similarity index 100%
rename from Documentation/isapnp.txt
rename to Documentation/other/isapnp.rst
diff --git a/Documentation/kernel-per-CPU-kthreads.txt b/Documentation/other/kernel-per-CPU-kthreads.rst
similarity index 100%
rename from Documentation/kernel-per-CPU-kthreads.txt
rename to Documentation/other/kernel-per-CPU-kthreads.rst
diff --git a/Documentation/kobject.txt b/Documentation/other/kobject.rst
similarity index 100%
rename from Documentation/kobject.txt
rename to Documentation/other/kobject.rst
diff --git a/Documentation/kprobes.txt b/Documentation/other/kprobes.rst
similarity index 100%
rename from Documentation/kprobes.txt
rename to Documentation/other/kprobes.rst
diff --git a/Documentation/kref.txt b/Documentation/other/kref.rst
similarity index 100%
rename from Documentation/kref.txt
rename to Documentation/other/kref.rst
diff --git a/Documentation/ldm.txt b/Documentation/other/ldm.rst
similarity index 100%
rename from Documentation/ldm.txt
rename to Documentation/other/ldm.rst
diff --git a/Documentation/lockup-watchdogs.txt b/Documentation/other/lockup-watchdogs.rst
similarity index 100%
rename from Documentation/lockup-watchdogs.txt
rename to Documentation/other/lockup-watchdogs.rst
diff --git a/Documentation/lsm.txt b/Documentation/other/lsm.rst
similarity index 100%
rename from Documentation/lsm.txt
rename to Documentation/other/lsm.rst
diff --git a/Documentation/lzo.txt b/Documentation/other/lzo.rst
similarity index 100%
rename from Documentation/lzo.txt
rename to Documentation/other/lzo.rst
diff --git a/Documentation/mailbox.txt b/Documentation/other/mailbox.rst
similarity index 100%
rename from Documentation/mailbox.txt
rename to Documentation/other/mailbox.rst
diff --git a/Documentation/memory-barriers.txt b/Documentation/other/memory-barriers.txt
similarity index 100%
rename from Documentation/memory-barriers.txt
rename to Documentation/other/memory-barriers.txt
diff --git a/Documentation/men-chameleon-bus.txt b/Documentation/other/men-chameleon-bus.rst
similarity index 100%
rename from Documentation/men-chameleon-bus.txt
rename to Documentation/other/men-chameleon-bus.rst
diff --git a/Documentation/nommu-mmap.txt b/Documentation/other/nommu-mmap.rst
similarity index 100%
rename from Documentation/nommu-mmap.txt
rename to Documentation/other/nommu-mmap.rst
diff --git a/Documentation/ntb.txt b/Documentation/other/ntb.rst
similarity index 100%
rename from Documentation/ntb.txt
rename to Documentation/other/ntb.rst
diff --git a/Documentation/numastat.txt b/Documentation/other/numastat.rst
similarity index 100%
rename from Documentation/numastat.txt
rename to Documentation/other/numastat.rst
diff --git a/Documentation/padata.txt b/Documentation/other/padata.rst
similarity index 100%
rename from Documentation/padata.txt
rename to Documentation/other/padata.rst
diff --git a/Documentation/parport-lowlevel.txt b/Documentation/other/parport-lowlevel.rst
similarity index 100%
rename from Documentation/parport-lowlevel.txt
rename to Documentation/other/parport-lowlevel.rst
diff --git a/Documentation/percpu-rw-semaphore.txt b/Documentation/other/percpu-rw-semaphore.rst
similarity index 100%
rename from Documentation/percpu-rw-semaphore.txt
rename to Documentation/other/percpu-rw-semaphore.rst
diff --git a/Documentation/phy.txt b/Documentation/other/phy.rst
similarity index 100%
rename from Documentation/phy.txt
rename to Documentation/other/phy.rst
diff --git a/Documentation/pi-futex.txt b/Documentation/other/pi-futex.rst
similarity index 100%
rename from Documentation/pi-futex.txt
rename to Documentation/other/pi-futex.rst
diff --git a/Documentation/pnp.txt b/Documentation/other/pnp.rst
similarity index 100%
rename from Documentation/pnp.txt
rename to Documentation/other/pnp.rst
diff --git a/Documentation/preempt-locking.txt b/Documentation/other/preempt-locking.rst
similarity index 100%
rename from Documentation/preempt-locking.txt
rename to Documentation/other/preempt-locking.rst
diff --git a/Documentation/pwm.txt b/Documentation/other/pwm.rst
similarity index 100%
rename from Documentation/pwm.txt
rename to Documentation/other/pwm.rst
diff --git a/Documentation/rbtree.txt b/Documentation/other/rbtree.rst
similarity index 100%
rename from Documentation/rbtree.txt
rename to Documentation/other/rbtree.rst
diff --git a/Documentation/remoteproc.txt b/Documentation/other/remoteproc.rst
similarity index 100%
rename from Documentation/remoteproc.txt
rename to Documentation/other/remoteproc.rst
diff --git a/Documentation/rfkill.txt b/Documentation/other/rfkill.rst
similarity index 100%
rename from Documentation/rfkill.txt
rename to Documentation/other/rfkill.rst
diff --git a/Documentation/robust-futex-ABI.txt b/Documentation/other/robust-futex-ABI.rst
similarity index 100%
rename from Documentation/robust-futex-ABI.txt
rename to Documentation/other/robust-futex-ABI.rst
diff --git a/Documentation/robust-futexes.txt b/Documentation/other/robust-futexes.rst
similarity index 100%
rename from Documentation/robust-futexes.txt
rename to Documentation/other/robust-futexes.rst
diff --git a/Documentation/rpmsg.txt b/Documentation/other/rpmsg.rst
similarity index 100%
rename from Documentation/rpmsg.txt
rename to Documentation/other/rpmsg.rst
diff --git a/Documentation/rtc.txt b/Documentation/other/rtc.rst
similarity index 100%
rename from Documentation/rtc.txt
rename to Documentation/other/rtc.rst
diff --git a/Documentation/sgi-ioc4.txt b/Documentation/other/sgi-ioc4.rst
similarity index 100%
rename from Documentation/sgi-ioc4.txt
rename to Documentation/other/sgi-ioc4.rst
diff --git a/Documentation/siphash.txt b/Documentation/other/siphash.rst
similarity index 100%
rename from Documentation/siphash.txt
rename to Documentation/other/siphash.rst
diff --git a/Documentation/smsc_ece1099.txt b/Documentation/other/smsc_ece1099.rst
similarity index 100%
rename from Documentation/smsc_ece1099.txt
rename to Documentation/other/smsc_ece1099.rst
diff --git a/Documentation/speculation.txt b/Documentation/other/speculation.rst
similarity index 100%
rename from Documentation/speculation.txt
rename to Documentation/other/speculation.rst
diff --git a/Documentation/static-keys.txt b/Documentation/other/static-keys.rst
similarity index 100%
rename from Documentation/static-keys.txt
rename to Documentation/other/static-keys.rst
diff --git a/Documentation/svga.txt b/Documentation/other/svga.rst
similarity index 100%
rename from Documentation/svga.txt
rename to Documentation/other/svga.rst
diff --git a/Documentation/switchtec.txt b/Documentation/other/switchtec.rst
similarity index 100%
rename from Documentation/switchtec.txt
rename to Documentation/other/switchtec.rst
diff --git a/Documentation/sync_file.txt b/Documentation/other/sync_file.rst
similarity index 100%
rename from Documentation/sync_file.txt
rename to Documentation/other/sync_file.rst
diff --git a/Documentation/tee.txt b/Documentation/other/tee.rst
similarity index 100%
rename from Documentation/tee.txt
rename to Documentation/other/tee.rst
diff --git a/Documentation/other/text_files.rst b/Documentation/other/text_files.rst
new file mode 100644
index 000000000000..f743dcdd87f5
--- /dev/null
+++ b/Documentation/other/text_files.rst
@@ -0,0 +1,12 @@
+
+Memory barriers
+---------------
+
+    .. include:: memory-barriers.txt
+	:literal:
+
+Atomic types
+------------
+
+    .. include:: atomic_t.txt
+	:literal:
diff --git a/Documentation/this_cpu_ops.txt b/Documentation/other/this_cpu_ops.rst
similarity index 100%
rename from Documentation/this_cpu_ops.txt
rename to Documentation/other/this_cpu_ops.rst
diff --git a/Documentation/unaligned-memory-access.txt b/Documentation/other/unaligned-memory-access.rst
similarity index 100%
rename from Documentation/unaligned-memory-access.txt
rename to Documentation/other/unaligned-memory-access.rst
diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/other/vfio-mediated-device.rst
similarity index 100%
rename from Documentation/vfio-mediated-device.txt
rename to Documentation/other/vfio-mediated-device.rst
diff --git a/Documentation/vfio.txt b/Documentation/other/vfio.rst
similarity index 100%
rename from Documentation/vfio.txt
rename to Documentation/other/vfio.rst
diff --git a/Documentation/video-output.txt b/Documentation/other/video-output.rst
similarity index 100%
rename from Documentation/video-output.txt
rename to Documentation/other/video-output.rst
diff --git a/Documentation/xillybus.txt b/Documentation/other/xillybus.rst
similarity index 100%
rename from Documentation/xillybus.txt
rename to Documentation/other/xillybus.rst
diff --git a/Documentation/xz.txt b/Documentation/other/xz.rst
similarity index 100%
rename from Documentation/xz.txt
rename to Documentation/other/xz.rst
diff --git a/Documentation/zorro.txt b/Documentation/other/zorro.rst
similarity index 100%
rename from Documentation/zorro.txt
rename to Documentation/other/zorro.rst
-- 
2.20.1

