Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EC8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B28A20674
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XwpALZIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfHYJtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:49:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:45119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfHYJtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566726574;
        bh=wpwm/h/PX1MnCTShhML6CeEYozu3QtCCMLvyGcBw568=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XwpALZIsvOH61khAOnW+UfT1KNLB3/c0dYRKhudAy9UspsgV4Ra4mO1QhAbU5ejvH
         6b7lUth5J/7H8NxsDC5zdkt48rL6oBd7X4dlR2hAYgD6hDt1aAu1MwEcOmU2YSOZVM
         ibm5FqbC4ofPiX/aI4Rx7fphgGGkyfAb9mHyvQbs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MIQlv-1i4qUD0RVX-004F3C; Sun, 25 Aug 2019 11:49:34 +0200
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Dewar <alex.dewar@gmx.co.uk>
Subject: [PATCH 2/4] Add SPDX headers to files in arch/um/kernel/
Date:   Sun, 25 Aug 2019 10:49:17 +0100
Message-Id: <20190825094919.4731-3-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
References: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CMoK15bXW2tAeWWbI7abeZUPMoPMseLv5FL+evXjltYb9O0hE+H
 So1z1gkjng5z2Vx6mGmmN5yfIkAa+ah63lhXPmNIFGulFS3EzKvjzacDYsiaOT0Jv/7+VYS
 3PXXQhTbmbRaGs5o+3KU54P6fizbMwD6sB+dIdRo3GcKSZBiICkxivyBlgsv2+1terDY5HY
 Nl4iz1MJunuJW1IpK6fIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gKdvB5nseRo=:qJYJWoPxm6ni8JfYd1Iqer
 Us4Ssd5E5DU1xNmTpAGCpmvtymlkPOV48NfQIUwp/K8Vje3XxiAMd3Wh6lfvAzDzPMsCjX+L6
 m+06Qggjf81HOsMBEzdMBfPlgcEiPa53CJLAxK2BXikfy9VIHJ4etYdFUaoTY2TmH8cLj/x8u
 K2FheWo65LF3f+XxocmlBLp4kgoM4OW6xMvlLQgeFxyuBOkbU/w2y6SfBe3nP4IUfo0yLllze
 EhXLobnsUE83nUm1SXyaf4uSqE8Si8sNcrpsr94GehYv/XIEGGcXU1SWbXTYt+8snE9Heevky
 UGZKK/bE7lOeELCyK12IRHiXxjgqWVFuTLkEWA7tWKP9h+US3EDAs6KKHPSTHKLqI9uXOqqzt
 A3V8pFc2fhg2YQwiw/dFCpOE0y16saUezs0Tm3ms8/D7Hdhj9ivY8r7xyu25aNb8gqTNi+j8p
 pG+LOnnkGfX4fwcpIX4zvWpTrDODrchPRZEEaXWuTJoLTj7NnmTb6t4errHUQGZT8PpsDrrda
 T5hvw2nY65JFuLBx2mr4JpHCdyJGLInH5cEIfOM7i299P7tmwPcqija/oS3LkiFZkwvqSk/OT
 E0cIBFpxZ0AE8/Moaq3ZAkb38Rld3Mf3jJjkPW35wwfpmekP7evMv9rwDY8CBpWpRLtYmBBnd
 fMsdDWr0Pv4DY3qM/5g7aaKiiycUeDP5UtHhyZcVDjI9w58yZ/nssa4SrkWg+0TiyHB18x6NP
 DWfYpuHgssDTC5yEWX5vIqnm9Ktn24huwOrvLQDZ2O/UoNUatOVBWyVlhCo2ny4dexwraOExq
 UXJPv4E+/YhVnZyG8Hy8dmdIC7ibVsWAQGN6bl2AiAG/08ykfqPs+YuWAhPz29Qo8sXEnY4ki
 jcrjs2FviGiw8px5IpcnqyDBqL0E4WNCJjQ2miG5j3SLFqHRXI+nXGcxfQ1j2m66e49g9oEJ5
 1T6RCtCCoaZqhk7HnCIll9T36p2vskLOsfoAqFvp1OFxtUq5J9kQvb+HZjQtAxrwlOI5jXIOd
 hHVgiiMd0LayHZNonLl159eebGti7XIrx4A6o2w1iGZambnTVmKyl/mLPpHH/O6S+WYcGbhf1
 4Kxj7Z58MBOfs+k12GUvW3+9dJk6pFaVo6B86EOomzySX10rstDMbimmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert files to use SPDX header. All files are licensed under the
GPLv2.

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 arch/um/kernel/Makefile       | 2 +-
 arch/um/kernel/config.c.in    | 4 ++--
 arch/um/kernel/exec.c         | 2 +-
 arch/um/kernel/exitcode.c     | 2 +-
 arch/um/kernel/gmon_syms.c    | 2 +-
 arch/um/kernel/gprof_syms.c   | 2 +-
 arch/um/kernel/initrd.c       | 2 +-
 arch/um/kernel/irq.c          | 2 +-
 arch/um/kernel/ksyms.c        | 2 +-
 arch/um/kernel/mem.c          | 2 +-
 arch/um/kernel/physmem.c      | 2 +-
 arch/um/kernel/process.c      | 2 +-
 arch/um/kernel/ptrace.c       | 2 +-
 arch/um/kernel/reboot.c       | 2 +-
 arch/um/kernel/sigio.c        | 2 +-
 arch/um/kernel/signal.c       | 2 +-
 arch/um/kernel/skas/Makefile  | 2 +-
 arch/um/kernel/skas/clone.c   | 2 +-
 arch/um/kernel/skas/mmu.c     | 2 +-
 arch/um/kernel/skas/process.c | 2 +-
 arch/um/kernel/skas/syscall.c | 2 +-
 arch/um/kernel/skas/uaccess.c | 2 +-
 arch/um/kernel/syscall.c      | 2 +-
 arch/um/kernel/time.c         | 2 +-
 arch/um/kernel/tlb.c          | 2 +-
 arch/um/kernel/trap.c         | 2 +-
 arch/um/kernel/um_arch.c      | 2 +-
 arch/um/kernel/umid.c         | 2 +-
 28 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2f36d515762e..97fae04912a0 100644
=2D-- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux,intel}.com)
-# Licensed under the GPL
 #

 # Don't instrument UML-specific code; without this, we may crash when
diff --git a/arch/um/kernel/config.c.in b/arch/um/kernel/config.c.in
index 972bf1659564..3ece3c3b31cc 100644
=2D-- a/arch/um/kernel/config.c.in
+++ b/arch/um/kernel/config.c.in
@@ -1,6 +1,6 @@
-/*
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 783b9247161f..e8fd5d540b05 100644
=2D-- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/stddef.h>
diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index 546302e3b7fb..369fd844e195 100644
=2D-- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/ctype.h>
diff --git a/arch/um/kernel/gmon_syms.c b/arch/um/kernel/gmon_syms.c
index f138a4a0db99..9361a8eb9bf1 100644
=2D-- a/arch/um/kernel/gmon_syms.c
+++ b/arch/um/kernel/gmon_syms.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/module.h>
diff --git a/arch/um/kernel/gprof_syms.c b/arch/um/kernel/gprof_syms.c
index 74ddb44288a3..84d536908775 100644
=2D-- a/arch/um/kernel/gprof_syms.c
+++ b/arch/um/kernel/gprof_syms.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/module.h>
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 1dcd310cb34d..c1981ffb7179 100644
=2D-- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/init.h>
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index efde1f16c603..f4d01192d39f 100644
=2D-- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -1,8 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 - Cambridge Greys Ltd
  * Copyright (C) 2011 - 2014 Cisco Systems Inc
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  * Derived (i.e. mostly copied) from arch/i386/kernel/irq.c:
  *	Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
  */
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 232b22307fdd..74f70aa4efde 100644
=2D-- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/module.h>
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index de58e976b9bc..76bc02abf362 100644
=2D-- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/stddef.h>
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 5bf56af4d5b9..f6800892de7d 100644
=2D-- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/module.h>
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 6bede7888fc2..4fa071e7446f 100644
=2D-- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Anton Ivanov (aivanov@{brocade.com,kot-begemot.co.u=
k})
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright 2003 PathScale, Inc.
- * Licensed under the GPL
  */

 #include <linux/stddef.h>
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index da1e96b1ec3e..b425f47bddbb 100644
=2D-- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/audit.h>
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 71f3e9217cf2..48c0610d506e 100644
=2D-- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/sched/signal.h>
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index 3fb6a4041ed6..10c99e058fca 100644
=2D-- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <linux/interrupt.h>
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 57acbd67d85d..2dfe342f455e 100644
=2D-- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/module.h>
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 5bd3edfcfedf..f3d494a4fd9b 100644
=2D-- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
-# Licensed under the GPL
 #

 obj-y :=3D clone.o mmu.o process.o syscall.o uaccess.o
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 0f25d41b1031..bfb70c456b30 100644
=2D-- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <signal.h>
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 29e7f5f9f188..c41d39dafcc3 100644
=2D-- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/mm.h>
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index d4dbf08722d6..6f65c90a7760 100644
=2D-- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/init.h>
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 44bb10785075..f574b1856bc6 100644
=2D-- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/kernel.h>
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index bd3cb694322c..3236052f20e6 100644
=2D-- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/err.h>
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index 35f7047bdebc..eed54c53fbbb 100644
=2D-- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/file.h>
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 234757233355..8c55e67e0b2e 100644
=2D-- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Anton Ivanov (aivanov@{brocade.com,kot-begemot.co.u=
k})
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/clockchips.h>
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 45f739bf302f..b7eaf655635c 100644
=2D-- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/mm.h>
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 58fe36856182..e62296c66c95 100644
=2D-- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/mm.h>
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a818ccef30ca..8ae067de3d5d 100644
=2D-- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/delay.h>
diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
index 10bf4aca529f..8031a038eb58 100644
=2D-- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <asm/errno.h>
=2D-
2.23.0

