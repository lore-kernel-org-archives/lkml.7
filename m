Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95923C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F29920656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383564;
	bh=UCOnBAe0ahnRrtxM0rmRjrrB6nod5h0Cl8wN3BHK6uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h2gUSUAxmaH4LErofSbWK4D7mQ2Us4XJRW7CbDKnT85uPJoil1gsNFlGC0NBQ0lDL
	 Y4InYETi+Tj8GdQgxqV7qJGdcwvSAmGE3z1K/Ktr99ETTQ+nQppxU4K4uKRGoQEks1
	 AnUvhg8muj92x2RHmgZzGkH0tD+YxL4jVJbxkX4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDPC7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfDPC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wNlzEnJEwXbWBwB2Srm0euEohaype+9jkObYSm8PJJk=; b=WpXROxnPkf4FBnV3XM3KUstRp/
        f7U6KtNkZGLK+2fUvs5JtJOq9u7NBe0XxhiLx4sAADx2Z7LpCG6cOidHUdSVXzgF764jOPpNLjaDt
        s6uUB9ov34q0UC1hQHcQtHdmG++ZqI/TnUb6ZoUduPZVgf2RX3WrriGmjAmxK3qQmhlwbH9utul9e
        HKZdLTKOzhL7jFGDZi8sIDJsLgsyGQAP1USmlgvGoM+r3omW99jl49xjfzLcSrT9TTFwp9b4Vjv1+
        li5x5essMioCMJOw09cmViPmNwG4106T868icLCQhOUMtR4I3jCEp9pzk1X/CxBgvDP4c/4ffvIr9
        Gaef3Dlg==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007af-MQ; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001nf-HM; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 24/57] docs: pcmcia: convert it to ReST format
Date:   Mon, 15 Apr 2019 23:55:49 -0300
Message-Id: <e3c4827b8f33af90e4628de6590c6e040a20779c.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pcmcia docs to ReST format. Most of the changes here
are trivial, making Sphinx properly identify titles, lists and
literal blocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/pcmcia/devicetable.txt    |  4 +++
 Documentation/pcmcia/driver-changes.txt | 35 ++++++++++++++--------
 Documentation/pcmcia/driver.txt         | 18 ++++++------
 Documentation/pcmcia/locking.txt        | 39 +++++++++++++++++--------
 4 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/Documentation/pcmcia/devicetable.txt b/Documentation/pcmcia/devicetable.txt
index 5f3e00ab54c4..fd1d60d12ca1 100644
--- a/Documentation/pcmcia/devicetable.txt
+++ b/Documentation/pcmcia/devicetable.txt
@@ -1,3 +1,7 @@
+============
+Device table
+============
+
 Matching of PCMCIA devices to drivers is done using one or more of the
 following criteria:
 
diff --git a/Documentation/pcmcia/driver-changes.txt b/Documentation/pcmcia/driver-changes.txt
index 78355c4c268a..33fe9ebec049 100644
--- a/Documentation/pcmcia/driver-changes.txt
+++ b/Documentation/pcmcia/driver-changes.txt
@@ -1,15 +1,21 @@
+==============
+Driver changes
+==============
+
 This file details changes in 2.6 which affect PCMCIA card driver authors:
+
 * pcmcia_loop_config() and autoconfiguration (as of 2.6.36)
-   If struct pcmcia_device *p_dev->config_flags is set accordingly,
+   If `struct pcmcia_device *p_dev->config_flags` is set accordingly,
    pcmcia_loop_config() now sets up certain configuration values
    automatically, though the driver may still override the settings
    in the callback function. The following autoconfiguration options
    are provided at the moment:
-	CONF_AUTO_CHECK_VCC : check for matching Vcc
-	CONF_AUTO_SET_VPP   : set Vpp
-	CONF_AUTO_AUDIO     : auto-enable audio line, if required
-	CONF_AUTO_SET_IO    : set ioport resources (->resource[0,1])
-	CONF_AUTO_SET_IOMEM : set first iomem resource (->resource[2])
+
+	- CONF_AUTO_CHECK_VCC : check for matching Vcc
+	- CONF_AUTO_SET_VPP   : set Vpp
+	- CONF_AUTO_AUDIO     : auto-enable audio line, if required
+	- CONF_AUTO_SET_IO    : set ioport resources (->resource[0,1])
+	- CONF_AUTO_SET_IOMEM : set first iomem resource (->resource[2])
 
 * pcmcia_request_configuration -> pcmcia_enable_device (as of 2.6.36)
    pcmcia_request_configuration() got renamed to pcmcia_enable_device(),
@@ -19,14 +25,14 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
 
 * pcmcia_request_window changes (as of 2.6.36)
    Instead of win_req_t, drivers are now requested to fill out
-   struct pcmcia_device *p_dev->resource[2,3,4,5] for up to four ioport
+   `struct pcmcia_device *p_dev->resource[2,3,4,5]` for up to four ioport
    ranges. After a call to pcmcia_request_window(), the regions found there
    are reserved and may be used immediately -- until pcmcia_release_window()
    is called.
 
 * pcmcia_request_io changes (as of 2.6.36)
    Instead of io_req_t, drivers are now requested to fill out
-   struct pcmcia_device *p_dev->resource[0,1] for up to two ioport
+   `struct pcmcia_device *p_dev->resource[0,1]` for up to two ioport
    ranges. After a call to pcmcia_request_io(), the ports found there
    are reserved, after calling pcmcia_request_configuration(), they may
    be used.
@@ -42,7 +48,8 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
 * New IRQ request rules (as of 2.6.35)
    Instead of the old pcmcia_request_irq() interface, drivers may now
    choose between:
-   - calling request_irq/free_irq directly. Use the IRQ from *p_dev->irq.
+
+   - calling request_irq/free_irq directly. Use the IRQ from `*p_dev->irq`.
    - use pcmcia_request_irq(p_dev, handler_t); the PCMCIA core will
      clean up automatically on calls to pcmcia_disable_device() or
      device ejection.
@@ -72,13 +79,16 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
    exports for them were removed.
 
 * Unify detach and REMOVAL event code, as well as attach and INSERTION
-  code (as of 2.6.16)
+  code (as of 2.6.16)::
+
        void (*remove)          (struct pcmcia_device *dev);
        int (*probe)            (struct pcmcia_device *dev);
 
-* Move suspend, resume and reset out of event handler (as of 2.6.16)
+* Move suspend, resume and reset out of event handler (as of 2.6.16)::
+
        int (*suspend)          (struct pcmcia_device *dev);
        int (*resume)           (struct pcmcia_device *dev);
+
   should be initialized in struct pcmcia_driver, and handle
   (SUSPEND == RESET_PHYSICAL) and (RESUME == CARD_RESET) events
 
@@ -117,7 +127,8 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
 * core functions no longer available (as of 2.6.11)
    The following functions have been removed from the kernel source
    because they are unused by all in-kernel drivers, and no external
-   driver was reported to rely on them:
+   driver was reported to rely on them::
+
 	pcmcia_get_first_region()
 	pcmcia_get_next_region()
 	pcmcia_modify_window()
diff --git a/Documentation/pcmcia/driver.txt b/Documentation/pcmcia/driver.txt
index 0ac167920778..5c4fe84d51c1 100644
--- a/Documentation/pcmcia/driver.txt
+++ b/Documentation/pcmcia/driver.txt
@@ -1,16 +1,16 @@
+=============
 PCMCIA Driver
--------------
-
+=============
 
 sysfs
 -----
 
 New PCMCIA IDs may be added to a device driver pcmcia_device_id table at
-runtime as shown below:
+runtime as shown below::
 
-echo "match_flags manf_id card_id func_id function device_no \
-prod_id_hash[0] prod_id_hash[1] prod_id_hash[2] prod_id_hash[3]" > \
-/sys/bus/pcmcia/drivers/{driver}/new_id
+  echo "match_flags manf_id card_id func_id function device_no \
+  prod_id_hash[0] prod_id_hash[1] prod_id_hash[2] prod_id_hash[3]" > \
+  /sys/bus/pcmcia/drivers/{driver}/new_id
 
 All fields are passed in as hexadecimal values (no leading 0x).
 The meaning is described in the PCMCIA specification, the match_flags is
@@ -22,9 +22,9 @@ PCMCIA device listed in its (newly updated) pcmcia_device_id list.
 
 A common use-case is to add a new device according to the manufacturer ID
 and the card ID (form the manf_id and card_id file in the device tree).
-For this, just use:
+For this, just use::
 
-echo "0x3 manf_id card_id 0 0 0 0 0 0 0" > \
-        /sys/bus/pcmcia/drivers/{driver}/new_id
+  echo "0x3 manf_id card_id 0 0 0 0 0 0 0" > \
+    /sys/bus/pcmcia/drivers/{driver}/new_id
 
 after loading the driver.
diff --git a/Documentation/pcmcia/locking.txt b/Documentation/pcmcia/locking.txt
index b2c9b478906b..e35257139c89 100644
--- a/Documentation/pcmcia/locking.txt
+++ b/Documentation/pcmcia/locking.txt
@@ -1,3 +1,7 @@
+=======
+Locking
+=======
+
 This file explains the locking and exclusion scheme used in the PCCARD
 and PCMCIA subsystems.
 
@@ -5,16 +9,21 @@ and PCMCIA subsystems.
 A) Overview, Locking Hierarchy:
 ===============================
 
-pcmcia_socket_list_rwsem	- protects only the list of sockets
-- skt_mutex			- serializes card insert / ejection
-  - ops_mutex			- serializes socket operation
+pcmcia_socket_list_rwsem
+	- protects only the list of sockets
+
+- skt_mutex
+	- serializes card insert / ejection
+
+  - ops_mutex
+	- serializes socket operation
 
 
 B) Exclusion
 ============
 
 The following functions and callbacks to struct pcmcia_socket must
-be called with "skt_mutex" held:
+be called with "skt_mutex" held::
 
 	socket_detect_change()
 	send_event()
@@ -31,7 +40,7 @@ be called with "skt_mutex" held:
 	struct pcmcia_callback	*callback
 
 The following functions and callbacks to struct pcmcia_socket must
-be called with "ops_mutex" held:
+be called with "ops_mutex" held::
 
 	socket_reset()
 	socket_setup()
@@ -39,7 +48,7 @@ be called with "ops_mutex" held:
 	struct pccard_operations	*ops
 	struct pccard_resource_ops	*resource_ops;
 
-Note that send_event() and struct pcmcia_callback *callback must not be
+Note that send_event() and `struct pcmcia_callback *callback` must not be
 called with "ops_mutex" held.
 
 
@@ -60,19 +69,23 @@ The resource_ops and their data are protected by ops_mutex.
 The "main" struct pcmcia_socket is protected as follows (read-only fields
 or single-use fields not mentioned):
 
-- by pcmcia_socket_list_rwsem:
+- by pcmcia_socket_list_rwsem::
+
 	struct list_head	socket_list;
 
-- by thread_lock:
+- by thread_lock::
+
 	unsigned int		thread_events;
 
-- by skt_mutex:
+- by skt_mutex::
+
 	u_int			suspended_state;
 	void			(*tune_bridge);
 	struct pcmcia_callback	*callback;
 	int			resume_status;
 
-- by ops_mutex:
+- by ops_mutex::
+
 	socket_state_t		socket;
 	u_int			state;
 	u_short			lock_count;
@@ -100,7 +113,8 @@ The "main" struct pcmcia_device is protected as follows (read-only fields
 or single-use fields not mentioned):
 
 
-- by pcmcia_socket->ops_mutex:
+- by pcmcia_socket->ops_mutex::
+
 	struct list_head	socket_device_list;
 	struct config_t		*function_config;
 	u16			_irq:1;
@@ -111,7 +125,8 @@ or single-use fields not mentioned):
 	u16			suspended:1;
 	u16			_removed:1;
 
-- by the PCMCIA driver:
+- by the PCMCIA driver::
+
 	io_req_t		io;
 	irq_req_t		irq;
 	config_req_t		conf;
-- 
2.20.1

