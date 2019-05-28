Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC610C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E8621019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k0qlH7hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfE1V1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:27:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfE1V1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:27:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLQtJZ2240309
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:26:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLQtJZ2240309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078816;
        bh=5PjUI/zB8/riwbeyNd5RaDAnx80EnHYs4zuvYz4rQUM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=k0qlH7hdCicINHl6L1Drq13bhlj1qwQzLONdUIHWmQTJTMUwrWoCfdbO6REVL85bb
         oaLSb+/zey2uQDAkKgcYzCJ450vD/CRndzEY9Selq1qSj4ViujLqxQiZou8lSbUxPR
         JBRXOzxGRdOglds+iIyZlAnhCBYBdewqAU7ZbfsUPNuTG6Zgnb0ZTWV3f8KpirSJGu
         2xnieN0duapMZjERoMNxb+Ff2S07B2U3FiZbFFaFuGipaV4S4qApAxzAH8dFb8rFgz
         XEOJTt6VwC8Py48NZ+DsmcOUFXoOT7UZgjLPxUnYJUumwC1kiknWVHr0JjsY+G4SlP
         c6d8vq1ac55uA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLQtel2240306;
        Tue, 28 May 2019 14:26:55 -0700
Date:   Tue, 28 May 2019 14:26:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jrc9ogw33w4zgqc3pu7o1l3g@git.kernel.org>
Cc:     lclaudio@redhat.com, mingo@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
        christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        david1.zhou@amd.com, lionel.g.landwerlin@intel.com,
        brendan.d.gregg@gmail.com, tglx@linutronix.de, airlied@redhat.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, mingo@kernel.org, lclaudio@redhat.com,
          jolsa@kernel.org, namhyung@kernel.org, christian.koenig@amd.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          david1.zhou@amd.com, lionel.g.landwerlin@intel.com,
          brendan.d.gregg@gmail.com, airlied@redhat.com,
          tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync drm/drm.h with the
 kernel
Git-Commit-ID: 9903c64f0fe7fa4829c948fa0e742f578e084548
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

Commit-ID:  9903c64f0fe7fa4829c948fa0e742f578e084548
Gitweb:     https://git.kernel.org/tip/9903c64f0fe7fa4829c948fa0e742f578e084548
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 22 May 2019 10:26:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:11 -0300

tools headers UAPI: Sync drm/drm.h with the kernel

To pick up the changes in these csets:

  060cebb20cdb ("drm: introduce a capability flag for syncobj timeline support")
  50d1ebef79ef ("drm/syncobj: add timeline signal ioctl for syncobj v5")
  ea569910cbab ("drm/syncobj: add transition iotcls between binary and timeline v2")
  27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6")
  01d6c3578379 ("drm/syncobj: add support for timeline point wait v8")
  783195ec1cad ("drm/syncobj: disable the timeline UAPI for now v2")
  48197bc564c7 ("drm: add syncobj timeline support v9")

Which automagically results in the following new ioctls being recognized
by the 'perf trace' ioctl cmd arg beautifier:

  $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/before
  $ cp include/uapi/drm/drm.h tools/include/uapi/drm/drm.h
  $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2019-05-22 10:25:31.443151182 -0300
  +++ /tmp/after	2019-05-22 10:25:46.449354819 -0300
  @@ -103,6 +103,10 @@
   	[0xC7] = "MODE_LIST_LESSEES",
   	[0xC8] = "MODE_GET_LEASE",
   	[0xC9] = "MODE_REVOKE_LEASE",
  +	[0xCA] = "SYNCOBJ_TIMELINE_WAIT",
  +	[0xCB] = "SYNCOBJ_QUERY",
  +	[0xCC] = "SYNCOBJ_TRANSFER",
  +	[0xCD] = "SYNCOBJ_TIMELINE_SIGNAL",
   	[DRM_COMMAND_BASE + 0x00] = "I915_INIT",
   	[DRM_COMMAND_BASE + 0x01] = "I915_FLUSH",
   	[DRM_COMMAND_BASE + 0x02] = "I915_FLIP",
    $

I.e. the strace like raw_tracepoint:sys_enter handler in 'perf trace'
will get the cmd integer value and map it to the string.

At some point it should be possible to translate from string to integer
and use to filter using expressions such as:

   # perf trace -e ioctl/cmd==DRM_IOCTL_SYNCOBJ*/

Or some more suitable syntax to express that only these ioctls when
acting on DRM fds should be shown.

Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jrc9ogw33w4zgqc3pu7o1l3g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 300f336633f2..661d73f9a919 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -649,6 +649,7 @@ struct drm_gem_open {
 #define DRM_CAP_PAGE_FLIP_TARGET	0x11
 #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
 #define DRM_CAP_SYNCOBJ		0x13
+#define DRM_CAP_SYNCOBJ_TIMELINE	0x14
 
 /** DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
@@ -735,8 +736,18 @@ struct drm_syncobj_handle {
 	__u32 pad;
 };
 
+struct drm_syncobj_transfer {
+	__u32 src_handle;
+	__u32 dst_handle;
+	__u64 src_point;
+	__u64 dst_point;
+	__u32 flags;
+	__u32 pad;
+};
+
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
 struct drm_syncobj_wait {
 	__u64 handles;
 	/* absolute timeout */
@@ -747,12 +758,33 @@ struct drm_syncobj_wait {
 	__u32 pad;
 };
 
+struct drm_syncobj_timeline_wait {
+	__u64 handles;
+	/* wait on specific timeline point for every handles*/
+	__u64 points;
+	/* absolute timeout */
+	__s64 timeout_nsec;
+	__u32 count_handles;
+	__u32 flags;
+	__u32 first_signaled; /* only valid when not waiting all */
+	__u32 pad;
+};
+
+
 struct drm_syncobj_array {
 	__u64 handles;
 	__u32 count_handles;
 	__u32 pad;
 };
 
+struct drm_syncobj_timeline_array {
+	__u64 handles;
+	__u64 points;
+	__u32 count_handles;
+	__u32 pad;
+};
+
+
 /* Query current scanout sequence number */
 struct drm_crtc_get_sequence {
 	__u32 crtc_id;		/* requested crtc_id */
@@ -909,6 +941,11 @@ extern "C" {
 #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
 #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
 
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
+#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
+#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
+
 /**
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
