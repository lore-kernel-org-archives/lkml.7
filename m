Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F0C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D03A222AE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894762;
	bh=0JtYFDlearb1QbuxZjO8E6Z3Z2YIuT1U/GtJxiSwDcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWH0pmu7zW3pRDn4E1AfsOPVD25iEae/WPiGF1hjM4N3eK2Nd/vajQ0685T7Esl13
	 3GvKuJL6xcpG4uqQjlIpPq2Uz4rySXwzjy1kkkHydi/zbUnZw7IO2FRtOHXoQXUr/j
	 RwtuxnKOAxTMm9YVCj3f/HvKL3O4R59scEk/s/Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfDJLMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:12:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731333AbfDJLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nRq6YtK5jyH6dE66GFmlrw/cDyRkOI2cjXNvGCeq9PA=; b=IIstzdmuFisXCEbMWGXfT3H9Kt
        WUOFHOObcnSWmzAp7Vx3nqIaZOaj2s9NAtwAZW+R7yic44qwroyawSvHe5uGV7oS+pU9h+JvN2u9R
        4z5WCeOU9e8rYy+Up6yTWthYh2wPpAhrS9LrY6emDDCqf7MJVuKzxJbKt2WHJunoWncR5IzN4rXon
        quklFXQWczgLxdDlJpeEKS9C4OVQSFpx3ioiVZiQdIYivZRlvcMgV0aw2WcJg4sriBIchQeorcUOh
        fL9Mw264Mw3Qm96fIKO6KjufEnY6zKRL12yq3bpXY+kYsFT3JWU6ZEhdWCGh4xRcpnUJlIGCEMcRb
        kKpa+Ovg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006n3-NA; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007T1-Fr; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/21] docs: hwmon: ibmpowernv: convert to ReST format
Date:   Wed, 10 Apr 2019 08:12:01 -0300
Message-Id: <c3adf43d67974eff0781e72412af08768d7fd353.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ibmpowernv to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/ibmpowernv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 56468258711f..3f1feae3901c 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -2,6 +2,7 @@ Kernel Driver IBMPOWERNV
 ========================
 
 Supported systems:
+
   * Any recent IBM P servers based on POWERNV platform
 
 Author: Neelesh Gupta
@@ -29,6 +30,7 @@ CONFIG_SENSORS_IBMPOWERNV. It can also be built as module 'ibmpowernv'.
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 fanX_input		Measured RPM value.
 fanX_min		Threshold RPM for alert generation.
 fanX_fault		0: No fail condition
@@ -78,3 +80,4 @@ currX_enable		Enable/disable all current sensors belonging to the
 			0: Disable
 
 energyX_input		Cumulative energy (microJoule)
+======================= =======================================================
-- 
2.20.1

