Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04390C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0EF20879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfEQHAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:00:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727218AbfEQHAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:00:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4H6xrbK031762
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:00:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shp8vmhdt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:00:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 17 May 2019 07:58:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 07:58:56 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4H6wtfC55246872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 06:58:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 991E4A404D;
        Fri, 17 May 2019 06:58:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67B52A4055;
        Fri, 17 May 2019 06:58:55 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.144.159])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 06:58:55 +0000 (GMT)
Date:   Fri, 17 May 2019 08:58:54 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.2 merge window #2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051706-0012-0000-0000-0000031CA0E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051706-0013-0000-0000-000021554513
Message-Id: <20190517085854.7be56501@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 71ae5fc87c34ecbdca293c2a5c563d6be2576558:

  Merge tag 'linux-kselftest-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2019-05-06 20:29:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.2-2

for you to fetch changes up to f3e20ad67b4c8365df9818fd3c8026e105d6b53a:

  s390: move arch/s390/defconfig to arch/s390/configs/defconfig (2019-05-14 17:54:48 +0200)

----------------------------------------------------------------
s390 updates for the 5.2 merge window #2

 - Enhancements for the QDIO layer

 - Remove the RCP trace event

 - Avoid three build issues

 - Move the defconfig to the configs directory

----------------------------------------------------------------
Farhan Ali (1):
      s390/cio: Remove tracing for rchp instruction

Julian Wiedmann (3):
      s390/qdio: allow to scan all Output SBALs in one go
      s390/qdio: use get_buf_state() in debug_get_buf_state()
      s390/qdio: optimize state inspection of HW-owned SBALs

Martin Schwidefsky (1):
      s390/boot: fix compiler error due to missing awk strtonum

Masahiro Yamada (1):
      s390: move arch/s390/defconfig to arch/s390/configs/defconfig

Vasily Gorbik (2):
      latent_entropy: avoid build error when plugin cflags are not set
      s390/kasan: adapt disabled_wait usage to avoid build error

 arch/s390/Makefile                      |  2 ++
 arch/s390/boot/Makefile                 |  1 -
 arch/s390/boot/compressed/vmlinux.lds.S |  2 ++
 arch/s390/{ => configs}/defconfig       |  0
 arch/s390/mm/kasan_init.c               |  2 +-
 drivers/s390/cio/qdio_main.c            | 19 +++++++++++--------
 drivers/s390/cio/trace.c                |  1 -
 drivers/s390/cio/trace.h                | 23 -----------------------
 include/linux/random.h                  |  2 +-
 9 files changed, 17 insertions(+), 35 deletions(-)
 rename arch/s390/{ => configs}/defconfig (100%)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index df1d6a1..de8521f 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -10,6 +10,8 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
+KBUILD_DEFCONFIG := defconfig
+
 LD_BFD		:= elf64-s390
 KBUILD_LDFLAGS	:= -m elf64_s390
 KBUILD_AFLAGS_MODULE += -fPIC
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index c51496b..7cba96e 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -58,7 +58,6 @@ define cmd_section_cmp
 	touch $@
 endef
 
-OBJCOPYFLAGS_bzImage := --pad-to $$(readelf -s $(obj)/compressed/vmlinux | awk '/\<_end\>/ {print or(strtonum("0x"$$2),4095)+1}')
 $(obj)/bzImage: $(obj)/compressed/vmlinux $(obj)/section_cmp.boot.data $(obj)/section_cmp.boot.preserved.data FORCE
 	$(call if_changed,objcopy)
 
diff --git a/arch/s390/boot/compressed/vmlinux.lds.S b/arch/s390/boot/compressed/vmlinux.lds.S
index 112b8d9..635217e 100644
--- a/arch/s390/boot/compressed/vmlinux.lds.S
+++ b/arch/s390/boot/compressed/vmlinux.lds.S
@@ -77,6 +77,8 @@ SECTIONS
 		_compressed_start = .;
 		*(.vmlinux.bin.compressed)
 		_compressed_end = .;
+		FILL(0xff);
+		. = ALIGN(4096);
 	}
 	. = ALIGN(256);
 	.bss : {
diff --git a/arch/s390/defconfig b/arch/s390/configs/defconfig
similarity index 100%
rename from arch/s390/defconfig
rename to arch/s390/configs/defconfig
diff --git a/arch/s390/mm/kasan_init.c b/arch/s390/mm/kasan_init.c
index 01892dc..0c1f257 100644
--- a/arch/s390/mm/kasan_init.c
+++ b/arch/s390/mm/kasan_init.c
@@ -28,7 +28,7 @@ static void __init kasan_early_panic(const char *reason)
 {
 	sclp_early_printk("The Linux kernel failed to boot with the KernelAddressSanitizer:\n");
 	sclp_early_printk(reason);
-	disabled_wait(0);
+	disabled_wait();
 }
 
 static void * __init kasan_early_alloc_segment(void)
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index cfce255..7b7620d 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -205,17 +205,22 @@ static inline int get_buf_states(struct qdio_q *q, unsigned int bufnr,
 				 int auto_ack, int merge_pending)
 {
 	unsigned char __state = 0;
-	int i;
+	int i = 1;
 
 	if (is_qebsm(q))
 		return qdio_do_eqbs(q, state, bufnr, count, auto_ack);
 
 	/* get initial state: */
 	__state = q->slsb.val[bufnr];
+
+	/* Bail out early if there is no work on the queue: */
+	if (__state & SLSB_OWNER_CU)
+		goto out;
+
 	if (merge_pending && __state == SLSB_P_OUTPUT_PENDING)
 		__state = SLSB_P_OUTPUT_EMPTY;
 
-	for (i = 1; i < count; i++) {
+	for (; i < count; i++) {
 		bufnr = next_buf(bufnr);
 
 		/* merge PENDING into EMPTY: */
@@ -228,6 +233,8 @@ static inline int get_buf_states(struct qdio_q *q, unsigned int bufnr,
 		if (q->slsb.val[bufnr] != __state)
 			break;
 	}
+
+out:
 	*state = __state;
 	return i;
 }
@@ -382,7 +389,7 @@ int debug_get_buf_state(struct qdio_q *q, unsigned int bufnr,
 {
 	if (need_siga_sync(q))
 		qdio_siga_sync_q(q);
-	return get_buf_states(q, bufnr, state, 1, 0, 0);
+	return get_buf_state(q, bufnr, state, 0);
 }
 
 static inline void qdio_stop_polling(struct qdio_q *q)
@@ -719,11 +726,7 @@ static int get_outbound_buffer_frontier(struct qdio_q *q, unsigned int start)
 		    multicast_outbound(q)))
 			qdio_siga_sync_q(q);
 
-	/*
-	 * Don't check 128 buffers, as otherwise qdio_inbound_q_moved
-	 * would return 0.
-	 */
-	count = min(atomic_read(&q->nr_buf_used), QDIO_MAX_BUFFERS_MASK);
+	count = atomic_read(&q->nr_buf_used);
 	if (!count)
 		return 0;
 
diff --git a/drivers/s390/cio/trace.c b/drivers/s390/cio/trace.c
index e331cd9..882ee53 100644
--- a/drivers/s390/cio/trace.c
+++ b/drivers/s390/cio/trace.c
@@ -21,5 +21,4 @@ EXPORT_TRACEPOINT_SYMBOL(s390_cio_csch);
 EXPORT_TRACEPOINT_SYMBOL(s390_cio_hsch);
 EXPORT_TRACEPOINT_SYMBOL(s390_cio_xsch);
 EXPORT_TRACEPOINT_SYMBOL(s390_cio_rsch);
-EXPORT_TRACEPOINT_SYMBOL(s390_cio_rchp);
 EXPORT_TRACEPOINT_SYMBOL(s390_cio_chsc);
diff --git a/drivers/s390/cio/trace.h b/drivers/s390/cio/trace.h
index 0ebb29b..4803139 100644
--- a/drivers/s390/cio/trace.h
+++ b/drivers/s390/cio/trace.h
@@ -274,29 +274,6 @@ DEFINE_EVENT(s390_class_schid, s390_cio_rsch,
 	TP_ARGS(schid, cc)
 );
 
-/**
- * s390_cio_rchp - Reset Channel Path (RCHP) instruction was performed
- * @chpid: Channel-Path Identifier
- * @cc: Condition code
- */
-TRACE_EVENT(s390_cio_rchp,
-	TP_PROTO(struct chp_id chpid, int cc),
-	TP_ARGS(chpid, cc),
-	TP_STRUCT__entry(
-		__field(u8, cssid)
-		__field(u8, id)
-		__field(int, cc)
-	),
-	TP_fast_assign(
-		__entry->cssid = chpid.cssid;
-		__entry->id = chpid.id;
-		__entry->cc = cc;
-	),
-	TP_printk("chpid=%x.%02x cc=%d", __entry->cssid, __entry->id,
-		  __entry->cc
-	)
-);
-
 #define CHSC_MAX_REQUEST_LEN		64
 #define CHSC_MAX_RESPONSE_LEN		64
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 445a0ea..d4eb9b3 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -20,7 +20,7 @@ struct random_ready_callback {
 
 extern void add_device_randomness(const void *, unsigned int);
 
-#if defined(CONFIG_GCC_PLUGIN_LATENT_ENTROPY) && !defined(__CHECKER__)
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
 {
 	add_device_randomness((const void *)&latent_entropy,

