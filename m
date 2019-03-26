Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486032075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S2c1fR3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfCZArv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:47:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730776AbfCZArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:47:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2Q0jDkU016639
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=clCvtB27loPFKIXw2dF+DIT7A6l5dTRKzIuFge6QA/I=;
 b=S2c1fR3/ZfTpPh1PZFqlPcwt/W5TovIvCiDW328hL2w/WBj+nOU6Ad/Vkq2NxN1H42br
 FrFJ+WjZ6g8mf66VzPWsGuo8InlBx0CP4jkQWHbYey0PlksLUlQfPwChojs8SuxPAfHF
 DGRzGCIC1dyRTLhTE0UF9FHckZkuQ6RVAHk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rf3rm9jsr-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:46 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:46:51 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id C885C3703672; Mon, 25 Mar 2019 17:46:49 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <netdev@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <guro@fb.com>, <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 07/21] bpf: Sync bpf.h to tools/
Date:   Mon, 25 Mar 2019 17:43:33 -0700
Message-ID: <d64a5a6d5a627893dd0c70d49b80d35e3e1aac50.1553560620.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553560620.git.rdna@fb.com>
References: <cover.1553560620.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync BPF_PROG_TYPE_CGROUP_SYSCTL related bpf UAPI changes to tools/.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/include/uapi/linux/bpf.h | 90 +++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 837024512baf..01faa286bb3c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -166,6 +166,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LIRC_MODE2,
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_CGROUP_SYSCTL,
 };
 
 enum bpf_attach_type {
@@ -187,6 +188,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
+	BPF_CGROUP_SYSCTL,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2477,6 +2479,75 @@ union bpf_attr {
  * 	Return
  * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
  * 		otherwise.
+ *
+ * int bpf_sysctl_get_name(struct bpf_sysctl *ctx, char *buf, size_t buf_len, u64 flags)
+ *	Description
+ *		Get name of sysctl in /proc/sys/ and copy it into provided by
+ *		program buffer *buf* of size *buf_len*.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *
+ *		If *flags* is zero, full name (e.g. "net/ipv4/tcp_mem") is
+ *		copied. Use **BPF_F_SYSCTL_BASE_NAME** flag to copy base name
+ *		only (e.g. "tcp_mem").
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ * int bpf_sysctl_get_current_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
+ *	Description
+ *		Get current value of sysctl as it is presented in /proc/sys
+ *		(incl. newline, etc), and copy it as a string into provided
+ *		by program buffer *buf* of size *buf_len*.
+ *
+ *		The whole value is copied, no matter what file position user
+ *		space issued e.g. sys_read at.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ *		**-EINVAL** if current value was unavailable, e.g. because
+ *		sysctl is uninitialized and read returns -EIO for it.
+ *
+ * int bpf_sysctl_get_new_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
+ *	Description
+ *		Get new value being written by user space to sysctl (before
+ *		the actual write happens) and copy it as a string into
+ *		provided by program buffer *buf* of size *buf_len*.
+ *
+ *		User space may write new value at file position > 0.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ *		**-EINVAL** if sysctl is being read.
+ *
+ * int bpf_sysctl_set_new_value(struct bpf_sysctl *ctx, const char *buf, size_t buf_len)
+ *	Description
+ *		Override new value being written by user space to sysctl with
+ *		value provided by program in buffer *buf* of size *buf_len*.
+ *
+ *		*buf* should contain a string in same form as provided by user
+ *		space on sysctl write.
+ *
+ *		User space may write new value at file position > 0. To override
+ *		the whole sysctl value file position should be set to zero.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if the *buf_len* is too big.
+ *
+ *		**-EINVAL** if sysctl is being read.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2579,7 +2650,11 @@ union bpf_attr {
 	FN(skb_ecn_set_ce),		\
 	FN(get_listener_sock),		\
 	FN(skc_lookup_tcp),		\
-	FN(tcp_check_syncookie),
+	FN(tcp_check_syncookie),	\
+	FN(sysctl_get_name),		\
+	FN(sysctl_get_current_value),	\
+	FN(sysctl_get_new_value),	\
+	FN(sysctl_set_new_value),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -2646,6 +2721,9 @@ enum bpf_func_id {
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
 
+/* BPF_FUNC_sysctl_get_name flags. */
+#define BPF_F_SYSCTL_BASE_NAME		(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
@@ -3275,4 +3353,14 @@ struct bpf_line_info {
 struct bpf_spin_lock {
 	__u32	val;
 };
+
+struct bpf_sysctl {
+	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
+				 * Allows 1,2,4-byte read, but no write.
+				 */
+	__u32	file_pos;	/* Sysctl file position to read from, write to.
+				 * Allows 1,2,4-byte read an 4-byte write.
+				 */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.17.1

