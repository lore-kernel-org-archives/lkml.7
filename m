Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DX_TEXT_01,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42C922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH1NbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:31:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfH1NbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:31:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2y2K-0004Ma-2r; Wed, 28 Aug 2019 15:30:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B9DB81C07D2;
        Wed, 28 Aug 2019 15:30:55 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:30:55 -0000
From:   "tip-bot2 for Thomas Hellstrom" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] drm/vmwgfx: Update the backdoor call with support
 for new instructions
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Doug Covelli <dcovelli@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, pv-drivers@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190828080353.12658-4-thomas_os@shipmail.org>
References: <20190828080353.12658-4-thomas_os@shipmail.org>
MIME-Version: 1.0
Message-ID: <156699905566.5317.3681114864747196316.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     6abe3778cf5abd59b23b9037796f3eab8b7f1d98
Gitweb:        https://git.kernel.org/tip/6abe3778cf5abd59b23b9037796f3eab8b7f1d98
Author:        Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate:    Wed, 28 Aug 2019 10:03:52 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Aug 2019 13:36:46 +02:00

drm/vmwgfx: Update the backdoor call with support for new instructions

Use the definition provided by include/asm/vmware.h

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
Acked-by: Dave Airlie <airlied@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pv-drivers@vmware.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190828080353.12658-4-thomas_os@shipmail.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 21 ++++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h | 35 ++++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 59e9d05..b1df3e3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -46,8 +46,6 @@
 #define RETRIES                 3
 
 #define VMW_HYPERVISOR_MAGIC    0x564D5868
-#define VMW_HYPERVISOR_PORT     0x5658
-#define VMW_HYPERVISOR_HB_PORT  0x5659
 
 #define VMW_PORT_CMD_MSG        30
 #define VMW_PORT_CMD_HB_MSG     0
@@ -93,7 +91,7 @@ static int vmw_open_channel(struct rpc_channel *channel, unsigned int protocol)
 
 	VMW_PORT(VMW_PORT_CMD_OPEN_CHANNEL,
 		(protocol | GUESTMSG_FLAG_COOKIE), si, di,
-		VMW_HYPERVISOR_PORT,
+		0,
 		VMW_HYPERVISOR_MAGIC,
 		eax, ebx, ecx, edx, si, di);
 
@@ -126,7 +124,7 @@ static int vmw_close_channel(struct rpc_channel *channel)
 
 	VMW_PORT(VMW_PORT_CMD_CLOSE_CHANNEL,
 		0, si, di,
-		(VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
+		channel->channel_id << 16,
 		VMW_HYPERVISOR_MAGIC,
 		eax, ebx, ecx, edx, si, di);
 
@@ -160,7 +158,8 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 		VMW_PORT_HB_OUT(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
 			msg_len, si, di,
-			VMW_HYPERVISOR_HB_PORT | (channel->channel_id << 16),
+			VMWARE_HYPERVISOR_HB | (channel->channel_id << 16) |
+			VMWARE_HYPERVISOR_OUT,
 			VMW_HYPERVISOR_MAGIC, bp,
 			eax, ebx, ecx, edx, si, di);
 
@@ -181,7 +180,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 
 		VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_SENDPAYLOAD << 16),
 			 word, si, di,
-			 VMW_HYPERVISOR_PORT | (channel->channel_id << 16),
+			 channel->channel_id << 16,
 			 VMW_HYPERVISOR_MAGIC,
 			 eax, ebx, ecx, edx, si, di);
 	}
@@ -213,7 +212,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 		VMW_PORT_HB_IN(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
 			reply_len, si, di,
-			VMW_HYPERVISOR_HB_PORT | (channel->channel_id << 16),
+			VMWARE_HYPERVISOR_HB | (channel->channel_id << 16),
 			VMW_HYPERVISOR_MAGIC, bp,
 			eax, ebx, ecx, edx, si, di);
 
@@ -230,7 +229,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 
 		VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_RECVPAYLOAD << 16),
 			 MESSAGE_STATUS_SUCCESS, si, di,
-			 VMW_HYPERVISOR_PORT | (channel->channel_id << 16),
+			 channel->channel_id << 16,
 			 VMW_HYPERVISOR_MAGIC,
 			 eax, ebx, ecx, edx, si, di);
 
@@ -269,7 +268,7 @@ static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 
 		VMW_PORT(VMW_PORT_CMD_SENDSIZE,
 			msg_len, si, di,
-			VMW_HYPERVISOR_PORT | (channel->channel_id << 16),
+			channel->channel_id << 16,
 			VMW_HYPERVISOR_MAGIC,
 			eax, ebx, ecx, edx, si, di);
 
@@ -327,7 +326,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 		VMW_PORT(VMW_PORT_CMD_RECVSIZE,
 			0, si, di,
-			(VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
+			channel->channel_id << 16,
 			VMW_HYPERVISOR_MAGIC,
 			eax, ebx, ecx, edx, si, di);
 
@@ -371,7 +370,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 		VMW_PORT(VMW_PORT_CMD_RECVSTATUS,
 			MESSAGE_STATUS_SUCCESS, si, di,
-			(VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
+			channel->channel_id << 16,
 			VMW_HYPERVISOR_MAGIC,
 			eax, ebx, ecx, edx, si, di);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
index 4907e50..f685c70 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
@@ -32,6 +32,7 @@
 #ifndef _VMWGFX_MSG_H
 #define _VMWGFX_MSG_H
 
+#include <asm/vmware.h>
 
 /**
  * Hypervisor-specific bi-directional communication channel.  Should never
@@ -44,7 +45,7 @@
  * @in_ebx: [IN] Message Len, through EBX
  * @in_si: [IN] Input argument through SI, set to 0 if not used
  * @in_di: [IN] Input argument through DI, set ot 0 if not used
- * @port_num: [IN] port number + [channel id]
+ * @flags: [IN] hypercall flags + [channel id]
  * @magic: [IN] hypervisor magic value
  * @eax: [OUT] value of EAX register
  * @ebx: [OUT] e.g. status from an HB message status command
@@ -54,10 +55,10 @@
  * @di:  [OUT]
  */
 #define VMW_PORT(cmd, in_ebx, in_si, in_di,	\
-		 port_num, magic,		\
+		 flags, magic,		\
 		 eax, ebx, ecx, edx, si, di)	\
 ({						\
-	asm volatile ("inl %%dx, %%eax;" :	\
+	asm volatile (VMWARE_HYPERCALL :	\
 		"=a"(eax),			\
 		"=b"(ebx),			\
 		"=c"(ecx),			\
@@ -67,7 +68,7 @@
 		"a"(magic),			\
 		"b"(in_ebx),			\
 		"c"(cmd),			\
-		"d"(port_num),			\
+		"d"(flags),			\
 		"S"(in_si),			\
 		"D"(in_di) :			\
 		"memory");			\
@@ -85,7 +86,7 @@
  * @in_ecx: [IN] Message Len, through ECX
  * @in_si: [IN] Input argument through SI, set to 0 if not used
  * @in_di: [IN] Input argument through DI, set to 0 if not used
- * @port_num: [IN] port number + [channel id]
+ * @flags: [IN] hypercall flags + [channel id]
  * @magic: [IN] hypervisor magic value
  * @bp:  [IN]
  * @eax: [OUT] value of EAX register
@@ -98,12 +99,12 @@
 #ifdef __x86_64__
 
 #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
-			port_num, magic, bp,		\
+			flags, magic, bp,		\
 			eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %%rbp;"			\
 		"mov %12, %%rbp;"			\
-		"rep outsb;"				\
+		VMWARE_HYPERCALL_HB_OUT			\
 		"pop %%rbp;" :				\
 		"=a"(eax),				\
 		"=b"(ebx),				\
@@ -114,7 +115,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"r"(bp) :				\
@@ -123,12 +124,12 @@
 
 
 #define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
-		       port_num, magic, bp,		\
+		       flags, magic, bp,		\
 		       eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %%rbp;"			\
 		"mov %12, %%rbp;"			\
-		"rep insb;"				\
+		VMWARE_HYPERCALL_HB_IN			\
 		"pop %%rbp" :				\
 		"=a"(eax),				\
 		"=b"(ebx),				\
@@ -139,7 +140,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"r"(bp) :				\
@@ -157,13 +158,13 @@
  * just pushed it.
  */
 #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
-			port_num, magic, bp,		\
+			flags, magic, bp,		\
 			eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %12;"			\
 		"push %%ebp;"				\
 		"mov 0x04(%%esp), %%ebp;"		\
-		"rep outsb;"				\
+		VMWARE_HYPERCALL_HB_OUT			\
 		"pop %%ebp;"				\
 		"add $0x04, %%esp;" :			\
 		"=a"(eax),				\
@@ -175,7 +176,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"m"(bp) :				\
@@ -184,13 +185,13 @@
 
 
 #define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
-		       port_num, magic, bp,		\
+		       flags, magic, bp,		\
 		       eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %12;"			\
 		"push %%ebp;"				\
 		"mov 0x04(%%esp), %%ebp;"		\
-		"rep insb;"				\
+		VMWARE_HYPERCALL_HB_IN			\
 		"pop %%ebp;"				\
 		"add $0x04, %%esp;" :			\
 		"=a"(eax),				\
@@ -202,7 +203,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"m"(bp) :				\
