Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC00C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE75420896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364740;
	bh=PDZr6JP7bdrH9gIxr23mL+Bc5u+bWnXAYdWzls5blbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SKK8XcPO5qKe79IsTB33RrTJgEh7YstvHc/BIvpjb0/IqTsCgscJKOkGGu4yzvaQa
	 4Q0k2hVbwT/xhGoSzxox+OAWR+87sh6B9tPR8YVoYTFS3NZeP77oqai2lPt45c7HsO
	 h70WbbOJ2nimiBVCratQpFybazsEid53GFnq6uFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfFLSi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:38:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfFLSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XU8uJnYmG4/O4PpJifibMong93YJp89jiSUBX/t4FPM=; b=VhtBdrW8S3dZOCEnF9MMFGclut
        eTYS3qwWrrRXwqLABwPdITjv02u1n6uqvnJoEV20k0GrzXP4UbyCAqm3wGj9+U6PCv0HDy2C6JAhA
        WTATg9JDlls4wVGcFcYUpooqmwMAUfqTUb26PC5qtgCewIo7V6+kHkcM3zietGOE/ZaRjEdA2SAAC
        S7nQHUmhDFXUdm4zWtb6qlv6M8rxyz6ATYM8cMeiRej1hmD8Jfoz4nUFfrGqPGWQ3PxS2500Kp58P
        W/b0+TkObZqGnZPYU0kLA09g0AhPpoy9mWeI3zQQfQs0Cp5bko9PkAp/nh6kwRkjCVW4vVjvJ5QUW
        xuN6tN5A==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YG-OK; Wed, 12 Jun 2019 18:38:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002Bv-Fs; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 26/31] docs: nfc: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:29 -0300
Message-Id: <2d238ceb1b712efcaf70e1a1bdd726a11fdf754f.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the nfc documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/nfc/index.rst                   |  11 ++
 .../nfc/{nfc-hci.txt => nfc-hci.rst}          | 163 ++++++++++--------
 .../nfc/{nfc-pn544.txt => nfc-pn544.rst}      |   6 +-
 3 files changed, 107 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/nfc/index.rst
 rename Documentation/nfc/{nfc-hci.txt => nfc-hci.rst} (71%)
 rename Documentation/nfc/{nfc-pn544.txt => nfc-pn544.rst} (82%)

diff --git a/Documentation/nfc/index.rst b/Documentation/nfc/index.rst
new file mode 100644
index 000000000000..4f4947fce80d
--- /dev/null
+++ b/Documentation/nfc/index.rst
@@ -0,0 +1,11 @@
+:orphan:
+
+========================
+Near Field Communication
+========================
+
+.. toctree::
+   :maxdepth: 1
+
+   nfc-hci
+   nfc-pn544
diff --git a/Documentation/nfc/nfc-hci.txt b/Documentation/nfc/nfc-hci.rst
similarity index 71%
rename from Documentation/nfc/nfc-hci.txt
rename to Documentation/nfc/nfc-hci.rst
index 0dc078cab972..eb8a1a14e919 100644
--- a/Documentation/nfc/nfc-hci.txt
+++ b/Documentation/nfc/nfc-hci.rst
@@ -1,7 +1,9 @@
+========================
 HCI backend for NFC Core
+========================
 
-Author: Eric Lapuyade, Samuel Ortiz
-Contact: eric.lapuyade@intel.com, samuel.ortiz@intel.com
+- Author: Eric Lapuyade, Samuel Ortiz
+- Contact: eric.lapuyade@intel.com, samuel.ortiz@intel.com
 
 General
 -------
@@ -24,12 +26,13 @@ HCI events can also be received from the host controller. They will be handled
 and a translation will be forwarded to NFC Core as needed. There are hooks to
 let the HCI driver handle proprietary events or override standard behavior.
 HCI uses 2 execution contexts:
+
 - one for executing commands : nfc_hci_msg_tx_work(). Only one command
-can be executing at any given moment.
+  can be executing at any given moment.
 - one for dispatching received events and commands : nfc_hci_msg_rx_work().
 
-HCI Session initialization:
----------------------------
+HCI Session initialization
+--------------------------
 
 The Session initialization is an HCI standard which must unfortunately
 support proprietary gates. This is the reason why the driver will pass a list
@@ -58,9 +61,9 @@ HCI Management
 --------------
 
 A driver would normally register itself with HCI and provide the following
-entry points:
+entry points::
 
-struct nfc_hci_ops {
+  struct nfc_hci_ops {
 	int (*open)(struct nfc_hci_dev *hdev);
 	void (*close)(struct nfc_hci_dev *hdev);
 	int (*hci_ready) (struct nfc_hci_dev *hdev);
@@ -82,38 +85,38 @@ struct nfc_hci_ops {
 			      struct nfc_target *target);
 	int (*event_received)(struct nfc_hci_dev *hdev, u8 gate, u8 event,
 			      struct sk_buff *skb);
-};
+  };
 
 - open() and close() shall turn the hardware on and off.
 - hci_ready() is an optional entry point that is called right after the hci
-session has been set up. The driver can use it to do additional initialization
-that must be performed using HCI commands.
+  session has been set up. The driver can use it to do additional initialization
+  that must be performed using HCI commands.
 - xmit() shall simply write a frame to the physical link.
 - start_poll() is an optional entrypoint that shall set the hardware in polling
-mode. This must be implemented only if the hardware uses proprietary gates or a
-mechanism slightly different from the HCI standard.
+  mode. This must be implemented only if the hardware uses proprietary gates or a
+  mechanism slightly different from the HCI standard.
 - dep_link_up() is called after a p2p target has been detected, to finish
-the p2p connection setup with hardware parameters that need to be passed back
-to nfc core.
+  the p2p connection setup with hardware parameters that need to be passed back
+  to nfc core.
 - dep_link_down() is called to bring the p2p link down.
 - target_from_gate() is an optional entrypoint to return the nfc protocols
-corresponding to a proprietary gate.
+  corresponding to a proprietary gate.
 - complete_target_discovered() is an optional entry point to let the driver
-perform additional proprietary processing necessary to auto activate the
-discovered target.
+  perform additional proprietary processing necessary to auto activate the
+  discovered target.
 - im_transceive() must be implemented by the driver if proprietary HCI commands
-are required to send data to the tag. Some tag types will require custom
-commands, others can be written to using the standard HCI commands. The driver
-can check the tag type and either do proprietary processing, or return 1 to ask
-for standard processing. The data exchange command itself must be sent
-asynchronously.
+  are required to send data to the tag. Some tag types will require custom
+  commands, others can be written to using the standard HCI commands. The driver
+  can check the tag type and either do proprietary processing, or return 1 to ask
+  for standard processing. The data exchange command itself must be sent
+  asynchronously.
 - tm_send() is called to send data in the case of a p2p connection
 - check_presence() is an optional entry point that will be called regularly
-by the core to check that an activated tag is still in the field. If this is
-not implemented, the core will not be able to push tag_lost events to the user
-space
+  by the core to check that an activated tag is still in the field. If this is
+  not implemented, the core will not be able to push tag_lost events to the user
+  space
 - event_received() is called to handle an event coming from the chip. Driver
-can handle the event or return 1 to let HCI attempt standard processing.
+  can handle the event or return 1 to let HCI attempt standard processing.
 
 On the rx path, the driver is responsible to push incoming HCP frames to HCI
 using nfc_hci_recv_frame(). HCI will take care of re-aggregation and handling
@@ -122,20 +125,23 @@ This must be done from a context that can sleep.
 PHY Management
 --------------
 
-The physical link (i2c, ...) management is defined by the following structure:
+The physical link (i2c, ...) management is defined by the following structure::
 
-struct nfc_phy_ops {
+  struct nfc_phy_ops {
 	int (*write)(void *dev_id, struct sk_buff *skb);
 	int (*enable)(void *dev_id);
 	void (*disable)(void *dev_id);
-};
+  };
 
-enable(): turn the phy on (power on), make it ready to transfer data
-disable(): turn the phy off
-write(): Send a data frame to the chip. Note that to enable higher
-layers such as an llc to store the frame for re-emission, this function must
-not alter the skb. It must also not return a positive result (return 0 for
-success, negative for failure).
+enable():
+	turn the phy on (power on), make it ready to transfer data
+disable():
+	turn the phy off
+write():
+	Send a data frame to the chip. Note that to enable higher
+	layers such as an llc to store the frame for re-emission, this
+	function must not alter the skb. It must also not return a positive
+	result (return 0 for success, negative for failure).
 
 Data coming from the chip shall be sent directly to nfc_hci_recv_frame().
 
@@ -145,9 +151,9 @@ LLC
 Communication between the CPU and the chip often requires some link layer
 protocol. Those are isolated as modules managed by the HCI layer. There are
 currently two modules : nop (raw transfert) and shdlc.
-A new llc must implement the following functions:
+A new llc must implement the following functions::
 
-struct nfc_llc_ops {
+  struct nfc_llc_ops {
 	void *(*init) (struct nfc_hci_dev *hdev, xmit_to_drv_t xmit_to_drv,
 		       rcv_to_hci_t rcv_to_hci, int tx_headroom,
 		       int tx_tailroom, int *rx_headroom, int *rx_tailroom,
@@ -157,17 +163,25 @@ struct nfc_llc_ops {
 	int (*stop) (struct nfc_llc *llc);
 	void (*rcv_from_drv) (struct nfc_llc *llc, struct sk_buff *skb);
 	int (*xmit_from_hci) (struct nfc_llc *llc, struct sk_buff *skb);
-};
+  };
 
-- init() : allocate and init your private storage
-- deinit() : cleanup
-- start() : establish the logical connection
-- stop () : terminate the logical connection
-- rcv_from_drv() : handle data coming from the chip, going to HCI
-- xmit_from_hci() : handle data sent by HCI, going to the chip
+init():
+	allocate and init your private storage
+deinit():
+	cleanup
+start():
+	establish the logical connection
+stop ():
+	terminate the logical connection
+rcv_from_drv():
+	handle data coming from the chip, going to HCI
+xmit_from_hci():
+	handle data sent by HCI, going to the chip
 
 The llc must be registered with nfc before it can be used. Do that by
-calling nfc_llc_register(const char *name, struct nfc_llc_ops *ops);
+calling::
+
+	nfc_llc_register(const char *name, struct nfc_llc_ops *ops);
 
 Again, note that the llc does not handle the physical link. It is thus very
 easy to mix any physical link with any llc for a given chip driver.
@@ -187,26 +201,32 @@ fast, cannot sleep. sends incoming frames to HCI where they are passed to
 the current llc. In case of shdlc, the frame is queued in shdlc rx queue.
 
 - SHDLC State Machine worker (SMW)
-Only when llc_shdlc is used: handles shdlc rx & tx queues.
-Dispatches HCI cmd responses.
+
+  Only when llc_shdlc is used: handles shdlc rx & tx queues.
+
+  Dispatches HCI cmd responses.
 
 - HCI Tx Cmd worker (MSGTXWQ)
-Serializes execution of HCI commands. Completes execution in case of response
-timeout.
+
+  Serializes execution of HCI commands.
+
+  Completes execution in case of response timeout.
 
 - HCI Rx worker (MSGRXWQ)
-Dispatches incoming HCI commands or events.
+
+  Dispatches incoming HCI commands or events.
 
 - Syscall context from a userspace call (SYSCALL)
-Any entrypoint in HCI called from NFC Core
+
+  Any entrypoint in HCI called from NFC Core
 
 Workflow executing an HCI command (using shdlc)
 -----------------------------------------------
 
 Executing an HCI command can easily be performed synchronously using the
-following API:
+following API::
 
-int nfc_hci_send_cmd (struct nfc_hci_dev *hdev, u8 gate, u8 cmd,
+  int nfc_hci_send_cmd (struct nfc_hci_dev *hdev, u8 gate, u8 cmd,
 			const u8 *param, size_t param_len, struct sk_buff **skb)
 
 The API must be invoked from a context that can sleep. Most of the time, this
@@ -234,11 +254,11 @@ waiting command execution. Response processing involves invoking the completion
 callback that was provided by nfc_hci_msg_tx_work() when it sent the command.
 The completion callback will then wake the syscall context.
 
-It is also possible to execute the command asynchronously using this API:
+It is also possible to execute the command asynchronously using this API::
 
-static int nfc_hci_execute_cmd_async(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
-			       const u8 *param, size_t param_len,
-			       data_exchange_cb_t cb, void *cb_context)
+  static int nfc_hci_execute_cmd_async(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
+				       const u8 *param, size_t param_len,
+				       data_exchange_cb_t cb, void *cb_context)
 
 The workflow is the same, except that the API call returns immediately, and
 the callback will be called with the result from the SMW context.
@@ -268,23 +288,24 @@ went wrong below and know that expected events will probably never happen.
 Handling of these errors is done as follows:
 
 - driver (pn544) fails to deliver an incoming frame: it stores the error such
-that any subsequent call to the driver will result in this error. Then it calls
-the standard nfc_shdlc_recv_frame() with a NULL argument to report the problem
-above. shdlc stores a EREMOTEIO sticky status, which will trigger SMW to
-report above in turn.
+  that any subsequent call to the driver will result in this error. Then it
+  calls the standard nfc_shdlc_recv_frame() with a NULL argument to report the
+  problem above. shdlc stores a EREMOTEIO sticky status, which will trigger
+  SMW to report above in turn.
 
 - SMW is basically a background thread to handle incoming and outgoing shdlc
-frames. This thread will also check the shdlc sticky status and report to HCI
-when it discovers it is not able to run anymore because of an unrecoverable
-error that happened within shdlc or below. If the problem occurs during shdlc
-connection, the error is reported through the connect completion.
+  frames. This thread will also check the shdlc sticky status and report to HCI
+  when it discovers it is not able to run anymore because of an unrecoverable
+  error that happened within shdlc or below. If the problem occurs during shdlc
+  connection, the error is reported through the connect completion.
 
 - HCI: if an internal HCI error happens (frame is lost), or HCI is reported an
-error from a lower layer, HCI will either complete the currently executing
-command with that error, or notify NFC Core directly if no command is executing.
+  error from a lower layer, HCI will either complete the currently executing
+  command with that error, or notify NFC Core directly if no command is
+  executing.
 
 - NFC Core: when NFC Core is notified of an error from below and polling is
-active, it will send a tag discovered event with an empty tag list to the user
-space to let it know that the poll operation will never be able to detect a tag.
-If polling is not active and the error was sticky, lower levels will return it
-at next invocation.
+  active, it will send a tag discovered event with an empty tag list to the user
+  space to let it know that the poll operation will never be able to detect a
+  tag. If polling is not active and the error was sticky, lower levels will
+  return it at next invocation.
diff --git a/Documentation/nfc/nfc-pn544.txt b/Documentation/nfc/nfc-pn544.rst
similarity index 82%
rename from Documentation/nfc/nfc-pn544.txt
rename to Documentation/nfc/nfc-pn544.rst
index b36ca14ca2d6..6b2d8aae0c4e 100644
--- a/Documentation/nfc/nfc-pn544.txt
+++ b/Documentation/nfc/nfc-pn544.rst
@@ -1,5 +1,7 @@
-Kernel driver for the NXP Semiconductors PN544 Near Field
-Communication chip
+============================================================================
+Kernel driver for the NXP Semiconductors PN544 Near Field Communication chip
+============================================================================
+
 
 General
 -------
-- 
2.21.0

