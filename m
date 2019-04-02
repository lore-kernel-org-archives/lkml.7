Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6C4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB638208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfDBSZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:25:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731416AbfDBSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:25:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32IIiPU144648
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 14:25:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbtpun5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:25:18 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 2 Apr 2019 19:25:17 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 19:25:13 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32IPClE20906238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 18:25:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBCD5AE067;
        Tue,  2 Apr 2019 18:25:11 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DA03AE063;
        Tue,  2 Apr 2019 18:25:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 18:25:11 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: [PATCH 3/5] media: dt-bindings: aspeed-video: Add missing memory-region property
Date:   Tue,  2 Apr 2019 18:25:02 +0000
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040218-0040-0000-0000-000004DB865E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183363; UDB=6.00619524; IPR=6.00964111;
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:25:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0041-0000-0000-000008E686EC
Message-Id: <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed documenting this property in the initial commit.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
index 78b464a..346c2d3 100644
--- a/Documentation/devicetree/bindings/media/aspeed-video.txt
+++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
@@ -14,6 +14,11 @@ Required properties:
 			the VE
  - interrupts:		the interrupt associated with the VE on this platform
 
+Optional properties:
+ - memory-region:
+	phandle to a memory region to allocate from, as defined in
+	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+
 Example:
 
 video-engine@1e700000 {
@@ -23,4 +28,5 @@ video-engine@1e700000 {
     clock-names = "vclk", "eclk";
     resets = <&syscon ASPEED_RESET_VIDEO>;
     interrupts = <7>;
+    memory-region = <&video_engine_memory>
 };
-- 
1.8.3.1

