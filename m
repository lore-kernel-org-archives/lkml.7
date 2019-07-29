Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F5C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165992073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eSd0RIc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfG2VbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:31:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfG2VbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:31:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLUr8R2940907
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:30:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLUr8R2940907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564435854;
        bh=hCEBYigu+OEeQGRQ3twBEHCEs9Xp98eHDW7AuBSCM6c=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=eSd0RIc9dz/3RE2lX/g39VQNa4u5DmkUAhEd1HLraMI8R2wK1tiIQ7Zke1zp2TaKF
         7bfQBnu5V8PdSl5UmWKW3TKai+G/Kdnb/1UVy95Sf6JDYoVyASR75elGRItrn4RE5x
         39avr/8kUC/TtehOR7c0cqg1eqiGHAwQDr7vmnEyewE+V7/rceFLJjmhbsrhVbFUba
         e8AkS2uldZKmLAjw3nSGDGjSnlDO/u2aXpEBMD21wFesxBZbx4uvg9OTNhm3fp/ZeU
         UvzHUJXi6dxLeB/33rC/xQqfo4h99OZwbi46z9F75Y8jFuOBzg0Sa/vJ83MgdFIjTk
         h2GJ/lxy6xa0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLUr5n2940904;
        Mon, 29 Jul 2019 14:30:53 -0700
Date:   Mon, 29 Jul 2019 14:30:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a9173whgu3h1vo24jgdg5do8@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, tvrtko.ursulin@intel.com,
        jolsa@kernel.org, adrian.hunter@intel.com, eric@anholt.net,
        lclaudio@redhat.com, chris@chris-wilson.co.uk, tglx@linutronix.de,
        mingo@kernel.org, jrtc27@jrtc27.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          jrtc27@jrtc27.com, mingo@kernel.org, tglx@linutronix.de,
          chris@chris-wilson.co.uk, eric@anholt.net, lclaudio@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org, hpa@zytor.com,
          tvrtko.ursulin@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Update tools's copy of drm.h
 headers
Git-Commit-ID: 95dc663aa6382fec92674e748682cefeeb2bfc22
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  95dc663aa6382fec92674e748682cefeeb2bfc22
Gitweb:     https://git.kernel.org/tip/95dc663aa6382fec92674e748682cefeeb2bfc22
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 15:00:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:42 -0300

tools headers UAPI: Update tools's copy of drm.h headers

Picking the changes from:

  c5d3e39caa45 ("drm/i915: Engine discovery query")
  a88b6e4cbafd ("drm/i915: Allow specification of parallel execbuf")
  ee1136908e9b ("drm/i915/execlists: Virtual engine bonding")
  6d06779e8672 ("drm/i915: Load balancing across a virtual engine")
  b81dde719439 ("drm/i915: Allow userspace to clone contexts on creation")
  8319f44c0525 ("drm/i915: Re-expose SINGLE_TIMELINE flags for context creation")
  e620f7b3a263 ("drm/i915: Extend I915_CONTEXT_PARAM_SSEU to support local ctx->engine[]")
  976b55f0e1db ("drm/i915: Allow a context to define its set of engines")
  7f3f317a66ca ("drm/i915: Restore control over ppgtt for context creation ABI")
  75b3f1cb50bd ("drm: Fix drm.h uapi header for GNU/kFreeBSD")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'
  diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h
  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Now 'perf trace' and other code that might use the tools/perf/trace/beauty autogenerated
tables will be able to translate this new ioctl code into a string:

  $ tools/perf/trace/beauty/drm_ioctl.sh > before
  $ cp include/uapi/drm/i915_drm.h tools/include/uapi/drm/i915_drm.h
  $ tools/perf/trace/beauty/drm_ioctl.sh > after
  $ diff -u before after
  --- before 2019-07-26 13:02:22.052723640 -0300
  +++ after 2019-07-26 13:02:35.354906036 -0300
  @@ -163,4 +163,6 @@
          [DRM_COMMAND_BASE + 0x37] = "I915_PERF_ADD_CONFIG",
          [DRM_COMMAND_BASE + 0x38] = "I915_PERF_REMOVE_CONFIG",
          [DRM_COMMAND_BASE + 0x39] = "I915_QUERY",
  +       [DRM_COMMAND_BASE + 0x3a] = "I915_GEM_VM_CREATE",
  +       [DRM_COMMAND_BASE + 0x3b] = "I915_GEM_VM_DESTROY",
   };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Eric Anholt <eric@anholt.net>
Cc: James Clarke <jrtc27@jrtc27.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://lkml.kernel.org/n/tip-a9173whgu3h1vo24jgdg5do8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h      |   1 +
 tools/include/uapi/drm/i915_drm.h | 209 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 661d73f9a919..8a5b2f8f8eb9 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -50,6 +50,7 @@ typedef unsigned int drm_handle_t;
 
 #else /* One of the BSDs */
 
+#include <stdint.h>
 #include <sys/ioccom.h>
 #include <sys/types.h>
 typedef int8_t   __s8;
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 3a73f5316766..328d05e77d9f 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -136,6 +136,8 @@ enum drm_i915_gem_engine_class {
 struct i915_engine_class_instance {
 	__u16 engine_class; /* see enum drm_i915_gem_engine_class */
 	__u16 engine_instance;
+#define I915_ENGINE_CLASS_INVALID_NONE -1
+#define I915_ENGINE_CLASS_INVALID_VIRTUAL -2
 };
 
 /**
@@ -355,6 +357,8 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_PERF_ADD_CONFIG	0x37
 #define DRM_I915_PERF_REMOVE_CONFIG	0x38
 #define DRM_I915_QUERY			0x39
+#define DRM_I915_GEM_VM_CREATE		0x3a
+#define DRM_I915_GEM_VM_DESTROY		0x3b
 /* Must be kept compact -- no holes */
 
 #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
@@ -415,6 +419,8 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_PERF_ADD_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_ADD_CONFIG, struct drm_i915_perf_oa_config)
 #define DRM_IOCTL_I915_PERF_REMOVE_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_REMOVE_CONFIG, __u64)
 #define DRM_IOCTL_I915_QUERY			DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_QUERY, struct drm_i915_query)
+#define DRM_IOCTL_I915_GEM_VM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_VM_CREATE, struct drm_i915_gem_vm_control)
+#define DRM_IOCTL_I915_GEM_VM_DESTROY	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_VM_DESTROY, struct drm_i915_gem_vm_control)
 
 /* Allow drivers to submit batchbuffers directly to hardware, relying
  * on the security mechanisms provided by hardware.
@@ -598,6 +604,12 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_MMAP_GTT_COHERENT	52
 
+/*
+ * Query whether DRM_I915_GEM_EXECBUFFER2 supports coordination of parallel
+ * execution through use of explicit fence support.
+ * See I915_EXEC_FENCE_OUT and I915_EXEC_FENCE_SUBMIT.
+ */
+#define I915_PARAM_HAS_EXEC_SUBMIT_FENCE 53
 /* Must be kept compact -- no holes and well documented */
 
 typedef struct drm_i915_getparam {
@@ -1120,7 +1132,16 @@ struct drm_i915_gem_execbuffer2 {
  */
 #define I915_EXEC_FENCE_ARRAY   (1<<19)
 
-#define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_FENCE_ARRAY<<1))
+/*
+ * Setting I915_EXEC_FENCE_SUBMIT implies that lower_32_bits(rsvd2) represent
+ * a sync_file fd to wait upon (in a nonblocking manner) prior to executing
+ * the batch.
+ *
+ * Returns -EINVAL if the sync_file fd cannot be found.
+ */
+#define I915_EXEC_FENCE_SUBMIT		(1 << 20)
+
+#define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_FENCE_SUBMIT << 1))
 
 #define I915_EXEC_CONTEXT_ID_MASK	(0xffffffff)
 #define i915_execbuffer2_set_context_id(eb2, context) \
@@ -1464,8 +1485,9 @@ struct drm_i915_gem_context_create_ext {
 	__u32 ctx_id; /* output: id of new context*/
 	__u32 flags;
 #define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS	(1u << 0)
+#define I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE	(1u << 1)
 #define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
-	(-(I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS << 1))
+	(-(I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE << 1))
 	__u64 extensions;
 };
 
@@ -1507,6 +1529,41 @@ struct drm_i915_gem_context_param {
  * On creation, all new contexts are marked as recoverable.
  */
 #define I915_CONTEXT_PARAM_RECOVERABLE	0x8
+
+	/*
+	 * The id of the associated virtual memory address space (ppGTT) of
+	 * this context. Can be retrieved and passed to another context
+	 * (on the same fd) for both to use the same ppGTT and so share
+	 * address layouts, and avoid reloading the page tables on context
+	 * switches between themselves.
+	 *
+	 * See DRM_I915_GEM_VM_CREATE and DRM_I915_GEM_VM_DESTROY.
+	 */
+#define I915_CONTEXT_PARAM_VM		0x9
+
+/*
+ * I915_CONTEXT_PARAM_ENGINES:
+ *
+ * Bind this context to operate on this subset of available engines. Henceforth,
+ * the I915_EXEC_RING selector for DRM_IOCTL_I915_GEM_EXECBUFFER2 operates as
+ * an index into this array of engines; I915_EXEC_DEFAULT selecting engine[0]
+ * and upwards. Slots 0...N are filled in using the specified (class, instance).
+ * Use
+ *	engine_class: I915_ENGINE_CLASS_INVALID,
+ *	engine_instance: I915_ENGINE_CLASS_INVALID_NONE
+ * to specify a gap in the array that can be filled in later, e.g. by a
+ * virtual engine used for load balancing.
+ *
+ * Setting the number of engines bound to the context to 0, by passing a zero
+ * sized argument, will revert back to default settings.
+ *
+ * See struct i915_context_param_engines.
+ *
+ * Extensions:
+ *   i915_context_engines_load_balance (I915_CONTEXT_ENGINES_EXT_LOAD_BALANCE)
+ *   i915_context_engines_bond (I915_CONTEXT_ENGINES_EXT_BOND)
+ */
+#define I915_CONTEXT_PARAM_ENGINES	0xa
 /* Must be kept compact -- no holes and well documented */
 
 	__u64 value;
@@ -1540,9 +1597,10 @@ struct drm_i915_gem_context_param_sseu {
 	struct i915_engine_class_instance engine;
 
 	/*
-	 * Unused for now. Must be cleared to zero.
+	 * Unknown flags must be cleared to zero.
 	 */
 	__u32 flags;
+#define I915_CONTEXT_SSEU_FLAG_ENGINE_INDEX (1u << 0)
 
 	/*
 	 * Mask of slices to enable for the context. Valid values are a subset
@@ -1570,12 +1628,115 @@ struct drm_i915_gem_context_param_sseu {
 	__u32 rsvd;
 };
 
+/*
+ * i915_context_engines_load_balance:
+ *
+ * Enable load balancing across this set of engines.
+ *
+ * Into the I915_EXEC_DEFAULT slot [0], a virtual engine is created that when
+ * used will proxy the execbuffer request onto one of the set of engines
+ * in such a way as to distribute the load evenly across the set.
+ *
+ * The set of engines must be compatible (e.g. the same HW class) as they
+ * will share the same logical GPU context and ring.
+ *
+ * To intermix rendering with the virtual engine and direct rendering onto
+ * the backing engines (bypassing the load balancing proxy), the context must
+ * be defined to use a single timeline for all engines.
+ */
+struct i915_context_engines_load_balance {
+	struct i915_user_extension base;
+
+	__u16 engine_index;
+	__u16 num_siblings;
+	__u32 flags; /* all undefined flags must be zero */
+
+	__u64 mbz64; /* reserved for future use; must be zero */
+
+	struct i915_engine_class_instance engines[0];
+} __attribute__((packed));
+
+#define I915_DEFINE_CONTEXT_ENGINES_LOAD_BALANCE(name__, N__) struct { \
+	struct i915_user_extension base; \
+	__u16 engine_index; \
+	__u16 num_siblings; \
+	__u32 flags; \
+	__u64 mbz64; \
+	struct i915_engine_class_instance engines[N__]; \
+} __attribute__((packed)) name__
+
+/*
+ * i915_context_engines_bond:
+ *
+ * Constructed bonded pairs for execution within a virtual engine.
+ *
+ * All engines are equal, but some are more equal than others. Given
+ * the distribution of resources in the HW, it may be preferable to run
+ * a request on a given subset of engines in parallel to a request on a
+ * specific engine. We enable this selection of engines within a virtual
+ * engine by specifying bonding pairs, for any given master engine we will
+ * only execute on one of the corresponding siblings within the virtual engine.
+ *
+ * To execute a request in parallel on the master engine and a sibling requires
+ * coordination with a I915_EXEC_FENCE_SUBMIT.
+ */
+struct i915_context_engines_bond {
+	struct i915_user_extension base;
+
+	struct i915_engine_class_instance master;
+
+	__u16 virtual_index; /* index of virtual engine in ctx->engines[] */
+	__u16 num_bonds;
+
+	__u64 flags; /* all undefined flags must be zero */
+	__u64 mbz64[4]; /* reserved for future use; must be zero */
+
+	struct i915_engine_class_instance engines[0];
+} __attribute__((packed));
+
+#define I915_DEFINE_CONTEXT_ENGINES_BOND(name__, N__) struct { \
+	struct i915_user_extension base; \
+	struct i915_engine_class_instance master; \
+	__u16 virtual_index; \
+	__u16 num_bonds; \
+	__u64 flags; \
+	__u64 mbz64[4]; \
+	struct i915_engine_class_instance engines[N__]; \
+} __attribute__((packed)) name__
+
+struct i915_context_param_engines {
+	__u64 extensions; /* linked chain of extension blocks, 0 terminates */
+#define I915_CONTEXT_ENGINES_EXT_LOAD_BALANCE 0 /* see i915_context_engines_load_balance */
+#define I915_CONTEXT_ENGINES_EXT_BOND 1 /* see i915_context_engines_bond */
+	struct i915_engine_class_instance engines[0];
+} __attribute__((packed));
+
+#define I915_DEFINE_CONTEXT_PARAM_ENGINES(name__, N__) struct { \
+	__u64 extensions; \
+	struct i915_engine_class_instance engines[N__]; \
+} __attribute__((packed)) name__
+
 struct drm_i915_gem_context_create_ext_setparam {
 #define I915_CONTEXT_CREATE_EXT_SETPARAM 0
 	struct i915_user_extension base;
 	struct drm_i915_gem_context_param param;
 };
 
+struct drm_i915_gem_context_create_ext_clone {
+#define I915_CONTEXT_CREATE_EXT_CLONE 1
+	struct i915_user_extension base;
+	__u32 clone_id;
+	__u32 flags;
+#define I915_CONTEXT_CLONE_ENGINES	(1u << 0)
+#define I915_CONTEXT_CLONE_FLAGS	(1u << 1)
+#define I915_CONTEXT_CLONE_SCHEDATTR	(1u << 2)
+#define I915_CONTEXT_CLONE_SSEU		(1u << 3)
+#define I915_CONTEXT_CLONE_TIMELINE	(1u << 4)
+#define I915_CONTEXT_CLONE_VM		(1u << 5)
+#define I915_CONTEXT_CLONE_UNKNOWN -(I915_CONTEXT_CLONE_VM << 1)
+	__u64 rsvd;
+};
+
 struct drm_i915_gem_context_destroy {
 	__u32 ctx_id;
 	__u32 pad;
@@ -1821,6 +1982,7 @@ struct drm_i915_perf_oa_config {
 struct drm_i915_query_item {
 	__u64 query_id;
 #define DRM_I915_QUERY_TOPOLOGY_INFO    1
+#define DRM_I915_QUERY_ENGINE_INFO	2
 /* Must be kept compact -- no holes and well documented */
 
 	/*
@@ -1919,6 +2081,47 @@ struct drm_i915_query_topology_info {
 	__u8 data[];
 };
 
+/**
+ * struct drm_i915_engine_info
+ *
+ * Describes one engine and it's capabilities as known to the driver.
+ */
+struct drm_i915_engine_info {
+	/** Engine class and instance. */
+	struct i915_engine_class_instance engine;
+
+	/** Reserved field. */
+	__u32 rsvd0;
+
+	/** Engine flags. */
+	__u64 flags;
+
+	/** Capabilities of this engine. */
+	__u64 capabilities;
+#define I915_VIDEO_CLASS_CAPABILITY_HEVC		(1 << 0)
+#define I915_VIDEO_AND_ENHANCE_CLASS_CAPABILITY_SFC	(1 << 1)
+
+	/** Reserved fields. */
+	__u64 rsvd1[4];
+};
+
+/**
+ * struct drm_i915_query_engine_info
+ *
+ * Engine info query enumerates all engines known to the driver by filling in
+ * an array of struct drm_i915_engine_info structures.
+ */
+struct drm_i915_query_engine_info {
+	/** Number of struct drm_i915_engine_info structs following. */
+	__u32 num_engines;
+
+	/** MBZ */
+	__u32 rsvd[3];
+
+	/** Marker for drm_i915_engine_info structures. */
+	struct drm_i915_engine_info engines[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
