Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF63C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4049C214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555954785;
	bh=JsyK2c/s29Dh5bJuF5U9f5Dr2N1ScMtFWe3zTrD1i/0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HAoLWykmN5pVyFVAKBBfkwDne/dEQu66yT3uxuvJJr2TioG8nAusJJbjxGm1gTn7V
	 ZzznQiXF/jIyNZBSyxvq72Rgxep2AXpTW+ixqEsC7TSRvFJhkIwWsETEbggfc2rOZQ
	 InpsiN/YTwcf3bus+glH5UNt8giGaF59def82FtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfDVRjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:39:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yhlRNyjUqRk9rCHrDlI8HQIYmKPBj5M2+grg1BxW/8Y=; b=CCzflAM/nhpC9UfabD8W6x0ER
        s0/YNBbWONVnWRC3ofcVEj3tdKMMrJK0rdjzaqxVjMhEyOGrWkgXHQ9bmli327f6wz0ztbQBdFZsw
        qHS8Cb++3GbMku3PHUhSUywtGQT/b8JltqNRl+fOtxP6/Xq22sK0A5VlD7gR3wD2DQAU3xnWE7GR/
        plMBlOrHMj4d0QHmRfKZL2jyCSfdpabAdzdfRRRyeC2UXWOvgdERkgCH+uu8p8hNgY5xA6FAEeWsC
        lArqvktYm3ZAu9otHP4u1cKQY7VnATm+acwJshs8H2mwNYTagU6XH+aR0kd4LpQyrZQF5FysoTL9L
        B8uNfIOZg==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIcut-0001Db-4e; Mon, 22 Apr 2019 17:39:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIcup-00072Y-Uy; Mon, 22 Apr 2019 14:39:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] docs: hwmon: convert three docs to ReST format
Date:   Mon, 22 Apr 2019 14:39:37 -0300
Message-Id: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555954774.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those three new drivers were missed on the initial conversion
to ReST format. So:

- Rename them to .rst;
- Add them to the hwmon index.rst index;
- add some blank lines at the "Supported systems:" part, in
  order to allow Sphinx to properly identify new lines,
  suppressing warnings and avoid it to output some random
  lines in bold;
- When multiple authors are involved, change the authors
  part to a list, in order to avoid adding blank lines.
- adjust the table cells (one of the tables seemed to be
  assuming that tab is 4 positions instead of 8) and add
  the table markup.
- be sure that the section markups have the same number of
  characters as the section title.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/index.rst                 |  3 +++
 Documentation/hwmon/{ir38064 => ir38064.rst}  | 21 ++++++++++++-------
 .../hwmon/{isl68137 => isl68137.rst}          | 16 ++++++++++----
 .../hwmon/{lochnagar => lochnagar.rst}        |  7 +++++--
 4 files changed, 33 insertions(+), 14 deletions(-)
 rename Documentation/hwmon/{ir38064 => ir38064.rst} (76%)
 rename Documentation/hwmon/{isl68137 => isl68137.rst} (85%)
 rename Documentation/hwmon/{lochnagar => lochnagar.rst} (93%)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 893804414510..3fa14fe7b49c 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -65,6 +65,8 @@ Hardware Monitoring Kernel Drivers
    ina2xx.rst
    ina3221.rst
    ir35221.rst
+   ir38064.rst
+   isl68137.rst
    it87.rst
    jc42.rst
    k10temp.rst
@@ -86,6 +88,7 @@ Hardware Monitoring Kernel Drivers
    lm93.rst
    lm95234.rst
    lm95245.rst
+   lochnagar.rst
    ltc2945.rst
    ltc2978.rst
    ltc2990.rst
diff --git a/Documentation/hwmon/ir38064 b/Documentation/hwmon/ir38064.rst
similarity index 76%
rename from Documentation/hwmon/ir38064
rename to Documentation/hwmon/ir38064.rst
index 9f218c39bfe6..c455d755a267 100644
--- a/Documentation/hwmon/ir38064
+++ b/Documentation/hwmon/ir38064.rst
@@ -2,15 +2,18 @@ Kernel driver ir38064
 =====================
 
 Supported chips:
+
   * Infineon IR38064
+
     Prefix: 'ir38064'
     Addresses scanned: -
+
     Datasheet: Publicly available at the Infineon webiste
       https://www.infineon.com/dgdl/Infineon-IR38064MTRPBF-DS-v03_07-EN.pdf?fileId=5546d462584d1d4a0158db0d9efb67ca
 
 Authors:
-        Maxim Sloyko <maxims@google.com>
-        Patrick Venture <venture@google.com>
+      - Maxim Sloyko <maxims@google.com>
+      - Patrick Venture <venture@google.com>
 
 Description
 -----------
@@ -26,29 +29,30 @@ devices explicitly.
 Sysfs attributes
 ----------------
 
+======================= ===========================
 curr1_label		"iout1"
 curr1_input		Measured output current
 curr1_crit		Critical maximum current
 curr1_crit_alarm	Current critical high alarm
 curr1_max		Maximum current
-curr1_max_alarm	Current high alarm
+curr1_max_alarm		Current high alarm
 
 in1_label		"vin"
 in1_input		Measured input voltage
 in1_crit		Critical maximum input voltage
 in1_crit_alarm		Input voltage critical high alarm
-in1_min		Minimum input voltage
+in1_min			Minimum input voltage
 in1_min_alarm		Input voltage low alarm
 
 in2_label		"vout1"
 in2_input		Measured output voltage
 in2_lcrit		Critical minimum output voltage
-in2_lcrit_alarm	Output voltage critical low alarm
+in2_lcrit_alarm		Output voltage critical low alarm
 in2_crit		Critical maximum output voltage
 in2_crit_alarm		Output voltage critical high alarm
-in2_max		Maximum output voltage
+in2_max			Maximum output voltage
 in2_max_alarm		Output voltage high alarm
-in2_min		Minimum output voltage
+in2_min			Minimum output voltage
 in2_min_alarm		Output voltage low alarm
 
 power1_label		"pout1"
@@ -58,4 +62,5 @@ temp1_input		Measured temperature
 temp1_crit		Critical high temperature
 temp1_crit_alarm	Chip temperature critical high alarm
 temp1_max		Maximum temperature
-temp1_max_alarm	Chip temperature high alarm
+temp1_max_alarm		Chip temperature high alarm
+======================= ===========================
diff --git a/Documentation/hwmon/isl68137 b/Documentation/hwmon/isl68137.rst
similarity index 85%
rename from Documentation/hwmon/isl68137
rename to Documentation/hwmon/isl68137.rst
index 92e5c5fc5b77..a5a7c8545c9e 100644
--- a/Documentation/hwmon/isl68137
+++ b/Documentation/hwmon/isl68137.rst
@@ -2,16 +2,22 @@ Kernel driver isl68137
 ======================
 
 Supported chips:
+
   * Intersil ISL68137
+
     Prefix: 'isl68137'
+
     Addresses scanned: -
-    Datasheet: Publicly available at the Intersil website
+
+    Datasheet:
+
+      Publicly available at the Intersil website
       https://www.intersil.com/content/dam/Intersil/documents/isl6/isl68137.pdf
 
 Authors:
-        Maxim Sloyko <maxims@google.com>
-        Robert Lippert <rlippert@google.com>
-        Patrick Venture <venture@google.com>
+      - Maxim Sloyko <maxims@google.com>
+      - Robert Lippert <rlippert@google.com>
+      - Patrick Venture <venture@google.com>
 
 Description
 -----------
@@ -32,6 +38,7 @@ Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute
 Additional Sysfs attributes
 ---------------------------
 
+======================= ====================================
 avs(0|1)_enable		Controls the AVS state of each rail.
 
 curr1_label		"iin"
@@ -70,3 +77,4 @@ temp[1-3]_crit		Critical high temperature
 temp[1-3]_crit_alarm	Chip temperature critical high alarm
 temp[1-3]_max		Maximum temperature
 temp[1-3]_max_alarm	Chip temperature high alarm
+======================= ====================================
diff --git a/Documentation/hwmon/lochnagar b/Documentation/hwmon/lochnagar.rst
similarity index 93%
rename from Documentation/hwmon/lochnagar
rename to Documentation/hwmon/lochnagar.rst
index e9686fb3eb40..1d609c4d18c3 100644
--- a/Documentation/hwmon/lochnagar
+++ b/Documentation/hwmon/lochnagar.rst
@@ -1,5 +1,5 @@
 Kernel Driver Lochnagar
-========================
+=======================
 
 Supported systems:
   * Cirrus Logic : Lochnagar 2
@@ -21,6 +21,7 @@ by software.
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 temp1_input             The Lochnagar board temperature (milliCelsius)
 in0_input               Measured voltage for DBVDD1 (milliVolts)
 in0_label               "DBVDD1"
@@ -76,5 +77,7 @@ curr8_label             "MICVDD"
 power8_average          Measured average power for MICVDD (microWatts)
 power8_average_interval Power averaging time input valid from 1 to 1708mS
 power8_label            "MICVDD"
+======================= =======================================================
 
-Note: It is not possible to measure voltage on the SYSVDD rail.
+Note:
+    It is not possible to measure voltage on the SYSVDD rail.
-- 
2.20.1

