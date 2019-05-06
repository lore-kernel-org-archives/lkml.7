Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB7C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6983C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfEFRAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:00:34 -0400
Received: from smtp1.cloudbase.it ([46.107.15.2]:52602 "EHLO
        smtp1.cloudbase.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:00:32 -0400
Received: from ader1990.cloudbase.it (unknown [89.46.161.178])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.cloudbase.it (Postfix) with ESMTPSA id 301C350881;
        Mon,  6 May 2019 18:56:30 +0300 (EEST)
From:   Adrian Vladu <avladu@cloudbasesolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: [PATCH] hv: tools: fix typos in toolchain
Date:   Mon,  6 May 2019 16:51:24 +0000
Message-Id: <20190506165124.6865-1-avladu@cloudbasesolutions.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in the HyperV toolchain.

Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
---
 tools/hv/hv_get_dhcp_info.sh | 2 +-
 tools/hv/hv_kvp_daemon.c     | 6 +++---
 tools/hv/hv_set_ifconfig.sh  | 2 +-
 tools/hv/hv_vss_daemon.c     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/hv/hv_get_dhcp_info.sh b/tools/hv/hv_get_dhcp_info.sh
index c38686c44656..2f2a3c7df3de 100755
--- a/tools/hv/hv_get_dhcp_info.sh
+++ b/tools/hv/hv_get_dhcp_info.sh
@@ -13,7 +13,7 @@
 #	the script prints the string "Disabled" to stdout.
 #
 # Each Distro is expected to implement this script in a distro specific
-# fashion. For instance on Distros that ship with Network Manager enabled,
+# fashion. For instance, on Distros that ship with Network Manager enabled,
 # this script can be based on the Network Manager APIs for retrieving DHCP
 # information.
 
diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 0ce50c319cfd..f5597503c771 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -700,7 +700,7 @@ static void kvp_get_ipconfig_info(char *if_name,
 
 
 	/*
-	 * Gather the DNS  state.
+	 * Gather the DNS state.
 	 * Since there is no standard way to get this information
 	 * across various distributions of interest; we just invoke
 	 * an external script that needs to be ported across distros
@@ -1051,7 +1051,7 @@ static int parse_ip_val_buffer(char *in_buf, int *offset,
 	char *start;
 
 	/*
-	 * in_buf has sequence of characters that are seperated by
+	 * in_buf has sequence of characters that are separated by
 	 * the character ';'. The last sequence does not have the
 	 * terminating ";" character.
 	 */
@@ -1492,7 +1492,7 @@ int main(int argc, char *argv[])
 		case KVP_OP_GET_IP_INFO:
 			kvp_ip_val = &hv_msg->body.kvp_ip_val;
 
-			error =  kvp_mac_to_ip(kvp_ip_val);
+			error = kvp_mac_to_ip(kvp_ip_val);
 
 			if (error)
 				hv_msg->error = error;
diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
index 7ed9f85ef908..d10fe35b7f25 100755
--- a/tools/hv/hv_set_ifconfig.sh
+++ b/tools/hv/hv_set_ifconfig.sh
@@ -12,7 +12,7 @@
 # be used to configure the interface.
 #
 # Each Distro is expected to implement this script in a distro specific
-# fashion. For instance on Distros that ship with Network Manager enabled,
+# fashion. For instance, on Distros that ship with Network Manager enabled,
 # this script can be based on the Network Manager APIs for configuring the
 # interface.
 #
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index c2bb8a360177..b58c4bbc0a26 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -53,7 +53,7 @@ static int vss_do_freeze(char *dir, unsigned int cmd)
 	 * If a partition is mounted more than once, only the first
 	 * FREEZE/THAW can succeed and the later ones will get
 	 * EBUSY/EINVAL respectively: there could be 2 cases:
-	 * 1) a user may mount the same partition to differnt directories
+	 * 1) a user may mount the same partition to different directories
 	 *  by mistake or on purpose;
 	 * 2) The subvolume of btrfs appears to have the same partition
 	 * mounted more than once.
-- 
2.19.1

