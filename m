Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2BFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4535C206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbfHAWPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:15:51 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:42764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbfHAWPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:15:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4AA32181D3368;
        Thu,  1 Aug 2019 22:15:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: team64_6ceb6c0367758
X-Filterd-Recvd-Size: 3347
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 22:15:48 +0000 (UTC)
Message-ID: <6b34cae3ce39e82e1c3b241a2e4ee1e4d7fe3ab0.camel@perches.com>
Subject: [trivial PATCH] treewide: spelling funcitons -> functions
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 15:15:47 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the functions misspellings.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/prom_init_check.sh              | 2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h | 2 +-
 drivers/net/usb/lg-vl600.c                          | 2 +-
 tools/perf/util/dwarf-aux.h                         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 160bef0d553d..b49d68c918c6 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -66,7 +66,7 @@ do
 		fi
 	done
 
-	# ignore register save/restore funcitons
+	# ignore register save/restore functions
 	case $UNDEF in
 	_restgpr_*|_restgpr0_*|_rest32gpr_*)
 		OK=1
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
index 73fe2f64491d..a5b8ac6a0a0b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -533,7 +533,7 @@ enum qlc_83xx_ext_regs {
 #define QLC_83XX_MULTI_TENANCY_INFO	BIT_29
 #define QLC_INIT_FW_RESOURCES		BIT_31
 
-/* 83xx funcitons */
+/* 83xx functions */
 int qlcnic_83xx_get_fw_version(struct qlcnic_adapter *);
 int qlcnic_83xx_issue_cmd(struct qlcnic_adapter *, struct qlcnic_cmd_args *);
 int qlcnic_83xx_setup_intr(struct qlcnic_adapter *);
diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index 6c2b3e368efe..a058ec311147 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -31,7 +31,7 @@
  * Windows/Mac drivers do send a couple of such frames to the device
  * during initialisation, with protocol set to 0x0906 or 0x0b06 and (what
  * seems to be) a flag in the .dummy_flags.  This doesn't seem necessary
- * for modem operation but can possibly be used for GPS or other funcitons.
+ * for modem operation but can possibly be used for GPS or other functions.
  */
 
 struct vl600_frame_hdr {
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 0489b0cf8e2c..ddd9769ddb87 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -20,7 +20,7 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
 		     const char **fname, int *lineno);
 
-/* Walk on funcitons at given address */
+/* Walk on functions at given address */
 int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 			 int (*callback)(Dwarf_Die *, void *), void *data);
 

