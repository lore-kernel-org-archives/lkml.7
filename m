Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D242C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28884218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfDXPRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:17:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730798AbfDXPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:17:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OF0T8M031826
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:17:12 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s2sb9bcq6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:17:12 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 24 Apr 2019 16:17:11 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 16:17:08 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OFH7vp29360302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 15:17:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB59ABE04F;
        Wed, 24 Apr 2019 15:17:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D33ABE051;
        Wed, 24 Apr 2019 15:17:07 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 15:17:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        hverkuil@xs4all.nl, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 3/4] media: dt-bindings: aspeed-video: Add missing memory-region property
Date:   Wed, 24 Apr 2019 10:16:59 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042415-8235-0000-0000-00000E865636
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010987; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193747; UDB=6.00625813; IPR=6.00974570;
 MB=3.00026577; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 15:17:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042415-8236-0000-0000-0000454660CF
Message-Id: <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed documenting this property in the initial commit.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Add missing semi-colon

 Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
index 78b464a..ce28945 100644
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
+    memory-region = <&video_engine_memory>;
 };
-- 
1.8.3.1

