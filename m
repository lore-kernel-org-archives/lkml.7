Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1EAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454C520820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924307;
	bh=HCyOMMD/wZmat4HP/wUJRCr1Bqu0m8pq5veAQiyfbTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZLjIWjg4noMhKGs3JLVYligqUj1tOO2ArWSsIZjybdvTxsJqYmRfpdLNu1Xxm1D7m
	 Rvv0zb27XAscie3zNsvsXGm0oM7GUOV+wllDiO35UCl3NS95SwUncCTNPgoM/MvukO
	 efI66GwQ18OZsYiLNUwvf9tDDczpdVeOqbZcY0yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDJTZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:25:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfDJTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M6d3gsVlVPLCn/N3u8ByL4YNqFMBx3u0kXh2q28dX1Q=; b=BRAWhjzU7u+TxrUivrvUaP016V
        DLsNBYzt/8+l2GNszeTD1IuxZzJ4ksEatP9cz5mY6Kd5yCdG/7lCd0KKRVmSJ3TPJvcIkMPNM/DOL
        fwcvOuIETQiWtaGUUf2LfZCNbu9kNeAENw9Lt5NITjG/LobVB40WJIulJgBK3rKf1Mbh9UvgoRQNN
        2sVnL1MMGf3QGX0x6wx2fXNK0XT2w5i8/Nt36Xb3J2Lws7Y8u6C3Pgd7ylK/2DgDx0hqWVsqp9mNC
        TqMHmzk1F6C6QOq6+9LssUkATHfGQD+5p9BFa6qvYFGFaeEhRd7sfuvHy62Vmh9cg0uOHkzhQ7+aw
        +cCqll/A==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoM-0003R9-Ir; Wed, 10 Apr 2019 19:23:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoI-0000ys-Su; Wed, 10 Apr 2019 16:23:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 07/21] docs: hwmon: fam15h_power: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:44 -0300
Message-Id: <5ac49872dfbdb4d36868980e9a535d657a6679e0.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert fam15h_power to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/fam15h_power | 85 +++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/Documentation/hwmon/fam15h_power b/Documentation/hwmon/fam15h_power
index fb594c281c46..fdde632c93a3 100644
--- a/Documentation/hwmon/fam15h_power
+++ b/Documentation/hwmon/fam15h_power
@@ -2,15 +2,20 @@ Kernel driver fam15h_power
 ==========================
 
 Supported chips:
+
 * AMD Family 15h Processors
+
 * AMD Family 16h Processors
 
   Prefix: 'fam15h_power'
+
   Addresses scanned: PCI space
+
   Datasheets:
-  BIOS and Kernel Developer's Guide (BKDG) For AMD Family 15h Processors
-  BIOS and Kernel Developer's Guide (BKDG) For AMD Family 16h Processors
-  AMD64 Architecture Programmer's Manual Volume 2: System Programming
+
+  - BIOS and Kernel Developer's Guide (BKDG) For AMD Family 15h Processors
+  - BIOS and Kernel Developer's Guide (BKDG) For AMD Family 16h Processors
+  - AMD64 Architecture Programmer's Manual Volume 2: System Programming
 
 Author: Andreas Herrmann <herrmann.der.user@googlemail.com>
 
@@ -31,14 +36,19 @@ For AMD Family 15h and 16h processors the following power values can
 be calculated using different processor northbridge function
 registers:
 
-* BasePwrWatts: Specifies in watts the maximum amount of power
-  consumed by the processor for NB and logic external to the core.
-* ProcessorPwrWatts: Specifies in watts the maximum amount of power
-  the processor can support.
-* CurrPwrWatts: Specifies in watts the current amount of power being
-  consumed by the processor.
+* BasePwrWatts:
+    Specifies in watts the maximum amount of power
+    consumed by the processor for NB and logic external to the core.
+
+* ProcessorPwrWatts:
+    Specifies in watts the maximum amount of power
+    the processor can support.
+* CurrPwrWatts:
+    Specifies in watts the current amount of power being
+    consumed by the processor.
 
 This driver provides ProcessorPwrWatts and CurrPwrWatts:
+
 * power1_crit (ProcessorPwrWatts)
 * power1_input (CurrPwrWatts)
 
@@ -53,35 +63,53 @@ calculate the average power consumed by a processor during a
 measurement interval Tm. The feature of accumulated power mechanism is
 indicated by CPUID Fn8000_0007_EDX[12].
 
-* Tsample: compute unit power accumulator sample period
-* Tref: the PTSC counter period
-* PTSC: performance timestamp counter
-* N: the ratio of compute unit power accumulator sample period to the
-  PTSC period
-* Jmax: max compute unit accumulated power which is indicated by
-  MaxCpuSwPwrAcc MSR C001007b
-* Jx/Jy: compute unit accumulated power which is indicated by
-  CpuSwPwrAcc MSR C001007a
-* Tx/Ty: the value of performance timestamp counter which is indicated
-  by CU_PTSC MSR C0010280
-* PwrCPUave: CPU average power
+* Tsample:
+	compute unit power accumulator sample period
+
+* Tref:
+	the PTSC counter period
+
+* PTSC:
+	performance timestamp counter
+
+* N:
+	the ratio of compute unit power accumulator sample period to the
+	PTSC period
+
+* Jmax:
+	max compute unit accumulated power which is indicated by
+	MaxCpuSwPwrAcc MSR C001007b
+
+* Jx/Jy:
+	compute unit accumulated power which is indicated by
+	CpuSwPwrAcc MSR C001007a
+* Tx/Ty:
+	the value of performance timestamp counter which is indicated
+	by CU_PTSC MSR C0010280
+
+* PwrCPUave:
+	CPU average power
 
 i. Determine the ratio of Tsample to Tref by executing CPUID Fn8000_0007.
+
 	N = value of CPUID Fn8000_0007_ECX[CpuPwrSampleTimeRatio[15:0]].
 
 ii. Read the full range of the cumulative energy value from the new
-MSR MaxCpuSwPwrAcc.
+    MSR MaxCpuSwPwrAcc.
+
 	Jmax = value returned.
+
 iii. At time x, SW reads CpuSwPwrAcc MSR and samples the PTSC.
-	Jx = value read from CpuSwPwrAcc and Tx = value read from
-PTSC.
+
+	Jx = value read from CpuSwPwrAcc and Tx = value read from PTSC.
 
 iv. At time y, SW reads CpuSwPwrAcc MSR and samples the PTSC.
-	Jy = value read from CpuSwPwrAcc and Ty = value read from
-PTSC.
+
+	Jy = value read from CpuSwPwrAcc and Ty = value read from PTSC.
 
 v. Calculate the average power consumption for a compute unit over
-time period (y-x). Unit of result is uWatt.
+   time period (y-x). Unit of result is uWatt::
+
 	if (Jy < Jx) // Rollover has occurred
 		Jdelta = (Jy + Jmax) - Jx
 	else
@@ -90,13 +118,14 @@ time period (y-x). Unit of result is uWatt.
 
 This driver provides PwrCPUave and interval(default is 10 millisecond
 and maximum is 1 second):
+
 * power1_average (PwrCPUave)
 * power1_average_interval (Interval)
 
 The power1_average_interval can be updated at /etc/sensors3.conf file
 as below:
 
-chip "fam15h_power-*"
+chip `fam15h_power-*`
 	set power1_average_interval 0.01
 
 Then save it with "sensors -s".
-- 
2.20.1

