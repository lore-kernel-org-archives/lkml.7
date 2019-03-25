Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B227B20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfCYUbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:31:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46890 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbfCYUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:31:04 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h8WFH-0005E2-Ls; Mon, 25 Mar 2019 20:31:01 +0000
Date:   Mon, 25 Mar 2019 20:30:59 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     lwn@lwn.net
Message-ID: <lsq.1553545806.40880444@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mdsgvlqioez6fubw"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Linux 3.16.64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mdsgvlqioez6fubw
Content-Type: multipart/mixed; boundary="f3zqrbarnqt3do53"
Content-Disposition: inline


--f3zqrbarnqt3do53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 3.16.64 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git

The diff from 3.16.63 is attached to this message.

Ben.

------------

 Makefile                       |   2 +-
 arch/arm/kvm/arm.c             |   9 ++--
 arch/powerpc/kvm/book3s_xics.c |  12 +++--
 arch/x86/kvm/vmx.c             |   1 +
 arch/x86/kvm/x86.c             |   7 +++
 drivers/base/dma-contiguous.c  |   4 +-
 drivers/hid/hid-debug.c        | 119 ++++++++++++++++-------------------------
 drivers/net/appletalk/ipddp.c  |   8 ++-
 drivers/net/usb/hso.c          |  18 ++++++-
 fs/xfs/xfs_aops.c              |  21 +++++++-
 include/linux/dma-contiguous.h |   4 +-
 include/linux/hid-debug.h      |   9 ++--
 include/linux/kvm_host.h       |  12 +++++
 include/linux/sunrpc/svc.h     |   5 +-
 lib/swiotlb.c                  |  18 +++----
 net/can/gw.c                   |  30 +++++++++--
 net/sunrpc/svc.c               |  10 ++--
 net/sunrpc/svc_xprt.c          |   5 +-
 net/sunrpc/svcsock.c           |   2 +-
 virt/kvm/arm/vgic.c            |  11 +---
 virt/kvm/kvm_main.c            |  19 ++++++-
 21 files changed, 201 insertions(+), 125 deletions(-)

Ben Hutchings (1):
      Linux 3.16.64

Brian Foster (1):
      xfs: don't BUG() on mixed direct and mapped I/O

Christoffer Dall (2):
      KVM: PPC: Move xics_debugfs_init out of create
      KVM: Protect device ops->create and list_add with kvm->lock

Dan Carpenter (1):
      KVM: use after free in kvm_ioctl_create_device()

Hui Peng (1):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Jann Horn (1):
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Jiri Kosina (1):
      HID: debug: fix error handling in hid_debug_events_read()

Kees Cook (1):
      swiotlb: clean up reporting

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)

Rasmus Villemoes (1):
      HID: debug: improve hid_debug_event()

Rohit Vaswani (1):
      mm: cma: fix incorrect type conversion for size during dma allocation

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation

Willy Tarreau (1):
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT


--f3zqrbarnqt3do53
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.64.patch"
Content-Disposition: attachment; filename="linux-3.16.64.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Makefile b/Makefile
index 8d67c849c7e8..5f9f8b3c9214 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 63
+SUBLEVEL =3D 64
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 03ab35a58836..5dcac8df0a85 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -799,10 +799,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
=20
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
-		if (vgic_present)
-			return kvm_vgic_create(kvm);
-		else
+		int ret;
+		if (!vgic_present)
 			return -ENXIO;
+		mutex_lock(&kvm->lock);
+		ret =3D kvm_vgic_create(kvm);
+		mutex_unlock(&kvm->lock);
+		return ret;
 	}
 	case KVM_ARM_SET_DEVICE_ADDR: {
 		struct kvm_arm_device_addr dev_addr;
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index d1acd32a64c0..6be2830c8753 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1239,20 +1239,16 @@ static int kvmppc_xics_create(struct kvm_device *de=
v, u32 type)
 	xics->kvm =3D kvm;
=20
 	/* Already there ? */
-	mutex_lock(&kvm->lock);
 	if (kvm->arch.xics)
 		ret =3D -EEXIST;
 	else
 		kvm->arch.xics =3D xics;
-	mutex_unlock(&kvm->lock);
=20
 	if (ret) {
 		kfree(xics);
 		return ret;
 	}
=20
-	xics_debugfs_init(xics);
-
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
 		/* Enable real mode support */
@@ -1264,9 +1260,17 @@ static int kvmppc_xics_create(struct kvm_device *dev=
, u32 type)
 	return 0;
 }
=20
+static void kvmppc_xics_init(struct kvm_device *dev)
+{
+	struct kvmppc_xics *xics =3D (struct kvmppc_xics *)dev->private;
+
+	xics_debugfs_init(xics);
+}
+
 struct kvm_device_ops kvm_xics_ops =3D {
 	.name =3D "kvm-xics",
 	.create =3D kvmppc_xics_create,
+	.init =3D kvmppc_xics_init,
 	.destroy =3D kvmppc_xics_free,
 	.set_attr =3D xics_set_attr,
 	.get_attr =3D xics_get_attr,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d3f1873eafc4..70c3146fe6ca 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6169,6 +6169,7 @@ static void free_nested(struct vcpu_vmx *vmx)
 {
 	if (!vmx->nested.vmxon)
 		return;
+	hrtimer_cancel(&vmx->nested.preemption_timer);
 	vmx->nested.vmxon =3D false;
 	if (vmx->nested.current_vmptr !=3D -1ull) {
 		nested_release_vmcs12(vmx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ffb64cfc7989..6babfe32e04b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4208,6 +4208,13 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 {
 	u32 access =3D (kvm_x86_ops->get_cpl(vcpu) =3D=3D 3) ? PFERR_USER_MASK : =
0;
=20
+	/*
+	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
+	 * is returned, but our callers are not ready for that and they blindly
+	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
+	 * uninitialized kernel stack memory into cr2 and error code.
+	 */
+	memset(exception, 0, sizeof(*exception));
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
 					  exception);
 }
diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 6467c919c509..8d6abb35ae55 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -313,7 +313,7 @@ static void clear_cma_bitmap(struct cma *cma, unsigned =
long pfn, int count)
  * global one. Requires architecture specific dev_get_cma_area() helper
  * function.
  */
-struct page *dma_alloc_from_contiguous(struct device *dev, int count,
+struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align)
 {
 	unsigned long mask, pfn, pageno, start =3D 0;
@@ -327,7 +327,7 @@ struct page *dma_alloc_from_contiguous(struct device *d=
ev, int count,
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align =3D CONFIG_CMA_ALIGNMENT;
=20
-	pr_debug("%s(cma %p, count %d, align %d)\n", __func__, (void *)cma,
+	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
 		 count, align);
=20
 	if (!count)
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7192fa1d2786..d5eaf5b8460e 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -30,6 +30,7 @@
=20
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/kfifo.h>
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -658,17 +659,12 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	int i;
 	struct hid_debug_list *list;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
-	list_for_each_entry(list, &hdev->debug_list, node) {
-		for (i =3D 0; i < strlen(buf); i++)
-			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =3D
-				buf[i];
-		list->tail =3D (list->tail + i) % HID_DEBUG_BUFSIZE;
-        }
+	list_for_each_entry(list, &hdev->debug_list, node)
+		kfifo_in(&list->hid_debug_fifo, buf, strlen(buf));
 	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
=20
 	wake_up_interruptible(&hdev->debug_wait);
@@ -719,8 +715,7 @@ void hid_dump_input(struct hid_device *hdev, struct hid=
_usage *usage, __s32 valu
 	hid_debug_event(hdev, buf);
=20
 	kfree(buf);
-        wake_up_interruptible(&hdev->debug_wait);
-
+	wake_up_interruptible(&hdev->debug_wait);
 }
 EXPORT_SYMBOL_GPL(hid_dump_input);
=20
@@ -1085,8 +1080,8 @@ static int hid_debug_events_open(struct inode *inode,=
 struct file *file)
 		goto out;
 	}
=20
-	if (!(list->hid_debug_buf =3D kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, G=
FP_KERNEL))) {
-		err =3D -ENOMEM;
+	err =3D kfifo_alloc(&list->hid_debug_fifo, HID_DEBUG_FIFOSIZE, GFP_KERNEL=
);
+	if (err) {
 		kfree(list);
 		goto out;
 	}
@@ -1106,76 +1101,57 @@ static ssize_t hid_debug_events_read(struct file *f=
ile, char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	struct hid_debug_list *list =3D file->private_data;
-	int ret =3D 0, len;
+	int ret =3D 0, copied;
 	DECLARE_WAITQUEUE(wait, current);
=20
 	mutex_lock(&list->read_mutex);
-	while (ret =3D=3D 0) {
-		if (list->head =3D=3D list->tail) {
-			add_wait_queue(&list->hdev->debug_wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
-
-			while (list->head =3D=3D list->tail) {
-				if (file->f_flags & O_NONBLOCK) {
-					ret =3D -EAGAIN;
-					break;
-				}
-				if (signal_pending(current)) {
-					ret =3D -ERESTARTSYS;
-					break;
-				}
+	if (kfifo_is_empty(&list->hid_debug_fifo)) {
+		add_wait_queue(&list->hdev->debug_wait, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		while (kfifo_is_empty(&list->hid_debug_fifo)) {
+			if (file->f_flags & O_NONBLOCK) {
+				ret =3D -EAGAIN;
+				break;
+			}
=20
-				if (!list->hdev || !list->hdev->debug) {
-					ret =3D -EIO;
-					break;
-				}
+			if (signal_pending(current)) {
+				ret =3D -ERESTARTSYS;
+				break;
+			}
=20
-				/* allow O_NONBLOCK from other threads */
-				mutex_unlock(&list->read_mutex);
-				schedule();
-				mutex_lock(&list->read_mutex);
-				set_current_state(TASK_INTERRUPTIBLE);
+			/* if list->hdev is NULL we cannot remove_wait_queue().
+			 * if list->hdev->debug is 0 then hid_debug_unregister()
+			 * was already called and list->hdev is being destroyed.
+			 * if we add remove_wait_queue() here we can hit a race.
+			 */
+			if (!list->hdev || !list->hdev->debug) {
+				ret =3D -EIO;
+				set_current_state(TASK_RUNNING);
+				goto out;
 			}
=20
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&list->hdev->debug_wait, &wait);
+			/* allow O_NONBLOCK from other threads */
+			mutex_unlock(&list->read_mutex);
+			schedule();
+			mutex_lock(&list->read_mutex);
+			set_current_state(TASK_INTERRUPTIBLE);
 		}
=20
-		if (ret)
-			goto out;
+		__set_current_state(TASK_RUNNING);
+		remove_wait_queue(&list->hdev->debug_wait, &wait);
=20
-		/* pass the ringbuffer contents to userspace */
-copy_rest:
-		if (list->tail =3D=3D list->head)
+		if (ret)
 			goto out;
-		if (list->tail > list->head) {
-			len =3D list->tail - list->head;
-			if (len > count)
-				len =3D count;
-
-			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
-				ret =3D -EFAULT;
-				goto out;
-			}
-			ret +=3D len;
-			list->head +=3D len;
-		} else {
-			len =3D HID_DEBUG_BUFSIZE - list->head;
-			if (len > count)
-				len =3D count;
-
-			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
-				ret =3D -EFAULT;
-				goto out;
-			}
-			list->head =3D 0;
-			ret +=3D len;
-			count -=3D len;
-			if (count > 0)
-				goto copy_rest;
-		}
-
 	}
+
+	/* pass the fifo content to userspace, locking is not needed with only
+	 * one concurrent reader and one concurrent writer
+	 */
+	ret =3D kfifo_to_user(&list->hid_debug_fifo, buffer, count, &copied);
+	if (ret)
+		goto out;
+	ret =3D copied;
 out:
 	mutex_unlock(&list->read_mutex);
 	return ret;
@@ -1186,7 +1162,7 @@ static unsigned int hid_debug_events_poll(struct file=
 *file, poll_table *wait)
 	struct hid_debug_list *list =3D file->private_data;
=20
 	poll_wait(file, &list->hdev->debug_wait, wait);
-	if (list->head !=3D list->tail)
+	if (!kfifo_is_empty(&list->hid_debug_fifo))
 		return POLLIN | POLLRDNORM;
 	if (!list->hdev->debug)
 		return POLLERR | POLLHUP;
@@ -1201,7 +1177,7 @@ static int hid_debug_events_release(struct inode *ino=
de, struct file *file)
 	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
-	kfree(list->hid_debug_buf);
+	kfifo_free(&list->hid_debug_fifo);
 	kfree(list);
=20
 	return 0;
@@ -1252,4 +1228,3 @@ void hid_debug_exit(void)
 {
 	debugfs_remove_recursive(hid_debug_root);
 }
-
diff --git a/drivers/net/appletalk/ipddp.c b/drivers/net/appletalk/ipddp.c
index 10d0dba572c2..4d4476ce8799 100644
--- a/drivers/net/appletalk/ipddp.c
+++ b/drivers/net/appletalk/ipddp.c
@@ -284,8 +284,12 @@ static int ipddp_ioctl(struct net_device *dev, struct =
ifreq *ifr, int cmd)
                 case SIOCFINDIPDDPRT:
 			spin_lock_bh(&ipddp_route_lock);
 			rp =3D __ipddp_find_route(&rcp);
-			if (rp)
-				memcpy(&rcp2, rp, sizeof(rcp2));
+			if (rp) {
+				memset(&rcp2, 0, sizeof(rcp2));
+				rcp2.ip    =3D rp->ip;
+				rcp2.at    =3D rp->at;
+				rcp2.flags =3D rp->flags;
+			}
 			spin_unlock_bh(&ipddp_route_lock);
=20
 			if (rp) {
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index a4272ed62da8..142fada0b1e8 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2812,6 +2812,12 @@ static int hso_get_config_data(struct usb_interface =
*interface)
 		return -EIO;
 	}
=20
+	/* check if we have a valid interface */
+	if (if_num > 16) {
+		kfree(config_data);
+		return -EINVAL;
+	}
+
 	switch (config_data[if_num]) {
 	case 0x0:
 		result =3D 0;
@@ -2882,10 +2888,18 @@ static int hso_probe(struct usb_interface *interfac=
e,
=20
 	/* Get the interface/port specification from either driver_info or from
 	 * the device itself */
-	if (id->driver_info)
+	if (id->driver_info) {
+		/* if_num is controlled by the device, driver_info is a 0 terminated
+		 * array. Make sure, the access is in bounds! */
+		for (i =3D 0; i <=3D if_num; ++i)
+			if (((u32 *)(id->driver_info))[i] =3D=3D 0)
+				goto exit;
 		port_spec =3D ((u32 *)(id->driver_info))[if_num];
-	else
+	} else {
 		port_spec =3D hso_get_config_data(interface);
+		if (port_spec < 0)
+			goto exit;
+	}
=20
 	/* Check if we need to switch to alt interfaces prior to port
 	 * configuration */
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3fc699ea7ba0..91b3106fda9b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1300,6 +1300,26 @@ __xfs_get_blocks(
 	if (error)
 		goto out_unlock;
=20
+	/*
+	 * The only time we can ever safely find delalloc blocks on direct I/O
+	 * is a dio write to post-eof speculative preallocation. All other
+	 * scenarios are indicative of a problem or misuse (such as mixing
+	 * direct and mapped I/O).
+	 *
+	 * The file may be unmapped by the time we get here so we cannot
+	 * reliably fail the I/O based on mapping. Instead, fail the I/O if this
+	 * is a read or a write within eof. Otherwise, carry on but warn as a
+	 * precuation if the file happens to be mapped.
+	 */
+	if (direct && imap.br_startblock =3D=3D DELAYSTARTBLOCK) {
+		if (!create || offset < i_size_read(VFS_I(ip))) {
+			WARN_ON_ONCE(1);
+			error =3D EIO;
+			goto out_unlock;
+		}
+		WARN_ON_ONCE(mapping_mapped(VFS_I(ip)->i_mapping));
+	}
+
 	if (create &&
 	    (!nimaps ||
 	     (imap.br_startblock =3D=3D HOLESTARTBLOCK ||
@@ -1383,7 +1403,6 @@ __xfs_get_blocks(
 		set_buffer_new(bh_result);
=20
 	if (imap.br_startblock =3D=3D DELAYSTARTBLOCK) {
-		BUG_ON(direct);
 		if (create) {
 			set_buffer_uptodate(bh_result);
 			set_buffer_mapped(bh_result);
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 772eab5d524a..5e3f5863b5e3 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -116,7 +116,7 @@ static inline int dma_declare_contiguous(struct device =
*dev, phys_addr_t size,
 	return ret;
 }
=20
-struct page *dma_alloc_from_contiguous(struct device *dev, int count,
+struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
@@ -151,7 +151,7 @@ int dma_declare_contiguous(struct device *dev, phys_add=
r_t size,
 }
=20
 static inline
-struct page *dma_alloc_from_contiguous(struct device *dev, int count,
+struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order)
 {
 	return NULL;
diff --git a/include/linux/hid-debug.h b/include/linux/hid-debug.h
index 8663f216c563..2d6100edf204 100644
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -24,7 +24,10 @@
=20
 #ifdef CONFIG_DEBUG_FS
=20
+#include <linux/kfifo.h>
+
 #define HID_DEBUG_BUFSIZE 512
+#define HID_DEBUG_FIFOSIZE 512
=20
 void hid_dump_input(struct hid_device *, struct hid_usage *, __s32);
 void hid_dump_report(struct hid_device *, int , u8 *, int);
@@ -37,11 +40,8 @@ void hid_debug_init(void);
 void hid_debug_exit(void);
 void hid_debug_event(struct hid_device *, char *);
=20
-
 struct hid_debug_list {
-	char *hid_debug_buf;
-	int head;
-	int tail;
+	DECLARE_KFIFO_PTR(hid_debug_fifo, char);
 	struct fasync_struct *fasync;
 	struct hid_device *hdev;
 	struct list_head node;
@@ -64,4 +64,3 @@ struct hid_debug_list {
 #endif
=20
 #endif
-
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0b9b56809dab..4f10dcf3e76b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1059,8 +1059,20 @@ struct kvm_device {
 /* create, destroy, and name are mandatory */
 struct kvm_device_ops {
 	const char *name;
+
+	/*
+	 * create is called holding kvm->lock and any operations not suitable
+	 * to do while holding the lock should be deferred to init (see
+	 * below).
+	 */
 	int (*create)(struct kvm_device *dev, u32 type);
=20
+	/*
+	 * init is called after create if create is successful and is called
+	 * outside of holding kvm->lock.
+	 */
+	void (*init)(struct kvm_device *dev);
+
 	/*
 	 * Destroy is responsible for freeing dev.
 	 *
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1bc7cd05b22e..999a9911d7bd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -282,9 +282,12 @@ struct svc_rqst {
 						 * cache pages */
 	wait_queue_head_t	rq_wait;	/* synchronization */
 	struct task_struct	*rq_task;	/* service thread */
+	struct net		*rq_bc_net;	/* pointer to backchannel's
+						 * net namespace
+						 */
 };
=20
-#define SVC_NET(svc_rqst)	(svc_rqst->rq_xprt->xpt_net)
+#define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_b=
c_net)
=20
 /*
  * Rigorous type checking on sockaddr type conversions
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 4abda074ea45..54179db71ab4 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -17,6 +17,8 @@
  * 08/12/11 beckyb	Add highmem support
  */
=20
+#define pr_fmt(fmt) "software IO TLB: " fmt
+
 #include <linux/cache.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
@@ -143,20 +145,16 @@ static bool no_iotlb_memory;
 void swiotlb_print_info(void)
 {
 	unsigned long bytes =3D io_tlb_nslabs << IO_TLB_SHIFT;
-	unsigned char *vstart, *vend;
=20
 	if (no_iotlb_memory) {
-		pr_warn("software IO TLB: No low mem\n");
+		pr_warn("No low mem\n");
 		return;
 	}
=20
-	vstart =3D phys_to_virt(io_tlb_start);
-	vend =3D phys_to_virt(io_tlb_end);
-
-	printk(KERN_INFO "software IO TLB [mem %#010llx-%#010llx] (%luMB) mapped =
at [%p-%p]\n",
+	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
 	       (unsigned long long)io_tlb_start,
 	       (unsigned long long)io_tlb_end,
-	       bytes >> 20, vstart, vend - 1);
+	       bytes >> 20);
 }
=20
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verb=
ose)
@@ -230,7 +228,7 @@ swiotlb_init(int verbose)
 	if (io_tlb_start)
 		memblock_free_early(io_tlb_start,
 				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
-	pr_warn("Cannot allocate SWIOTLB buffer");
+	pr_warn("Cannot allocate buffer");
 	no_iotlb_memory =3D true;
 }
=20
@@ -272,8 +270,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
 		return -ENOMEM;
 	}
 	if (order !=3D get_order(bytes)) {
-		printk(KERN_WARNING "Warning: only able to allocate %ld MB "
-		       "for software IO TLB\n", (PAGE_SIZE << order) >> 20);
+		pr_warn("only able to allocate %ld MB\n",
+			(PAGE_SIZE << order) >> 20);
 		io_tlb_nslabs =3D SLABS_PER_PAGE << order;
 	}
 	rc =3D swiotlb_late_init_with_tbl(vstart, io_tlb_nslabs);
diff --git a/net/can/gw.c b/net/can/gw.c
index d4921582d3bd..4ccaf10bb658 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -417,13 +417,29 @@ static void can_can_gw_rcv(struct sk_buff *skb, void =
*data)
 	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
 		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
=20
-	/* check for checksum updates when the CAN frame has been modified */
+	/* Has the CAN frame been modified? */
 	if (modidx) {
-		if (gwj->mod.csumfunc.crc8)
+		/* get available space for the processed CAN frame type */
+		int max_len =3D nskb->len - offsetof(struct can_frame, data);
+
+		/* dlc may have changed, make sure it fits to the CAN frame */
+		if (cf->can_dlc > max_len)
+			goto out_delete;
+
+		/* check for checksum updates in classic CAN length only */
+		if (gwj->mod.csumfunc.crc8) {
+			if (cf->can_dlc > 8)
+				goto out_delete;
+
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		}
+
+		if (gwj->mod.csumfunc.xor) {
+			if (cf->can_dlc > 8)
+				goto out_delete;
=20
-		if (gwj->mod.csumfunc.xor)
 			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		}
 	}
=20
 	/* clear the skb timestamp if not configured the other way */
@@ -435,6 +451,14 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *=
data)
 		gwj->dropped_frames++;
 	else
 		gwj->handled_frames++;
+
+	return;
+
+ out_delete:
+	/* delete frame due to misconfiguration */
+	gwj->deleted_frames++;
+	kfree_skb(nskb);
+	return;
 }
=20
 static inline int cgw_register_filter(struct cgw_job *gwj)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a7e5624a1cf2..e9b2eaedbdf7 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1063,6 +1063,8 @@ void svc_printk(struct svc_rqst *rqstp, const char *f=
mt, ...)
 static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *f=
mt, ...) {}
 #endif
=20
+extern void svc_tcp_prep_reply_hdr(struct svc_rqst *);
+
 /*
  * Common routine for processing the RPC request.
  */
@@ -1092,7 +1094,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
c *argv, struct kvec *resv)
 	rqstp->rq_dropme =3D false;
=20
 	/* Setup reply header */
-	rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr(rqstp);
+	if (rqstp->rq_prot =3D=3D IPPROTO_TCP)
+		svc_tcp_prep_reply_hdr(rqstp);
=20
 	svc_putu32(resv, rqstp->rq_xid);
=20
@@ -1139,7 +1142,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
c *argv, struct kvec *resv)
 	case SVC_DENIED:
 		goto err_bad_auth;
 	case SVC_CLOSE:
-		if (test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
+		if (rqstp->rq_xprt &&
+		    test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
 			svc_close_xprt(rqstp->rq_xprt);
 	case SVC_DROP:
 		goto dropit;
@@ -1354,10 +1358,10 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rq=
st *req,
 	struct kvec	*resv =3D &rqstp->rq_res.head[0];
=20
 	/* Build the svc_rqst used by the common processing routine */
-	rqstp->rq_xprt =3D serv->sv_bc_xprt;
 	rqstp->rq_xid =3D req->rq_xid;
 	rqstp->rq_prot =3D req->rq_xprt->prot;
 	rqstp->rq_server =3D serv;
+	rqstp->rq_bc_net =3D req->rq_xprt->xprt_net;
=20
 	rqstp->rq_addrlen =3D sizeof(req->rq_xprt->addr);
 	memcpy(&rqstp->rq_addr, &req->rq_xprt->addr, rqstp->rq_addrlen);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index de5e3636d5ad..c7ae9ec430b8 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -432,10 +432,11 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_p=
ool *pool)
  */
 void svc_reserve(struct svc_rqst *rqstp, int space)
 {
+	struct svc_xprt *xprt =3D rqstp->rq_xprt;
+
 	space +=3D rqstp->rq_res.head[0].iov_len;
=20
-	if (space < rqstp->rq_reserved) {
-		struct svc_xprt *xprt =3D rqstp->rq_xprt;
+	if (xprt && space < rqstp->rq_reserved) {
 		atomic_sub((rqstp->rq_reserved - space), &xprt->xpt_reserved);
 		rqstp->rq_reserved =3D space;
=20
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 89a4db5be155..d4991f2b0dc8 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1195,7 +1195,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 /*
  * Setup response header. TCP has a 4B record length field.
  */
-static void svc_tcp_prep_reply_hdr(struct svc_rqst *rqstp)
+void svc_tcp_prep_reply_hdr(struct svc_rqst *rqstp)
 {
 	struct kvec *resv =3D &rqstp->rq_res.head[0];
=20
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 24ac123f4ad8..7b490485712c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1624,12 +1624,8 @@ int kvm_vgic_create(struct kvm *kvm)
 	int i, vcpu_lock_idx =3D -1, ret;
 	struct kvm_vcpu *vcpu;
=20
-	mutex_lock(&kvm->lock);
-
-	if (kvm->arch.vgic.vctrl_base) {
-		ret =3D -EEXIST;
-		goto out;
-	}
+	if (kvm->arch.vgic.vctrl_base)
+		return -EEXIST;
=20
 	/*
 	 * Any time a vcpu is run, vcpu_load is called which tries to grab the
@@ -1659,9 +1655,6 @@ int kvm_vgic_create(struct kvm *kvm)
 		vcpu =3D kvm_get_vcpu(kvm, vcpu_lock_idx);
 		mutex_unlock(&vcpu->mutex);
 	}
-
-out:
-	mutex_unlock(&kvm->lock);
 	return ret;
 }
=20
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1cfe0c62b128..111663da72ad 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -587,6 +587,11 @@ static void kvm_destroy_devices(struct kvm *kvm)
 {
 	struct list_head *node, *tmp;
=20
+	/*
+	 * We do not need to take the kvm->lock here, because nobody else
+	 * has a reference to the struct kvm at this point and therefore
+	 * cannot access the devices list anyhow.
+	 */
 	list_for_each_safe(node, tmp, &kvm->devices) {
 		struct kvm_device *dev =3D
 			list_entry(node, struct kvm_device, vm_node);
@@ -2322,20 +2327,30 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	dev->ops =3D ops;
 	dev->kvm =3D kvm;
=20
+	mutex_lock(&kvm->lock);
 	ret =3D ops->create(dev, cd->type);
 	if (ret < 0) {
+		mutex_unlock(&kvm->lock);
 		kfree(dev);
 		return ret;
 	}
+	list_add(&dev->vm_node, &kvm->devices);
+	mutex_unlock(&kvm->lock);
+
+	if (ops->init)
+		ops->init(dev);
=20
+	kvm_get_kvm(kvm);
 	ret =3D anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLO=
EXEC);
 	if (ret < 0) {
+		kvm_put_kvm(kvm);
+		mutex_lock(&kvm->lock);
+		list_del(&dev->vm_node);
+		mutex_unlock(&kvm->lock);
 		ops->destroy(dev);
 		return ret;
 	}
=20
-	list_add(&dev->vm_node, &kvm->devices);
-	kvm_get_kvm(kvm);
 	cd->fd =3D ret;
 	return 0;
 }

--f3zqrbarnqt3do53--

--mdsgvlqioez6fubw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyZOnQACgkQ57/I7JWG
EQkyCQ//RGhmIzW4tF5RxnraDDut5pc0kaU+Zlt09qhDwPDQnDhRixPTLvvKDF6p
7MdbytBIAzFbjcf29hRIDqnMSEwKKLbxb0jQgQJOLNqx1mFF0SuhqKeXzyoKdjpQ
4VQVjfqNA6nD3e/DZ7yEY54dQ9b3Xh3Dkn4jW4ThxLq84jxgiDoEZmUy9cpykZ/A
lBPcmKgrGCDghCyrJXFwU3gu9co1Y0XaXGVCgKdr4Lh+oYiRtUksrwZBXovlki6E
qhxRDHQADJzj2ETpTZW6RK6z7PNQC4cqEOCBDbFHgCslsP9WJ52A85+2gWKNFKVB
sNVhzL+1y61IeF9PSwsxlYNlul+HedwpLwgnF28LMGn/tP+gMwVt4vp1tI7+EhaZ
ZdjFs8rMnxBPSB1hJ2n1/JybduoYP0u45D2ikL/7eZPp58DuXiNbjbiy6Yjr9VEK
fsXxJnVgmmsz6j3DXZh9pGiZA/iy38K2I7ldVmVrJWKFB634Kgmotz92tDxGsKB1
ljQoYRBqosSpHmV/jLQThOzLQP4mrOZjIqAGpIzZLZM9MJLhtSgBTzv6nFIlZFPb
Llz3t8KQq5qdijobaNUzHrS2hVqqlt+hQAvIYSQPbsJPuf/n4wVBVc7ClphOkT8m
B7jDjYdAO9uyu47Uv6dfH1YOC/MqFAzlzI+kUFT0Xukyvyb7X4k=
=Cbdq
-----END PGP SIGNATURE-----

--mdsgvlqioez6fubw--
