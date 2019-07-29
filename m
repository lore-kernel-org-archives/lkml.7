Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81257C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429E1206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CJ0QZTDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfG2Vc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:32:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfG2Vc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:32:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLWJdP2940995
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:32:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLWJdP2940995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564435940;
        bh=+4hyKuvT1G85IjzoZat9raL2Ex6BzlCk8uTRTUKeB9o=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=CJ0QZTDaoOxK0/znfoPBNRoPl1SqldAl09h+WoeqShAGdO7NPUI+vfexwruP4A9ZP
         LR/Hhf1AbmQcvhtl2ItZr2ycIlDl2IKwmbL1jVsgN0W2pr4TFZWsgt/ID49gLSo6F2
         37CK6MdRar81eK31iNm7eiku9iebLyn2YELWEhbV/G1cMhbC97ok1XzAi+DFsYAVXr
         ZrzkAToBgD1KGiq/5SnvynEgfOgBodRrdrbZKAZ1YLyn7qHqequWE0RH6XkkdJJWaK
         khfWuh0Y4J0ACxNXS39/TSxUOF4Sw1hW1MM64aEVq4hvm9bXvTnsbilAt618ZIOlaV
         19H73NMJ9OYIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLWJDx2940992;
        Mon, 29 Jul 2019 14:32:19 -0700
Date:   Mon, 29 Jul 2019 14:32:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tkdfbgzqypwco96b309c0ovd@git.kernel.org>
Cc:     adrian.hunter@intel.com, jolsa@kernel.org, lclaudio@redhat.com,
        gregkh@linuxfoundation.org, namhyung@kernel.org,
        dmitry.torokhov@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, jolsa@kernel.org, lclaudio@redhat.com,
          gregkh@linuxfoundation.org, namhyung@kernel.org,
          dmitry.torokhov@gmail.com, tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync usbdevice_fs.h with the
 kernels to get new ioctl
Git-Commit-ID: 0f58163c9d5702efbc242d144fd038e54b4c6ad0
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

Commit-ID:  0f58163c9d5702efbc242d144fd038e54b4c6ad0
Gitweb:     https://git.kernel.org/tip/0f58163c9d5702efbc242d144fd038e54b4c6ad0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 15:31:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:43 -0300

tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new ioctl

To get the changes in:

  6d101f24f1dd ("USB: add usbfs ioctl to retrieve the connection parameters")

And address this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' differs from latest version at 'include/uapi/linux/usbdevice_fs.h'
  diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevice_fs.h

Which ends up autogenerating a ioctl_cmd->string table used by 'perf
trace':

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh > before
  $ cp include/uapi/linux/usbdevice_fs.h tools/include/uapi/linux/usbdevice_fs.h
  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh > after
  $ diff -u before after
  --- before 2019-07-26 15:26:55.513636844 -0300
  +++ after 2019-07-26 15:29:11.650518677 -0300
  @@ -23,6 +23,7 @@
          [2] = "BULK",
          [30] = "DROP_PRIVILEGES",
          [31] = "GET_SPEED",
  +       [32] = "CONNINFO_EX",
          [3] = "RESETEP",
          [4] = "SETINTERFACE",
          [5] = "SETCONFIGURATION",
  $

Now 'perf trace' ioctl beautifier will translate this new ioctl to a
string and at some point will allow filtering the 'ioctl' syscall with
something like this in a system wide strace-like sessin:

  # perf trace -e ioctl/cmd=USBDEVFS_CONNINFO_EX/

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tkdfbgzqypwco96b309c0ovd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/usbdevice_fs.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
index 964e87217be4..78efe870c2b7 100644
--- a/tools/include/uapi/linux/usbdevice_fs.h
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -76,6 +76,26 @@ struct usbdevfs_connectinfo {
 	unsigned char slow;
 };
 
+struct usbdevfs_conninfo_ex {
+	__u32 size;		/* Size of the structure from the kernel's */
+				/* point of view. Can be used by userspace */
+				/* to determine how much data can be       */
+				/* used/trusted.                           */
+	__u32 busnum;           /* USB bus number, as enumerated by the    */
+				/* kernel, the device is connected to.     */
+	__u32 devnum;           /* Device address on the bus.              */
+	__u32 speed;		/* USB_SPEED_* constants from ch9.h        */
+	__u8 num_ports;		/* Number of ports the device is connected */
+				/* to on the way to the root hub. It may   */
+				/* be bigger than size of 'ports' array so */
+				/* userspace can detect overflows.         */
+	__u8 ports[7];		/* List of ports on the way from the root  */
+				/* hub to the device. Current limit in     */
+				/* USB specification is 7 tiers (root hub, */
+				/* 5 intermediate hubs, device), which     */
+				/* gives at most 6 port entries.           */
+};
+
 #define USBDEVFS_URB_SHORT_NOT_OK	0x01
 #define USBDEVFS_URB_ISO_ASAP		0x02
 #define USBDEVFS_URB_BULK_CONTINUATION	0x04
@@ -137,6 +157,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_REAP_AFTER_DISCONNECT	0x10
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
+#define USBDEVFS_CAP_CONNINFO_EX		0x80
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -197,5 +218,10 @@ struct usbdevfs_streams {
 #define USBDEVFS_FREE_STREAMS      _IOR('U', 29, struct usbdevfs_streams)
 #define USBDEVFS_DROP_PRIVILEGES   _IOW('U', 30, __u32)
 #define USBDEVFS_GET_SPEED         _IO('U', 31)
+/*
+ * Returns struct usbdevfs_conninfo_ex; length is variable to allow
+ * extending size of the data returned.
+ */
+#define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
