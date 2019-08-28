Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185502173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfH1GHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfH1GHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:07:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C64DEA53264;
        Wed, 28 Aug 2019 06:07:44 +0000 (UTC)
Received: from thuth.com (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85581001956;
        Wed, 28 Aug 2019 06:07:41 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH] powerpc: Replace GPL boilerplate with SPDX identifiers
Date:   Wed, 28 Aug 2019 08:07:37 +0200
Message-Id: <20190828060737.32531-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 28 Aug 2019 06:07:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSF does not reside in "675 Mass Ave, Cambridge" anymore...
let's simply use proper SPDX identifiers instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/include/uapi/asm/spu_info.h   | 14 --------------
 arch/powerpc/kernel/eeh_driver.c           | 18 +-----------------
 arch/powerpc/kernel/eeh_sysfs.c            | 18 +-----------------
 arch/powerpc/platforms/pseries/pci_dlpar.c | 18 +-----------------
 4 files changed, 3 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/spu_info.h b/arch/powerpc/include/uapi/asm/spu_info.h
index cabfcbba9eac..45f97150587b 100644
--- a/arch/powerpc/include/uapi/asm/spu_info.h
+++ b/arch/powerpc/include/uapi/asm/spu_info.h
@@ -5,20 +5,6 @@
  * (C) Copyright 2006 IBM Corp.
  *
  * Author: Dwayne Grant McConnell <decimal@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifndef _UAPI_SPU_INFO_H
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 89623962c727..3bb27ded9daa 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * PCI Error Recovery Driver for RPA-compliant PPC64 platform.
  * Copyright IBM Corp. 2004 2005
  * Copyright Linas Vepstas <linas@linas.org> 2004, 2005
  *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
  */
 #include <linux/delay.h>
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 3fa04dda1737..ab44d965a53c 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Sysfs entries for PCI Error Recovery for PAPR-compliant platform.
  * Copyright IBM Corporation 2007
  * Copyright Linas Vepstas <linas@austin.ibm.com> 2007
  *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
  */
 #include <linux/pci.h>
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 561917fa54a8..361986e4354e 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * PCI Dynamic LPAR, PCI Hot Plug and PCI EEH recovery code
  * for RPA-compliant PPC64 platform.
@@ -6,23 +7,6 @@
  *
  * Updates, 2005, John Rose <johnrose@austin.ibm.com>
  * Updates, 2005, Linas Vepstas <linas@austin.ibm.com>
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/pci.h>
-- 
2.18.1

