Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7FC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD9A214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbfKEQIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:08:36 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60606 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390168AbfKEQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:08:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 9BD4E1A216E;
        Tue,  5 Nov 2019 16:59:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.14.106])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 753F11A2113;
        Tue,  5 Nov 2019 16:59:40 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: [PATCH 1/3] docs: ioctl: Update ioctl-number.rst ioctl ranges table
Date:   Tue,  5 Nov 2019 16:59:19 +0100
Message-Id: <1572969561-17591-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572969561-17591-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572969561-17591-1-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>

Attempt to update ioctl ranges table to reflect reality better.

Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 Documentation/ioctl/ioctl-number.rst | 51 ++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioctl-number.rst
index bef79cd..f8768c7 100644
--- a/Documentation/ioctl/ioctl-number.rst
+++ b/Documentation/ioctl/ioctl-number.rst
@@ -70,26 +70,25 @@ no attempt to list non-X86 architectures or ioctls from drivers/staging/.
 Code  Seq#    Include File                                           Comments
       (hex)
 ====  =====  ======================================================= ================================================================
-0x00  00-1F  linux/fs.h                                              conflict!
-0x00  00-1F  scsi/scsi_ioctl.h                                       conflict!
-0x00  00-1F  linux/fb.h                                              conflict!
-0x00  00-1F  linux/wavefront.h                                       conflict!
-0x02  all    linux/fd.h
-0x03  all    linux/hdreg.h
+0x00  00-1F  linux/fs.h                                              Filesystem BMAP support
+0x02  all    linux/fd.h                                              Floppy drive
+0x03  all    linux/hdreg.h                                           Hard drive
 0x04  D2-DC  linux/umsdos_fs.h                                       Dead since 2.6.11, but don't reuse these.
-0x06  all    linux/lp.h
+0x06  all    linux/lp.h                                              Parallel printer driver
+0x07  9F-CB  linux/vmw_vmci_defs.h                                   VMware VMCI Driver
 0x09  all    linux/raid/md_u.h
 0x10  00-0F  drivers/char/s390/vmcp.h
 0x10  10-1F  arch/s390/include/uapi/sclp_ctl.h
 0x10  20-2F  arch/s390/include/uapi/asm/hypfs.h
 0x12  all    linux/fs.h
              linux/blkpg.h
-0x1b  all                                                            InfiniBand Subsystem
+             linux/blkzoned.h
+0x1b  all    rdma/rdma_user_ioctl.h                                  InfiniBand Subsystem
                                                                      <http://infiniband.sourceforge.net/>
-0x20  all    drivers/cdrom/cm206.h
+0x21  00-02  linux/seccomp.h                                         Seccomp BPF
 0x22  all    scsi/sg.h
 '!'   00-1F  uapi/linux/seccomp.h
-'#'   00-3F                                                          IEEE 1394 Subsystem
+'#'   00-3F  linux/firewire-cdev.h                                   IEEE 1394 Subsystem
                                                                      Block for the entire subsystem
 '$'   00-0F  linux/perf_counter.h, linux/perf_event.h
 '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
@@ -97,13 +96,14 @@ Code  Seq#    Include File                                           Comments
 '&'   00-07  drivers/firewire/nosy-user.h
 '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
                                                                      <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
-'2'   01-04  linux/i2o.h
 '3'   00-0F  drivers/s390/char/raw3270.h                             conflict!
 '3'   00-1F  linux/suspend_ioctls.h,                                 conflict!
              kernel/power/user.c
 '8'   all                                                            SNP8023 advanced NIC card
                                                                      <mailto:mcr@solidum.com>
-';'   64-7F  linux/vfio.h
+';'   64-7F  linux/vfio.h                                            Virtual Function I/O (VFIO)
+'='   01-09  linux/ptp_clock.h                                       PTP 1588 clock
+'>'   03-04  linux/sync_file.h                                       Sync file
 '@'   00-0F  linux/radeonfb.h                                        conflict!
 '@'   00-0F  drivers/video/aty/aty128fb.c                            conflict!
 'A'   00-1F  linux/apm_bios.h                                        conflict!
@@ -111,7 +111,7 @@ Code  Seq#    Include File                                           Comments
              drivers/char/agp/compat_ioctl.h
 'A'   00-7F  sound/asound.h                                          conflict!
 'B'   00-1F  linux/cciss_ioctl.h                                     conflict!
-'B'   00-0F  include/linux/pmu.h                                     conflict!
+'B'   00-0F  linux/pmu.h                                             conflict!
 'B'   C0-FF  advanced bbus                                           <mailto:maassen@uni-freiburg.de>
 'C'   all    linux/soundcard.h                                       conflict!
 'C'   01-2F  linux/capi.h                                            conflict!
@@ -148,17 +148,15 @@ Code  Seq#    Include File                                           Comments
 'H'   40-4F  sound/hdsp.h                                            conflict!
 'H'   90     sound/usb/usx2y/usb_stream.h
 'H'   A0     uapi/linux/usb/cdc-wdm.h
-'H'   C0-F0  net/bluetooth/hci.h                                     conflict!
-'H'   C0-DF  net/bluetooth/hidp/hidp.h                               conflict!
-'H'   C0-DF  net/bluetooth/cmtp/cmtp.h                               conflict!
-'H'   C0-DF  net/bluetooth/bnep/bnep.h                               conflict!
+'H'   C0-F0  net/bluetooth/hci_sock.h                                Bluetooth HCI
 'H'   F1     linux/hid-roccat.h                                      <mailto:erazor_de@users.sourceforge.net>
 'H'   F8-FA  sound/firewire.h
 'I'   all    linux/isdn.h                                            conflict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                       conflict!
 'I'   40-4F  linux/mISDNif.h                                         conflict!
 'J'   00-1F  drivers/scsi/gdth_ioctl.h
-'K'   all    linux/kd.h
+'K'   01-1D  linux/kfd_ioctl.h
+'K'   2F-FB  linux/kd.h
 'L'   00-1F  linux/loop.h                                            conflict!
 'L'   10-1F  drivers/scsi/mpt3sas/mpt3sas_ctl.h                      conflict!
 'L'   20-2F  linux/lightnvm.h
@@ -171,7 +169,8 @@ Code  Seq#    Include File                                           Comments
 'M'   00-0F  drivers/video/fsl-diu-fb.h                              conflict!
 'N'   00-1F  drivers/usb/scanner.h
 'N'   40-7F  drivers/block/nvme.c
-'O'   00-06  mtd/ubi-user.h                                          UBI
+'O'   00-08  mtd/ubi-user.h                                          UBI
+'O'   1F-3F  linux/omapfb.h                                          OMAP framebuffer
 'P'   all    linux/soundcard.h                                       conflict!
 'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
 'P'   00-0F  drivers/usb/class/usblp.c                               conflict!
@@ -337,10 +336,11 @@ Code  Seq#    Include File                                           Comments
 0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
 0xB6  all    linux/fpga-dfl.h
-0xC0  00-0F  linux/usb/iowarrior.h
-0xCA  00-0F  uapi/misc/cxl.h
-0xCA  10-2F  uapi/misc/ocxl.h
-0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h
+0xB7  01-04  linux/nsfs.h                                            Namespaces
+0xC0  00-0F  linux/usb/iowarrior.h                                   I/O-Warrior USB devices
+0xCA  00-0F  uapi/misc/cxl.h                                         Coherent Accelerator Interface (CXL)
+0xCA  10-2F  uapi/misc/ocxl.h                                        Open Coherent Accelerator Processor Interface (OpenCAPI)
+0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h                              Coherent Accelerator (CXL) Flash
 0xCB  00-1F                                                          CBM serial IEC bus in development:
                                                                      <mailto:michael.klein@puffin.lb.shuttle.de>
 0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
@@ -353,10 +353,11 @@ Code  Seq#    Include File                                           Comments
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
                                                                      <mailto:thomas@winischhofer.net>
-0xF4  00-1F  video/mbxfb.h                                           mbxfb
+0xF4  00-1F  video/mbxfb.h                                           Intel 2700G (Marathon) Frame Buffer Driver
                                                                      <mailto:raph@8d.com>
+0xF5  00-08  staging/android/vsoc_shm.h
 0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
                                                                      <mailto:mathieu.desnoyers@efficios.com>
-0xFD  all    linux/dm-ioctl.h
+0xFD  all    linux/dm-ioctl.h                                        Device mapper
 0xFE  all    linux/isst_if.h
 ====  =====  ======================================================= ================================================================
-- 
2.7.4

