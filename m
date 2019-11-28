Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8250B21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zc6c9VCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK1Q6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:58:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49912 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbfK1Q6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:58:40 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASGvBHr004446;
        Thu, 28 Nov 2019 17:58:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6uAkgoICWFUgjFMDGrLU4fz1PG9x6Te7OG2wuxrtuP4=;
 b=zc6c9VCLftGU4RdJOIzU/Q660Am1xjBcCtmGCF3qH3wPSTFxrFLDIgDWQ+6fGBMBzSzC
 o2Wx757wT20weex4ZpMGbh5VdiLvO/WEAuug+GA91OY3U/craxu5RKwdmLsSDz0G3SSv
 Rqb++cgzR7bTaxLmO3irSrROGs/Q1t57d5yGFUYMb1bS7M4/Cd5r/Y8sgbG898t/uZhP
 JjN7RWXSL9bJyxQ07iK9u918kWhRQT+2kH5xWPjVedgMS/3k7pfXSFebUycjtdLusJ0e
 SaRGMB/T8wiW7u2FQVVe2yiBW5dfaHCGK0XwUcfFN85rDV8rrpgwGmOHh7lHwXyAK8Ql tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxyk7cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 17:58:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 823AB10002A;
        Thu, 28 Nov 2019 17:58:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63FC12C8513;
        Thu, 28 Nov 2019 17:58:24 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Nov 2019 17:58:23
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] moduleparam: fix kerneldoc
Date:   Thu, 28 Nov 2019 17:58:00 +0100
Message-ID: <1574960280-28770-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_05:2019-11-28,2019-11-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document missing @args in xxx_param_cb().
Typo: use 'value' instead of 'lvalue'.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 include/linux/moduleparam.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index e5c3e23..944c569 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -135,7 +135,7 @@ struct kparam_array
 /**
  * module_param_named - typesafe helper for a renamed module/cmdline parameter
  * @name: a valid C identifier which is the parameter name.
- * @value: the actual lvalue to alter.
+ * @value: the actual value to alter.
  * @type: the type of the parameter
  * @perm: visibility in sysfs.
  *
@@ -160,6 +160,7 @@ struct kparam_array
  * module_param_cb - general callback for a module/cmdline parameter
  * @name: a valid C identifier which is the parameter name.
  * @ops: the set & get operations for this parameter.
+ * @args: args for @ops
  * @perm: visibility in sysfs.
  *
  * The ops can have NULL set or get functions.
@@ -176,6 +177,7 @@ struct kparam_array
  *                    to be evaluated before certain initcall level
  * @name: a valid C identifier which is the parameter name.
  * @ops: the set & get operations for this parameter.
+ * @args: args for @ops
  * @perm: visibility in sysfs.
  *
  * The ops can have NULL set or get functions.
@@ -457,7 +459,7 @@ enum hwparam_type {
 /**
  * module_param_hw_named - A parameter representing a hw parameters
  * @name: a valid C identifier which is the parameter name.
- * @value: the actual lvalue to alter.
+ * @value: the actual value to alter.
  * @type: the type of the parameter
  * @hwtype: what the value represents (enum hwparam_type)
  * @perm: visibility in sysfs.
-- 
2.7.4

