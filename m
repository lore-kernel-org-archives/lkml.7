Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE61921744
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364852;
	bh=AD5ebBYsv1KiOuyXo5qiHaLNstMoFSPMHbrV/ed0Fz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uB2k8PexJOJqm9B7xUoHa5KhUtbJCmIHg1rtSzE9ofoHS6ovGRtoWLL3aKSti3Avr
	 EbzpFK4YGZz6AE/KEsaCJJMjgYQaK/KjIXTR5ScklEcOzGQI3reTmx1t+VQTNLlW5O
	 DLBUNblnd67t11xbkI93WWgQ8l56wG45qx9AUXOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfFLSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfFLSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Z10GoepMy73tsXMyNGClo922cVQsKxK41VTPmgHbT4=; b=mFEnTnVqgGd7QSch+UuUVQqont
        P3uV4vd9F8Y51QeR0suYF9hl5ygUhammswpW8eHEQgLrI7dzq5qQ1Kux68eCv0rVZ5FemWYuHco8Z
        6MSeyFMHNAgH/Wp/bEZDFCsA0+mrNfEnHabhNw8qYodGyH5UlEvPulF4w15Sn0JsN1tVxheWcVJ13
        MbHL0YrZfOv7UXJWNARxmvzE2qYAeVnJYYfAYCTE4pHppb60zvFehJPokgJJINZKSgNAc0pIL8peY
        BlOn27ANvLXRc8zc5e8yIPrZ/ljydD2cmzt1aC2Ar+x3ZlapV7qaQMpVzRwTPBFWVCMRiyfIHFOLZ
        uaFmrMPQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YH-Jr; Wed, 12 Jun 2019 18:38:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002BT-9K; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 19/31] docs: fmc: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:22 -0300
Message-Id: <c560f879777b6d1edf525967716871dd614b7d17.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the FMC documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At least some of this files seemed to be using some markup
language similar to ReST, but with a different markup for
cross-references. Adjust those to use the ReST syntax.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/fmc/{API.txt => api.rst}        | 10 +--
 .../fmc/{carrier.txt => carrier.rst}          | 65 ++++++++++---------
 .../fmc/{FMC-and-SDB.txt => fmc-and-sdb.rst}  | 19 ++++--
 .../fmc/{fmc-chardev.txt => fmc-chardev.rst}  |  9 +--
 .../fmc/{fmc-fakedev.txt => fmc-fakedev.rst}  | 13 ++--
 .../fmc/{fmc-trivial.txt => fmc-trivial.rst}  | 11 ++--
 ...-write-eeprom.txt => fmc-write-eeprom.rst} | 36 +++++-----
 .../fmc/{identifiers.txt => identifiers.rst}  | 20 +++---
 Documentation/fmc/index.rst                   | 21 ++++++
 .../fmc/{mezzanine.txt => mezzanine.rst}      | 34 +++++-----
 .../fmc/{parameters.txt => parameters.rst}    | 11 ++--
 11 files changed, 147 insertions(+), 102 deletions(-)
 rename Documentation/fmc/{API.txt => api.rst} (87%)
 rename Documentation/fmc/{carrier.txt => carrier.rst} (91%)
 rename Documentation/fmc/{FMC-and-SDB.txt => fmc-and-sdb.rst} (88%)
 rename Documentation/fmc/{fmc-chardev.txt => fmc-chardev.rst} (96%)
 rename Documentation/fmc/{fmc-fakedev.txt => fmc-fakedev.rst} (85%)
 rename Documentation/fmc/{fmc-trivial.txt => fmc-trivial.rst} (69%)
 rename Documentation/fmc/{fmc-write-eeprom.txt => fmc-write-eeprom.rst} (79%)
 rename Documentation/fmc/{identifiers.txt => identifiers.rst} (93%)
 create mode 100644 Documentation/fmc/index.rst
 rename Documentation/fmc/{mezzanine.txt => mezzanine.rst} (87%)
 rename Documentation/fmc/{parameters.txt => parameters.rst} (96%)

diff --git a/Documentation/fmc/API.txt b/Documentation/fmc/api.rst
similarity index 87%
rename from Documentation/fmc/API.txt
rename to Documentation/fmc/api.rst
index 06b06b92c794..157a7343180c 100644
--- a/Documentation/fmc/API.txt
+++ b/Documentation/fmc/api.rst
@@ -2,7 +2,7 @@ Functions Exported by fmc.ko
 ****************************
 
 The FMC core exports the usual 4 functions that are needed for a bus to
-work, and a few more:
+work, and a few more::
 
         int fmc_driver_register(struct fmc_driver *drv);
         void fmc_driver_unregister(struct fmc_driver *drv);
@@ -20,9 +20,9 @@ work, and a few more:
         int fmc_reprogram(struct fmc_device *f, struct fmc_driver *d, char *gw,
                           int sdb_entry);
 
-The data structure that describe a device is detailed in *note FMC
-Device::, the one that describes a driver is detailed in *note FMC
-Driver::.  Please note that structures of type fmc_device must be
+The data structure that describe a device is detailed in :ref:`fmc_device`,
+the one that describes a driver is detailed in :ref:`fmc_driver`.
+Please note that structures of type fmc_device must be
 allocated by the caller, but must not be released after unregistering.
 The fmc-bus itself takes care of releasing the structure when their use
 count reaches zero - actually, the device model does that in lieu of us.
@@ -39,7 +39,7 @@ should register as a group only mezzanines that are driven by the same
 FPGA, for the reason outlined above.
 
 Finally, the fmc_reprogram function calls the reprogram method (see
-*note The API Offered by Carriers:: and also scans the memory area for
+:ref:`fmc_api_offered_by_carriers`) and also scans the memory area for
 an SDB tree. You can pass -1 as sdb_entry to disable such scan.
 Otherwise, the function fails if no tree is found at the specified
 entry point.  The function is meant to factorize common code, and by
diff --git a/Documentation/fmc/carrier.txt b/Documentation/fmc/carrier.rst
similarity index 91%
rename from Documentation/fmc/carrier.txt
rename to Documentation/fmc/carrier.rst
index 5e4f1dd3e98b..06ba443441e1 100644
--- a/Documentation/fmc/carrier.txt
+++ b/Documentation/fmc/carrier.rst
@@ -1,5 +1,8 @@
+.. _fmc_device:
+
+==========
 FMC Device
-**********
+==========
 
 Within the Linux bus framework, the FMC device is created and
 registered by the carrier driver. For example, the PCI driver for the
@@ -25,7 +28,7 @@ change for compatible changes (like a new flag) and the major number
 will increase when an incompatible change happens (for example, a
 change in layout of some fmc data structures).  Device writers should
 just set it to the value FMC_VERSION, and be ready to get back -EINVAL
-at registration time.
+at registration time::
 
      struct fmc_device {
              unsigned long version;
@@ -123,13 +126,15 @@ As I write this, she SPEC carrier is already completely functional in
 the fmc-bus environment, and is a good reference to look at.
 
 
+.. _fmc_api_offered_by_carriers:
+
 The API Offered by Carriers
 ===========================
 
 The carrier provides a number of methods by means of the
-`fmc_operations' structure, which currently is defined like this
+`fmc_operations` structure, which currently is defined like this
 (again, it is a moving target, please refer to the header rather than
-this document):
+this document)::
 
      struct fmc_operations {
              uint32_t (*readl)(struct fmc_device *fmc, int offset);
@@ -148,8 +153,7 @@ this document):
 
 The individual methods perform the following tasks:
 
-`readl'
-`writel'
+`readl`, `writel`
      These functions access FPGA registers by whatever means the
      carrier offers. They are not expected to fail, and most of the time
      they will just make a memory access to the host bus. If the
@@ -161,20 +165,20 @@ The individual methods perform the following tasks:
      or other non-local carriers, error-management is still to be
      defined.
 
-`validate'
+`validate`
      Module parameters are used to manage different applications for
      two or more boards of the same kind. Validation is based on the
      busid module parameter, if provided, and returns the matching
-     index in the associated array. See *note Module Parameters:: in in
-     doubt. If no match is found, `-ENOENT' is returned; if the user
-     didn't pass `busid=', all devices will pass validation.  The value
+     index in the associated array. See :ref:`fmc_module_parameters` in in
+     doubt. If no match is found, `-ENOENT` is returned; if the user
+     didn't pass `busid=`, all devices will pass validation.  The value
      returned by the validate method can be used as index into other
-     parameters (for example, some drivers use the `lm32=' parameter in
-     this way). Such "generic parameters" are documented in *note
-     Module Parameters::, below. The validate method is used by
-     `fmc-trivial.ko', described in *note fmc-trivial::.
+     parameters (for example, some drivers use the `lm32=` parameter in
+     this way). Such "generic parameters" are documented in
+     :ref:`fmc_module_parameters` below. The validate method is used by
+     `fmc-trivial.ko`, described in :ref:`fmc_trivial`.
 
-`reprogram'
+`reprogram`
      The carrier enumerates FMC devices by loading a standard (or
      golden) FPGA binary that allows EEPROM access. Each driver, then,
      will need to reprogram the FPGA by calling this function.  If the
@@ -182,31 +186,28 @@ The individual methods perform the following tasks:
      binary. If the gateware name has been overridden through module
      parameters (in a carrier-specific way) the file loaded will match
      the parameters. Per-device gateware names can be specified using
-     the `gateware=' parameter, see *note Module Parameters::.  Note:
+     the `gateware=` parameter, see :ref:`fmc_module_parameters`.  Note:
      Clients should call rhe new helper, fmc_reprogram, which both
      calls this method and parse the SDB tree of the FPGA.
 
-`irq_request'
-`irq_ack'
-`irq_free'
+`irq_request`, `irq_ack`, `irq_free`
      Interrupt management is carrier-specific, so it is abstracted as
      operations. The interrupt number is listed in the device
      structure, and for the mezzanine driver the number is only
      informative.  The handler will receive the fmc pointer as dev_id;
      the flags argument is passed to the Linux request_irq function,
      but fmc-specific flags may be added in the future. You'll most
-     likely want to pass the `IRQF_SHARED' flag.
+     likely want to pass the `IRQF_SHARED` flag.
 
-`gpio_config'
+`gpio_config`
      The method allows to configure a GPIO pin in the carrier, and read
-     its current value if it is configured as input. See *note The GPIO
-     Abstraction:: for details.
+     its current value if it is configured as input. See
+     :ref:`fmc_gpio_abstraction` for details.
 
-`read_ee'
-`write_ee'
+`read_ee`, `write_ee`
      Read or write the EEPROM. The functions are expected to be only
      called before reprogramming and the carrier should refuse them
-     with `ENODEV' after reprogramming.  The offset is expected to be
+     with `ENODEV` after reprogramming.  The offset is expected to be
      within 8kB (the current size), but addresses up to 1MB are
      reserved to fit bigger I2C devices in the future. Carriers may
      offer access to other internal flash memories using these same
@@ -214,9 +215,9 @@ The individual methods perform the following tasks:
      I2C memory is seen at offset 1M and the internal SPI flash is seen
      at offset 16M.  This multiplexing of several flash memories in the
      same address space is carrier-specific and should only be used
-     by a driver that has verified the `carrier_name' field.
-
+     by a driver that has verified the `carrier_name` field.
 
+.. _fmc_gpio_abstraction:
 
 The GPIO Abstraction
 ====================
@@ -230,7 +231,7 @@ some knowledge of the carrier itself.  For this reason, the specific
 driver can request to configure carrier-specific GPIO pins, numbered
 from 0 to at most 4095.  Configuration is performed by passing a
 pointer to an array of struct fmc_gpio items, as well as the length of
-the array. This is the data structure:
+the array. This is the data structure::
 
         struct fmc_gpio {
                 char *carrier_name;
@@ -254,7 +255,7 @@ pins, and expect one such configuration to succeed - if none succeeds
 it most likely means that the current carrier is a still-unknown one.
 
 If, however, your GPIO pin has a specific known role, you can pass a
-special number in the gpio field, using one of the following macros:
+special number in the gpio field, using one of the following macros::
 
         #define FMC_GPIO_RAW(x)         (x)             /* 4096 of them */
         #define FMC_GPIO_IRQ(x)         ((x) + 0x1000)  /*  256 of them */
@@ -293,9 +294,9 @@ carriers.
 
 The return value of gpio_config is defined as follows:
 
-   * If no pin in the array can be used by the carrier, `-ENODEV'.
+   * If no pin in the array can be used by the carrier, `-ENODEV`.
 
-   * If at least one virtual GPIO number cannot be mapped, `-ENOENT'.
+   * If at least one virtual GPIO number cannot be mapped, `-ENOENT`.
 
    * On success, 0 or positive. The value returned is the number of
      high input bits (if no input is configured, the value for success
diff --git a/Documentation/fmc/FMC-and-SDB.txt b/Documentation/fmc/fmc-and-sdb.rst
similarity index 88%
rename from Documentation/fmc/FMC-and-SDB.txt
rename to Documentation/fmc/fmc-and-sdb.rst
index fa14e0b24521..e64c6104a241 100644
--- a/Documentation/fmc/FMC-and-SDB.txt
+++ b/Documentation/fmc/fmc-and-sdb.rst
@@ -1,3 +1,6 @@
+============
+Introduction
+============
 
 FMC (FPGA Mezzanine Card) is the standard we use for our I/O devices,
 in the context of White Rabbit and related hardware.
@@ -18,12 +21,12 @@ submodule.
 The most up to date version of code and documentation is always
 available from the repository you can clone from:
 
-        git://ohwr.org/fmc-projects/fmc-bus.git (read-only)
-        git@ohwr.org:fmc-projects/fmc-bus.git (read-write for developers)
+        - git://ohwr.org/fmc-projects/fmc-bus.git (read-only)
+        - git@ohwr.org:fmc-projects/fmc-bus.git (read-write for developers)
 
 Selected versions of the documentation, as well as complete tar
 archives for selected revisions are placed to the Files section of the
-project: `http://www.ohwr.org/projects/fmc-bus/files'
+project: `http://www.ohwr.org/projects/fmc-bus/files`
 
 
 What is FMC
@@ -62,13 +65,15 @@ a filesystem inside the FMC EEPROM.
 SDB is not mandatory for use of this FMC kernel bus, but if you have SDB
 this package can make good use of it.  SDB itself is developed in the
 fpga-config-space OHWR project. The link to the repository is
-`git://ohwr.org/hdl-core-lib/fpga-config-space.git' and what is used in
+`git://ohwr.org/hdl-core-lib/fpga-config-space.git` and what is used in
 this project lives in the sdbfs subdirectory in there.
 
-SDB support for FMC is described in *note FMC Identification:: and
-*note SDB Support::
+SDB support for FMC is described in :ref:`fmc_identification` and
+:ref:`fmc_sdb_support`.
 
 
+.. _fmc_sdb_support:
+
 SDB Support
 ***********
 
@@ -79,7 +84,7 @@ memory image.
 The module exports the following functions, in the special header
 <linux/fmc-sdb.h>. The linux/ prefix in the name is there because we
 plan to submit it upstream in the future, and don't want to force
-changes on our drivers if that happens.
+changes on our drivers if that happens::
 
          int fmc_scan_sdb_tree(struct fmc_device *fmc, unsigned long address);
          void fmc_show_sdb_tree(struct fmc_device *fmc);
diff --git a/Documentation/fmc/fmc-chardev.txt b/Documentation/fmc/fmc-chardev.rst
similarity index 96%
rename from Documentation/fmc/fmc-chardev.txt
rename to Documentation/fmc/fmc-chardev.rst
index d9ccb278e597..5aa77511e4d1 100644
--- a/Documentation/fmc/fmc-chardev.txt
+++ b/Documentation/fmc/fmc-chardev.rst
@@ -1,5 +1,6 @@
-fmc-chardev
-===========
+================
+Character device
+================
 
 This is a simple generic driver, that allows user access by means of a
 character device (actually, one for each mezzanine it takes hold of).
@@ -27,7 +28,7 @@ arises.
 The example below shows raw access to a SPEC card programmed with its
 golden FPGA file, that features an SDB structure at offset 256 - i.e.
 64 words.  The mezzanine's EEPROM in this case is not programmed, so the
-default name is fmc-<bus><devfn>, and there are two cards in the system:
+default name is fmc-<bus><devfn>, and there are two cards in the system::
 
   spusa.root# insmod fmc-chardev.ko
   [ 1073.339332] spec 0000:02:00.0: Driver has no ID: matches all
@@ -52,7 +53,7 @@ repeated reading data is written to stdout; repeated writes read from
 stdin and the value argument is ignored.
 
 The following examples show reading the SDB magic number and the first
-SDB record from a SPEC device programmed with its golden image:
+SDB record from a SPEC device programmed with its golden image::
 
      spusa.root# ./fmc-mem /dev/fmc-0200 100
      5344422d
diff --git a/Documentation/fmc/fmc-fakedev.txt b/Documentation/fmc/fmc-fakedev.rst
similarity index 85%
rename from Documentation/fmc/fmc-fakedev.txt
rename to Documentation/fmc/fmc-fakedev.rst
index e85b74a4ae30..e9300e839eef 100644
--- a/Documentation/fmc/fmc-fakedev.txt
+++ b/Documentation/fmc/fmc-fakedev.rst
@@ -1,7 +1,10 @@
-fmc-fakedev
-===========
+.. _fmc_fakedev:
 
-This package includes a software-only device, called fmc-fakedev, which
+=========================
+Software-only Fake Device
+=========================
+
+This package includes a software-only device, called **fmc-fakedev**, which
 is able to register up to 4 mezzanines (by default it registers one).
 Unlike the SPEC driver, which creates an FMC device for each PCI cards
 it manages, this module creates a single instance of its set of
@@ -9,14 +12,14 @@ mezzanines.
 
 It is meant as the simplest possible example of how a driver should be
 written, and it includes a fake EEPROM image (built using the tools
-described in *note FMC Identification::),, which by default is
+described in :ref:`fmc_identification` which by default is
 replicated for each fake mezzanine.
 
 You can also use this device to verify the match algorithms, by asking
 it to test your own EEPROM image. You can provide the image by means of
 the eeprom= module parameter: the new EEPROM image is loaded, as usual,
 by means of the firmware loader.  This example shows the defaults and a
-custom EEPROM image:
+custom EEPROM image::
 
      spusa.root# insmod fmc-fakedev.ko
      [   99.971247]  fake-fmc-carrier: mezzanine 0
diff --git a/Documentation/fmc/fmc-trivial.txt b/Documentation/fmc/fmc-trivial.rst
similarity index 69%
rename from Documentation/fmc/fmc-trivial.txt
rename to Documentation/fmc/fmc-trivial.rst
index d1910bc67159..c98324f955ea 100644
--- a/Documentation/fmc/fmc-trivial.txt
+++ b/Documentation/fmc/fmc-trivial.rst
@@ -1,7 +1,9 @@
-fmc-trivial
-===========
+.. _fmc_trivial:
 
-The simple module fmc-trivial is just a simple client that registers an
+FMC trivial driver
+==================
+
+The simple module **fmc-trivial** is just a simple client that registers an
 interrupt handler. I used it to verify the basic mechanism of the FMC
 bus and how interrupts worked.
 
@@ -9,8 +11,7 @@ The module implements the generic FMC parameters, so it can program a
 different gateware file in each card. The whole list of parameters it
 accepts are:
 
-`busid='
-`gateware='
+`busid=`, `gateware=`
      Generic parameters. See mezzanine.txt
 
 
diff --git a/Documentation/fmc/fmc-write-eeprom.txt b/Documentation/fmc/fmc-write-eeprom.rst
similarity index 79%
rename from Documentation/fmc/fmc-write-eeprom.txt
rename to Documentation/fmc/fmc-write-eeprom.rst
index e0a9712156aa..45311bcc804a 100644
--- a/Documentation/fmc/fmc-write-eeprom.txt
+++ b/Documentation/fmc/fmc-write-eeprom.rst
@@ -1,9 +1,12 @@
-fmc-write-eeprom
+.. _fmc_write_eeprom:
+
+================
+FMC write eeprom
 ================
 
-This module is designed to load a binary file from /lib/firmware and to
-write it to the internal EEPROM of the mezzanine card. This driver uses
-the `busid' generic parameter.
+The module **fmc-write-eeprom** is designed to load a binary file from
+/lib/firmware and to write it to the internal EEPROM of the mezzanine card.
+This driver uses the `busid` generic parameter.
 
 Overwriting the EEPROM is not something you should do daily, and it is
 expected to only happen during manufacturing. For this reason, the
@@ -11,36 +14,36 @@ module makes it unlikely for the random user to change a working EEPROM.
 
 However, since the EEPROM may include application-specific information
 other than the identification, later versions of this packages added
-write-support through sysfs. See *note Accessing the EEPROM::.
+write-support through sysfs. See :ref:`fmc_accessing_eeprom`.
 
 To avoid damaging the EEPROM content, the module takes the following
 measures:
 
-   * It accepts a `file=' argument (within /lib/firmware) and if no
+   * It accepts a `file=` argument (within /lib/firmware) and if no
      such argument is received, it doesn't write anything to EEPROM
      (i.e. there is no default file name).
 
-   * If the file name ends with `.bin' it is written verbatim starting
+   * If the file name ends with `.bin` it is written verbatim starting
      at offset 0.
 
-   * If the file name ends with `.tlv' it is interpreted as
+   * If the file name ends with `.tlv` it is interpreted as
      type-length-value (i.e., it allows writev(2)-like operation).
 
    * If the file name doesn't match any of the patterns above, it is
      ignored and no write is performed.
 
-   * Only cards listed with `busid=' are written to. If no busid is
+   * Only cards listed with `busid=` are written to. If no busid is
      specified, no programming is done (and the probe function of the
      driver will fail).
 
 
 Each TLV tuple is formatted in this way: the header is 5 bytes,
-followed by data. The first byte is `w' for write, the next two bytes
+followed by data. The first byte is `w` for write, the next two bytes
 represent the address, in little-endian byte order, and the next two
 represent the data length, in little-endian order. The length does not
 include the header (it is the actual number of bytes to be written).
 
-This is a real example: that writes 5 bytes at position 0x110:
+This is a real example: that writes 5 bytes at position 0x110::
 
         spusa.root# od -t x1 -Ax /lib/firmware/try.tlv
         000000 77 10 01 05 00 30 31 32 33 34
@@ -55,13 +58,13 @@ Rabbit environment. For this reason the TLV format is not expected to
 be used much and is not expected to be developed further.
 
 If you want to try reflashing fake EEPROM devices, you can use the
-fmc-fakedev.ko module (see *note fmc-fakedev::).  Whenever you change
+fmc-fakedev.ko module (see :ref:`fmc_fakedev`).  Whenever you change
 the image starting at offset 0, it will deregister and register again
 after two seconds.  Please note, however, that if fmc-write-eeprom is
 still loaded, the system will associate it to the new device, which
 will be reprogrammed and thus will be unloaded after two seconds.  The
 following example removes the module after it reflashed fakedev the
-first time.
+first time::
 
      spusa.root# insmod fmc-fakedev.ko
         [   72.984733]  fake-fmc: Manufacturer: fake-vendor
@@ -74,12 +77,13 @@ first time.
         [  132.895794]  fake-fmc: Manufacturer: CERN
         [  132.899872]  fake-fmc: Product name: FmcDelay1ns4cha
 
+.. _fmc_accessing_eeprom:
 
 Accessing the EEPROM
-=====================
+====================
 
 The bus creates a sysfs binary file called eeprom for each mezzanine it
-knows about:
+knows about::
 
         spusa.root# cd /sys/bus/fmc/devices; ls -l */eeprom
         -r--r--r-- 1 root root 8192 Feb 21 12:30 FmcAdc100m14b4cha-0800/eeprom
@@ -94,5 +98,5 @@ the FPGA with a custom circuit, the carrier is unable to access the
 EEPROM and returns ENOTSUPP.
 
 An alternative way to write the EEPROM is the mezzanine driver
-fmc-write-eeprom (See *note fmc-write-eeprom::), but the procedure is
+fmc-write-eeprom (See :ref:`fmc_write_eeprom`), but the procedure is
 more complex.
diff --git a/Documentation/fmc/identifiers.txt b/Documentation/fmc/identifiers.rst
similarity index 93%
rename from Documentation/fmc/identifiers.txt
rename to Documentation/fmc/identifiers.rst
index 3bb577ff0d52..01e6dde0996f 100644
--- a/Documentation/fmc/identifiers.txt
+++ b/Documentation/fmc/identifiers.rst
@@ -1,3 +1,5 @@
+.. _fmc_identification:
+
 FMC Identification
 ******************
 
@@ -19,7 +21,7 @@ package and SDB (part of the fpga-config-space package).
 
 The first sections are only interesting for manufacturers who need to
 write the EEPROM. If you are just a software developer writing an FMC
-device or driver, you may jump straight to *note SDB Support::.
+device or driver, you may jump straight to :ref:`fmc_sdb_support`.
 
 
 Building the FRU Structure
@@ -27,7 +29,7 @@ Building the FRU Structure
 
 If you want to know the internals of the FRU structure and despair, you
 can retrieve the document from
-`http://download.intel.com/design/servers/ipmi/FRU1011.pdf' .  The
+`http://download.intel.com/design/servers/ipmi/FRU1011.pdf` .  The
 standard is awful and difficult without reason, so we only support the
 minimum mandatory subset - we create a simple structure and parse it
 back at run time, but we are not able to either generate or parse more
@@ -43,13 +45,15 @@ line takes precedence)
 To make a long story short, in order to build a standard-compliant
 binary file to be burned in your EEPROM, you need the following items:
 
+	===========    ===     =====================  ============
         Environment    Opt     Official Name          Default
----------------------------------------------------------------------
+	===========    ===     =====================  ============
         FRU_VENDOR     -v      "Board Manufacturer"   fmc-example
         FRU_NAME       -n      "Board Product Name"   mezzanine
-        FRU_SERIAL     -s      `Board Serial Number"  0001
+        FRU_SERIAL     -s      "Board Serial Number"  0001
         FRU_PART       -p      "Board Part Number"    sample-part
         FRU_OUTPUT     -o      not applicable         /dev/stdout
+	===========    ===     =====================  ============
 
 The "Official Name" above is what you find in the FRU official
 documentation, chapter 11, page 7 ("Board Info Area Format").  The
@@ -63,7 +67,7 @@ soon as I find some time for that.
 
 FIXME: consumption etc for FRU are here or in PTS?
 
-The following example creates a binary image for a specific board:
+The following example creates a binary image for a specific board::
 
         ./tools/fru-generator -v CERN -n FmcAdc100m14b4cha \
                -s HCCFFIA___-CR000003 -p EDA-02063-V5-0 > eeprom.bin
@@ -71,7 +75,7 @@ The following example creates a binary image for a specific board:
 The following example shows a script that builds several binary EEPROM
 images for a series of boards, changing the serial number for each of
 them. The script uses a mix of environment variables and command line
-options, and uses the same string patterns shown above.
+options, and uses the same string patterns shown above::
 
         #!/bin/sh
 
@@ -131,7 +135,7 @@ name. The IPMI-FRU name is not mandatory, but a strongly suggested
 choice; the name filename is mandatory, because this is the preferred
 short name used by the FMC core.  For example, a name of "fdelay" may
 supplement a Product Name like "FmcDelay1ns4cha" - exactly as
-demonstrated in `tools/sdbfs'.
+demonstrated in `tools/sdbfs`.
 
 Note: SDB access to flash memory is not yet supported, so the short
 name currently in use is just the "Product Name" FRU string.
@@ -139,7 +143,7 @@ name currently in use is just the "Product Name" FRU string.
 The example in tools/sdbfs includes an extra file, that is needed by
 the fine-delay driver, and must live at a known address of 0x1800.  By
 running gensdbfs on that directory you can output your binary EEPROM
-image (here below spusa$ is the shell prompt):
+image (here below spusa$ is the shell prompt)::
 
         spusa$ ../fru-generator -v CERN -n FmcDelay1ns4cha -s proto-0 \
                       -p EDA-02267-V3 > IPMI-FRU
diff --git a/Documentation/fmc/index.rst b/Documentation/fmc/index.rst
new file mode 100644
index 000000000000..a749cb04f39e
--- /dev/null
+++ b/Documentation/fmc/index.rst
@@ -0,0 +1,21 @@
+:orphan:
+
+=========================
+FMC (FPGA Mezzanine Card)
+=========================
+
+.. toctree::
+   :maxdepth: 1
+
+   fmc-and-sdb
+   carrier
+   identifiers
+   mezzanine
+   parameters
+
+   api
+
+   fmc-fakedev
+   fmc-trivial
+   fmc-write-eeprom
+   fmc-chardev
diff --git a/Documentation/fmc/mezzanine.txt b/Documentation/fmc/mezzanine.rst
similarity index 87%
rename from Documentation/fmc/mezzanine.txt
rename to Documentation/fmc/mezzanine.rst
index 87910dbfc91e..9a37147e8f14 100644
--- a/Documentation/fmc/mezzanine.txt
+++ b/Documentation/fmc/mezzanine.rst
@@ -1,5 +1,8 @@
+.. _fmc_driver:
+
+==========
 FMC Driver
-**********
+==========
 
 An FMC driver is concerned with the specific mezzanine and associated
 gateware. As such, it is expected to be independent of the carrier
@@ -12,23 +15,23 @@ configured in the FPGA; the latter technique is used when the FPGA is
 already programmed when the device is registered to the bus core.
 
 In some special cases it is possible for a driver to directly access
-FPGA registers, by means of the `fpga_base' field of the device
+FPGA registers, by means of the `fpga_base` field of the device
 structure. This may be needed for high-bandwidth peripherals like fast
 ADC cards. If the device module registered a remote device (for example
-by means of Etherbone), the `fpga_base' pointer will be NULL.
+by means of Etherbone), the `fpga_base` pointer will be NULL.
 Therefore, drivers must be ready to deal with NULL base pointers, and
 fail gracefully.  Most driver, however, are not expected to access the
 pointer directly but run fmc_readl and fmc_writel instead, which will
 work in any case.
 
 In even more special cases, the driver may access carrier-specific
-functionality: the `carrier_name' string allows the driver to check
-which is the current carrier and make use of the `carrier_data'
+functionality: the `carrier_name` string allows the driver to check
+which is the current carrier and make use of the `carrier_data`
 pointer.  We chose to use carrier names rather than numeric identifiers
 for greater flexibility, but also to avoid a central registry within
-the `fmc.h' file - we hope other users will exploit our framework with
+the `fmc.h` file - we hope other users will exploit our framework with
 their own carriers.  An example use of carrier names is in GPIO setup
-(see *note The GPIO Abstraction::), although the name match is not
+(see :ref:`fmc_gpio_abstraction`), although the name match is not
 expected to be performed by the driver.  If you depend on specific
 carriers, please check the carrier name and fail gracefully if your
 driver finds it is running in a yet-unknown-to-it environment.
@@ -44,7 +47,7 @@ their EEPROM or on the actual FPGA cores that can be enumerated.
 Therefore, we have two tables of identifiers.
 
 Matching of FRU information depends on two names, the manufacturer (or
-vendor) and the device (see *note FMC Identification::); for
+vendor) and the device (see :ref:`fmc_identification`); for
 flexibility during production (i.e. before writing to the EEPROM) the
 bus supports a catch-all driver that specifies NULL strings. For this
 reason, the table is specified as pointer-and-length, not a a
@@ -58,7 +61,7 @@ instantiated), and for consistency the list is passed as
 pointer-and-length.  Several similar devices can be driven by the same
 driver, and thus the driver specifies and array of such arrays.
 
-The complete set of involved data structures is thus the following:
+The complete set of involved data structures is thus the following::
 
         struct fmc_fru_id { char *manufacturer; char *product_name; };
         struct fmc_sdb_one_id { uint64_t vendor; uint32_t device; };
@@ -71,13 +74,14 @@ The complete set of involved data structures is thus the following:
 
 A better reference, with full explanation, is the <linux/fmc.h> header.
 
+.. _fmc_module_parameters:
 
 Module Parameters
 =================
 
 Most of the FMC drivers need the same set of kernel parameters. This
 package includes support to implement common parameters by means of
-fields in the `fmc_driver' structure and simple macro definitions.
+fields in the `fmc_driver` structure and simple macro definitions.
 
 The parameters are carrier-specific, in that they rely on the busid
 concept, that varies among carriers. For the SPEC, the identifier is a
@@ -88,20 +92,20 @@ and some code duplication is unavoidable.
 This is the list of parameters that are common to several modules to
 see how they are actually used, please look at spec-trivial.c.
 
-`busid='
+`busid=`
      This is an array of integers, listing carrier-specific
-     identification numbers. For PIC, for example, `0x0400' represents
+     identification numbers. For PIC, for example, `0x0400` represents
      bus 4, slot 0.  If any such ID is specified, the driver will only
      accept to drive cards that appear in the list (even if the FMC ID
      matches). This is accomplished by the validate carrier method.
 
-`gateware='
+`gateware=`
      The argument is an array of strings. If no busid= is specified,
      the first string of gateware= is used for all cards; otherwise the
      identifiers and gateware names are paired one by one, in the order
      specified.
 
-`show_sdb='
+`show_sdb=`
      For modules supporting it, this parameter asks to show the SDB
      internal structure by means of kernel messages. It is disabled by
      default because those lines tend to hide more important messages,
@@ -113,7 +117,7 @@ see how they are actually used, please look at spec-trivial.c.
 For example, if you are using the trivial driver to load two different
 gateware files to two different cards, you can use the following
 parameters to load different binaries to the cards, after looking up
-the PCI identifiers. This has been tested with a SPEC carrier.
+the PCI identifiers. This has been tested with a SPEC carrier::
 
         insmod fmc-trivial.ko \
                               busid=0x0200,0x0400 \
diff --git a/Documentation/fmc/parameters.txt b/Documentation/fmc/parameters.rst
similarity index 96%
rename from Documentation/fmc/parameters.txt
rename to Documentation/fmc/parameters.rst
index 59edf088e3a4..bf4566967e9c 100644
--- a/Documentation/fmc/parameters.txt
+++ b/Documentation/fmc/parameters.rst
@@ -1,16 +1,17 @@
+===========================
 Module Parameters in fmc.ko
-***************************
+===========================
 
 The core driver receives two module parameters, meant to help debugging
 client modules. Both parameters can be modified by writing to
 /sys/module/fmc/parameters/, because they are used when client drivers
 are devices are registered, not when fmc.ko is loaded.
 
-`dump_eeprom='
+`dump_eeprom=`
      If not zero, the parameter asks the bus controller to dump the
      EEPROM of any device that is registered, using printk.
 
-`dump_sdb='
+`dump_sdb=`
      If not zero, the parameter prints the SDB tree of every FPGA it is
      loaded by fmc_reprogram(). If greater than one, it asks to dump
      the binary content of SDB records.  This currently only dumps the
@@ -19,7 +20,7 @@ are devices are registered, not when fmc.ko is loaded.
 
 EEPROM dumping avoids repeating lines, since most of the contents is
 usually empty and all bits are one or zero. This is an example of the
-output:
+output::
 
         [ 6625.850480] spec 0000:02:00.0: FPGA programming successful
         [ 6626.139949] spec 0000:02:00.0: Manufacturer: CERN
@@ -40,7 +41,7 @@ output:
 
 The dump of SDB looks like the following; the example shows the simple
 golden gateware for the SPEC card, removing the leading timestamps to
-fit the page:
+fit the page::
 
         spec 0000:02:00.0: SDB: 00000651:e6a542c9 WB4-Crossbar-GSI
         spec 0000:02:00.0: SDB: 0000ce42:ff07fc47 WR-Periph-Syscon (00000000-000000ff)
-- 
2.21.0

