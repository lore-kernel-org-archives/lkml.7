Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA56218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383497;
	bh=v7WRemAkY/D2930Otkdw4y9fekkLrgFvbljZHzsKNHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dQffOLOsG3SPcx8Ai4sZTjRn3QvMsxcxxsYfcu5MOIF8Qu27X7mKWHm9DYdWO4a7e
	 2yQbwvaP2jlxbExS0Q/z3qwX6meMaGx1MYLNmej8ivg0aejlrQW6IYhNHAmf5uor+z
	 iSKJIWBVD29zA8OgalUGu3tduSj95RLcveYux4EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDPC6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:58:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uNG/6AbseOadE0q5gA9abyFoSRBN1Q7/+wd/Vyc1BiY=; b=YF9QI0KGbe5DEkIaeqJIZFHUx1
        DV/g7qd4EuSZ6NO92XELY7KIBwrxbrpXcW0eRPkprni2NHxtP33lUww1q8n9UwEXApqqbgU3ZbswH
        U6gL6v+L+9JzEo6j9kmB/aD9S06Rf6huvlLQUPRYqXBsxd5wd3A7xJAm2IofggMn0sYmxvU6hbx1T
        m6E7g4d1/aH5bvStSXaxIlg0khcD/+CQWxXz9o63lkYFlz4d5rGSXBloEfScqtXrYG1f8pbeTos8E
        fzmrno4LdX8PorRjHXhg9AaXn6rAA5+3SlnFz2xOqv0UO//aTNt52fQnNSgxTJt5UHqvBQTwFu9OT
        zNcP6fdQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGv-0007ao-Nu; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001qG-EF; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 55/57] docs: nvmem: convert file to ReST format
Date:   Mon, 15 Apr 2019 23:56:20 -0300
Message-Id: <323f4aee82f8dfe2b2478d3f1cbf40cd945e0035.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to add it into a doc book, we need first
convert it to ReST.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/nvmem/nvmem.txt | 110 ++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index fc2fe4b18655..c93a9c6cd878 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -1,5 +1,8 @@
-			    NVMEM SUBSYSTEM
-	  Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+===============
+NVMEM Subsystem
+===============
+
+ Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 This document explains the NVMEM Framework along with the APIs provided,
 and how to use it.
@@ -40,54 +43,54 @@ nvmem_device pointer.
 
 nvmem_unregister(nvmem) is used to unregister a previously registered provider.
 
-For example, a simple qfprom case:
+For example, a simple qfprom case::
 
-static struct nvmem_config econfig = {
+  static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.owner = THIS_MODULE,
-};
+  };
 
-static int qfprom_probe(struct platform_device *pdev)
-{
+  static int qfprom_probe(struct platform_device *pdev)
+  {
 	...
 	econfig.dev = &pdev->dev;
 	nvmem = nvmem_register(&econfig);
 	...
-}
+  }
 
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
 Users of board files can define and register nvmem cells using the
-nvmem_cell_table struct:
+nvmem_cell_table struct::
 
-static struct nvmem_cell_info foo_nvmem_cells[] = {
+  static struct nvmem_cell_info foo_nvmem_cells[] = {
 	{
 		.name		= "macaddr",
 		.offset		= 0x7f00,
 		.bytes		= ETH_ALEN,
 	}
-};
+  };
 
-static struct nvmem_cell_table foo_nvmem_cell_table = {
+  static struct nvmem_cell_table foo_nvmem_cell_table = {
 	.nvmem_name		= "i2c-eeprom",
 	.cells			= foo_nvmem_cells,
 	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
-};
+  };
 
-nvmem_add_cell_table(&foo_nvmem_cell_table);
+  nvmem_add_cell_table(&foo_nvmem_cell_table);
 
 Additionally it is possible to create nvmem cell lookup entries and register
-them with the nvmem framework from machine code as shown in the example below:
+them with the nvmem framework from machine code as shown in the example below::
 
-static struct nvmem_cell_lookup foo_nvmem_lookup = {
+  static struct nvmem_cell_lookup foo_nvmem_lookup = {
 	.nvmem_name		= "i2c-eeprom",
 	.cell_name		= "macaddr",
 	.dev_id			= "foo_mac.0",
 	.con_id			= "mac-address",
-};
+  };
 
-nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
+  nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
 
 NVMEM Consumers
 +++++++++++++++
@@ -99,43 +102,43 @@ read from and to NVMEM.
 =================================
 
 NVMEM cells are the data entries/fields in the NVMEM.
-The NVMEM framework provides 3 APIs to read/write NVMEM cells.
+The NVMEM framework provides 3 APIs to read/write NVMEM cells::
 
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
-struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
+  struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
+  struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
 
-void nvmem_cell_put(struct nvmem_cell *cell);
-void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+  void nvmem_cell_put(struct nvmem_cell *cell);
+  void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 
-void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
-int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
+  void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
+  int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
 
-*nvmem_cell_get() apis will get a reference to nvmem cell for a given id,
+`*nvmem_cell_get()` apis will get a reference to nvmem cell for a given id,
 and nvmem_cell_read/write() can then read or write to the cell.
-Once the usage of the cell is finished the consumer should call *nvmem_cell_put()
-to free all the allocation memory for the cell.
+Once the usage of the cell is finished the consumer should call
+`*nvmem_cell_put()` to free all the allocation memory for the cell.
 
 4. Direct NVMEM device based consumer APIs
 ==========================================
 
 In some instances it is necessary to directly read/write the NVMEM.
-To facilitate such consumers NVMEM framework provides below apis.
+To facilitate such consumers NVMEM framework provides below apis::
 
-struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
-struct nvmem_device *devm_nvmem_device_get(struct device *dev,
+  struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
+  struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 					   const char *name);
-void nvmem_device_put(struct nvmem_device *nvmem);
-int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
+  void nvmem_device_put(struct nvmem_device *nvmem);
+  int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 		      size_t bytes, void *buf);
-int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
+  int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
-int nvmem_device_cell_read(struct nvmem_device *nvmem,
+  int nvmem_device_cell_read(struct nvmem_device *nvmem,
 			   struct nvmem_cell_info *info, void *buf);
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
+  int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
 Before the consumers can read/write NVMEM directly, it should get hold
-of nvmem_controller from one of the *nvmem_device_get() api.
+of nvmem_controller from one of the `*nvmem_device_get()` api.
 
 The difference between these apis and cell based apis is that these apis always
 take nvmem_device as parameter.
@@ -145,12 +148,12 @@ take nvmem_device as parameter.
 
 When a consumer no longer needs the NVMEM, it has to release the reference
 to the NVMEM it has obtained using the APIs mentioned in the above section.
-The NVMEM framework provides 2 APIs to release a reference to the NVMEM.
+The NVMEM framework provides 2 APIs to release a reference to the NVMEM::
 
-void nvmem_cell_put(struct nvmem_cell *cell);
-void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
-void nvmem_device_put(struct nvmem_device *nvmem);
-void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
+  void nvmem_cell_put(struct nvmem_cell *cell);
+  void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+  void nvmem_device_put(struct nvmem_device *nvmem);
+  void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
 
 Both these APIs are used to release a reference to the NVMEM and
 devm_nvmem_cell_put and devm_nvmem_device_put destroys the devres associated
@@ -162,20 +165,21 @@ Userspace
 6. Userspace binary interface
 ==============================
 
-Userspace can read/write the raw NVMEM file located at
-/sys/bus/nvmem/devices/*/nvmem
+Userspace can read/write the raw NVMEM file located at::
 
-ex:
+	/sys/bus/nvmem/devices/*/nvmem
 
-hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
+ex::
 
-0000000 0000 0000 0000 0000 0000 0000 0000 0000
-*
-00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
-0000000 0000 0000 0000 0000 0000 0000 0000 0000
-...
-*
-0001000
+  hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
+
+  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
+  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+  ...
+  *
+  0001000
 
 7. DeviceTree Binding
 =====================
-- 
2.20.1

