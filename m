Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F379C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7F2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLIE65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:58:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbfLIE6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:58:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB94uq1X055920
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 23:58:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt10jbne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:58:51 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Mon, 9 Dec 2019 04:58:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 04:58:45 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB94wiWM54526014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 04:58:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F0FCA4057;
        Mon,  9 Dec 2019 04:58:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F979A4055;
        Mon,  9 Dec 2019 04:58:42 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Dec 2019 04:58:42 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v5 5/6] Documentation/ABI: mark /sys/kernel/fadump_* sysfs files deprecated
Date:   Mon,  9 Dec 2019 10:28:25 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
References: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120904-0020-0000-0000-00000395B176
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120904-0021-0000-0000-000021ECEA33
Message-Id: <20191209045826.30076-6-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=1 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a deprecation note in FADump sysfs ABI documentation files and move
them from ABI/testing to ABI/obsolete directory.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 .../ABI/{testing => obsolete}/sysfs-kernel-fadump_enabled | 2 ++
 .../{testing => obsolete}/sysfs-kernel-fadump_registered  | 2 ++
 .../{testing => obsolete}/sysfs-kernel-fadump_release_mem | 2 ++
 Documentation/powerpc/firmware-assisted-dump.rst          | 8 ++++++++
 4 files changed, 14 insertions(+)
 rename Documentation/ABI/{testing => obsolete}/sysfs-kernel-fadump_enabled (73%)
 rename Documentation/ABI/{testing => obsolete}/sysfs-kernel-fadump_registered (77%)
 rename Documentation/ABI/{testing => obsolete}/sysfs-kernel-fadump_release_mem (78%)

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_enabled b/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
similarity index 73%
rename from Documentation/ABI/testing/sysfs-kernel-fadump_enabled
rename to Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
index f73632b1c006..e9c2de8b3688 100644
--- a/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
@@ -1,3 +1,5 @@
+This ABI is renamed and moved to a new location /sys/kernel/fadump/enabled.
+
 What:		/sys/kernel/fadump_enabled
 Date:		Feb 2012
 Contact:	linuxppc-dev@lists.ozlabs.org
diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_registered b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
similarity index 77%
rename from Documentation/ABI/testing/sysfs-kernel-fadump_registered
rename to Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
index dcf925e53f0f..0360be39c98e 100644
--- a/Documentation/ABI/testing/sysfs-kernel-fadump_registered
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
@@ -1,3 +1,5 @@
+This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.¬
+
 What:		/sys/kernel/fadump_registered
 Date:		Feb 2012
 Contact:	linuxppc-dev@lists.ozlabs.org
diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
similarity index 78%
rename from Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
rename to Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
index 9c20d64ab48d..6ce0b129ab12 100644
--- a/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
@@ -1,3 +1,5 @@
+This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.¬
+
 What:		/sys/kernel/fadump_release_mem
 Date:		Feb 2012
 Contact:	linuxppc-dev@lists.ozlabs.org
diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
index 345a3405206e..365c10209ef3 100644
--- a/Documentation/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/powerpc/firmware-assisted-dump.rst
@@ -295,6 +295,14 @@ Note: /sys/kernel/fadump_release_opalcore sysfs has moved to
 
     echo 1  > /sys/firmware/opal/mpipl/release_core
 
+Note: The following FADump sysfs files are deprecated.
+
+    Deprecated                           Alternative
+    --------------------------------------------------------------------
+    /sys/kernel/fadump_enabled           /sys/kernel/fadump/enabled
+    /sys/kernel/fadump_registered        /sys/kernel/fadump/registered
+    /sys/kernel/fadump_release_mem       /sys/kernel/fadump/release_mem
+
 Here is the list of files under powerpc debugfs:
 (Assuming debugfs is mounted on /sys/kernel/debug directory.)
 
-- 
2.17.2

