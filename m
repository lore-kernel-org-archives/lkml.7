Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AF420679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxEYB9Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJUCV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:21:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfJUCV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7t9iy0ZeTZGloF+pLdKmONwsyKHhXmaNL8ryD9WsF08=; b=oxEYB9AcT+EcX6lyt2W7DmE4G
        7rerwgzkcC8BHRNXaS65B4fHxZg3BM1alVoihWZPbS5sqm0JJ5gBhQoVM5Sq2Npn1IxCG8D7P6LQ/
        6HhfFQXMW0QDDTbNx9TGUAcAdwLY3pZn+V1BkPXB+9HT8v7AGivJCochTUQk9I3xIx+Osfb1tPgOK
        9xgFuo5i81CrCauZKcv/zM1bsTtjz/j+lH+eAboqb+nfZtUGPqaE+FQw/PqJal6Nw5NXIrCURSwAw
        FndF0sV7pRJxjCnaZah1zxDJyKdkw7rjZ0anX3ew5UHFKfgTCQhK794++qyZURBOL7sWN3dfbyEkf
        erQlHj1aA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMNKV-0003fY-Gx; Mon, 21 Oct 2019 02:21:55 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] docs: admin-guide/perf: fix imx-ddr.rst warnings
Message-ID: <68650583-bd4b-2b25-b842-a91a9643ce00@infradead.org>
Date:   Sun, 20 Oct 2019 19:21:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warnings in imx-ddr.rst:

Documentation/admin-guide/perf/imx-ddr.rst:21: WARNING: Unexpected indentation.
Documentation/admin-guide/perf/imx-ddr.rst:34: WARNING: Unexpected indentation.
Documentation/admin-guide/perf/imx-ddr.rst:40: WARNING: Unexpected indentation.
Documentation/admin-guide/perf/imx-ddr.rst:45: WARNING: Unexpected indentation.
Documentation/admin-guide/perf/imx-ddr.rst:52: WARNING: Unexpected indentation.

Fixes: 3724e186fead ("docs/perf: Add documentation for the i.MX8 DDR PMU")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/admin-guide/perf/imx-ddr.rst |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- lnx-54-rc4.orig/Documentation/admin-guide/perf/imx-ddr.rst
+++ lnx-54-rc4/Documentation/admin-guide/perf/imx-ddr.rst
@@ -17,8 +17,8 @@ The "format" directory describes format
 (AXI filtering) fields of the perf_event_attr structure, see /sys/bus/event_source/
 devices/imx8_ddr0/format/. The "events" directory describes the events types
 hardware supported that can be used with perf tool, see /sys/bus/event_source/
-devices/imx8_ddr0/events/.
-  e.g.::
+devices/imx8_ddr0/events/.  E.g.::
+
         perf stat -a -e imx8_ddr0/cycles/ cmd
         perf stat -a -e imx8_ddr0/read/,imx8_ddr0/write/ cmd
 
@@ -31,22 +31,25 @@ in the driver.
   Filter is defined with two configuration parts:
   --AXI_ID defines AxID matching value.
   --AXI_MASKING defines which bits of AxID are meaningful for the matching.
+
         0：corresponding bit is masked.
         1: corresponding bit is not masked, i.e. used to do the matching.
 
   AXI_ID and AXI_MASKING are mapped on DPCR1 register in performance counter.
   When non-masked bits are matching corresponding AXI_ID bits then counter is
   incremented. Perf counter is incremented if
+
           AxID && AXI_MASKING == AXI_ID && AXI_MASKING
 
   This filter doesn't support filter different AXI ID for axid-read and axid-write
-  event at the same time as this filter is shared between counters.
-  e.g.::
+  event at the same time as this filter is shared between counters.  E.g.::
+
         perf stat -a -e imx8_ddr0/axid-read,axi_mask=0xMMMM,axi_id=0xDDDD/ cmd
         perf stat -a -e imx8_ddr0/axid-write,axi_mask=0xMMMM,axi_id=0xDDDD/ cmd
 
   NOTE: axi_mask is inverted in userspace(i.e. set bits are bits to mask), and
   it will be reverted in driver automatically. so that the user can just specify
   axi_id to monitor a specific id, rather than having to specify axi_mask.
-  e.g.::
+  E.g.::
+
         perf stat -a -e imx8_ddr0/axid-read,axi_id=0x12/ cmd, which will monitor ARID=0x12

