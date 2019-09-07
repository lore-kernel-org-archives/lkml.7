Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF811C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 09:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD7208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 09:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394601AbfIGJJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 05:09:55 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:38559 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbfIGJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 05:09:55 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6Wj8-000Npv-5z; Sat, 07 Sep 2019 11:09:50 +0200
Received: from 145-126.cable.senselan.ch ([83.222.145.126] helo=volery)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6Wj8-000CZ5-24; Sat, 07 Sep 2019 11:09:50 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Sat, 7 Sep 2019 11:09:48 +0200
From:   volery <sandro@volery.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Cc:     sandro@volery.com
Subject: [PATCH] Fixed most indent issues in tty_io.c
Message-ID: <20190907090948.GA5824@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a lot of styling problems using space then tab or spaces
instead of tabs in that file. Especially the entire function at line
2677.
Also added a space before the : on line 2221.

Signed-off-by: Sandro Volery <sandro@volery.com>
---
 drivers/tty/tty_io.c | 60 ++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 566728fbaf3c..38c36ff7221b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -33,7 +33,7 @@
  *	-- Nick Holloway <alfie@dcs.warwick.ac.uk>, 27th May 1993.
  *
  * Rewrote canonical mode and added more termios flags.
- * 	-- julian@uhunix.uhcc.hawaii.edu (J. Cowley), 13Jan94
+ *	-- julian@uhunix.uhcc.hawaii.edu (J. Cowley), 13Jan94
  *
  * Reorganized FASYNC support so mouse code can share it.
  *	-- ctm@ardi.com, 9Sep95
@@ -1026,13 +1026,13 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
 						size_t count, loff_t *ppos)
 {
 	struct tty_struct *tty = file_tty(file);
- 	struct tty_ldisc *ld;
+	struct tty_ldisc *ld;
 	ssize_t ret;
 
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
 		return -EIO;
 	if (!tty || !tty->ops->write ||	tty_io_error(tty))
-			return -EIO;
+		return -EIO;
 	/* Short term debug to catch buggy drivers */
 	if (tty->ops->write_room == NULL)
 		tty_err(tty, "missing write_room method\n");
@@ -1247,8 +1247,8 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 }
 
 /*
- * 	tty_reopen()	- fast re-open of an open tty
- * 	@tty	- the tty to open
+ *	tty_reopen()	- fast re-open of an open tty
+ *	@tty	- the tty to open
  *
  *	Return 0 on success, -errno on error.
  *	Re-opens on master ptys are not allowed and return -EIO.
@@ -1829,8 +1829,8 @@ static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
  *	@index: index for the device in the @return driver
  *	@return: driver for this inode (with increased refcount)
  *
- * 	If @return is not erroneous, the caller is responsible to decrement the
- * 	refcount by tty_driver_kref_put.
+ *	If @return is not erroneous, the caller is responsible to decrement the
+ *	refcount by tty_driver_kref_put.
  *
  *	Locking: tty_mutex protects get_tty_driver
  */
@@ -2218,7 +2218,7 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 	err = copy_to_user(arg, &tty->winsize, sizeof(*arg));
 	mutex_unlock(&tty->winsize_mutex);
 
-	return err ? -EFAULT: 0;
+	return err ? -EFAULT : 0;
 }
 
 /**
@@ -2674,25 +2674,25 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #ifdef CONFIG_COMPAT
 
 struct serial_struct32 {
-        compat_int_t    type;
-        compat_int_t    line;
-        compat_uint_t   port;
-        compat_int_t    irq;
-        compat_int_t    flags;
-        compat_int_t    xmit_fifo_size;
-        compat_int_t    custom_divisor;
-        compat_int_t    baud_base;
-        unsigned short  close_delay;
-        char    io_type;
-        char    reserved_char[1];
-        compat_int_t    hub6;
-        unsigned short  closing_wait; /* time to wait before closing */
-        unsigned short  closing_wait2; /* no longer used... */
-        compat_uint_t   iomem_base;
-        unsigned short  iomem_reg_shift;
-        unsigned int    port_high;
+	compat_int_t    type;
+	compat_int_t    line;
+	compat_uint_t   port;
+	compat_int_t    irq;
+	compat_int_t    flags;
+	compat_int_t    xmit_fifo_size;
+	compat_int_t    custom_divisor;
+	compat_int_t    baud_base;
+	unsigned short  close_delay;
+	char    io_type;
+	char    reserved_char[1];
+	compat_int_t    hub6;
+	unsigned short  closing_wait; /* time to wait before closing */
+	unsigned short  closing_wait2; /* no longer used... */
+	compat_uint_t   iomem_base;
+	unsigned short  iomem_reg_shift;
+	unsigned int    port_high;
      /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved[1];
+	compat_int_t    reserved[1];
 };
 
 static int compat_tty_tiocsserial(struct tty_struct *tty,
@@ -3176,11 +3176,11 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
 
 /**
- * 	tty_unregister_device - unregister a tty device
- * 	@driver: the tty driver that describes the tty device
- * 	@index: the index in the tty driver for this tty device
+ *	tty_unregister_device - unregister a tty device
+ *	@driver: the tty driver that describes the tty device
+ *	@index: the index in the tty driver for this tty device
  *
- * 	If a tty device is registered with a call to tty_register_device() then
+ *	If a tty device is registered with a call to tty_register_device() then
  *	this function must be called when the tty device is gone.
  *
  *	Locking: ??
-- 
2.23.0

