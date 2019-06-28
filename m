Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301852147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725183;
	bh=ALDnBP98IxBhJfnJsfO13GQviadZD0Gr12hCXgNImwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0GbRbQNZOHkejRyg+BtLXqbJjT8fYhzlnFd3/O1qjj0OrFiFhTbeAPdtakDw3Yjo
	 J0T3HE7OhXK5I2yJlXzRy2gxqxNVOGb9Mko4XX/o3kwiJhix1lAuk5Bv/GmB85WNVL
	 GD2cTOHvCG26jJSDAZbYfp+Uzprgvlwbnx/0fioM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfF1MdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:33:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfF1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b8lFdv2twqPqRr7SfjLTC0bbtFhcebH6eseqNOm/6hk=; b=D+tSXJchu7mkgCW5N/IdCIW18O
        CBwUVbGDLINtRCLu8ffcMDqF+l3uNHKJ1IMMUqwtESlzA3IYfA/Wmgo1yk5sSA6fFwDLwe9zoY4p/
        SFZltEf0uS9alkMeqn0lgNiymeeJhfGbqZTslMk9RZr73vghlLFZRDh+g5lRPo1ABSUcd0OUfFAKm
        cwdcnUWig4fj9ZLx7Y4CGrqPZoWd9G/7CRZ4jmTCJa8zT/ET/5TWfrLmZNBj3e0iYXiGeHiBy99HI
        w9fkFOhWVJi/ZGJOWpM9VzaPYJEI62JgE2Z1HXhADtDJvBJM+vbfbTGzb7pedNV3rIfd0DfiGsqjs
        vPaa4zcA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055Z-Jr; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Sv-JN; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 25/39] docs: add some documentation dirs to the driver-api book
Date:   Fri, 28 Jun 2019 09:30:18 -0300
Message-Id: <625e2df5006632e5c657749433e5aeee8cf211a9.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are subsystem docs, with a mix of kABI and user-faced
docs. While they're not split, keep the dirs where they are,
adding just a pointer to the main index.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/accounting/index.rst | 2 +-
 Documentation/block/index.rst      | 2 +-
 Documentation/hid/index.rst        | 2 +-
 Documentation/iio/index.rst        | 2 +-
 Documentation/index.rst            | 4 ++++
 5 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/accounting/index.rst b/Documentation/accounting/index.rst
index e1f6284b5ff3..9369d8bf32be 100644
--- a/Documentation/accounting/index.rst
+++ b/Documentation/accounting/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ==========
 Accounting
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 8cd226a0e86e..3fa7a52fafa4 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 =====
 Block
diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
index af4324902622..737d66dc16a1 100644
--- a/Documentation/hid/index.rst
+++ b/Documentation/hid/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 =============================
 Human Interface Devices (HID)
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 0593dca89a94..58b7a4ebac51 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ==============
 Industrial I/O
diff --git a/Documentation/index.rst b/Documentation/index.rst
index f898def833f4..879849b60c02 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -92,6 +92,10 @@ needed).
 
    driver-api/index
    core-api/index
+   accounting/index
+   block/index
+   hid/index
+   iio/index
    leds/index
    media/index
    networking/index
-- 
2.21.0

