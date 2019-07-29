Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CAFC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC922070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfG2MOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:14:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbfG2MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:14:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TCA8hP057115
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u1y2fwjpt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 29 Jul 2019 13:14:36 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Jul 2019 13:14:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6TCEGWk13042042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 12:14:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217A6AE051;
        Mon, 29 Jul 2019 12:14:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E27EDAE05A;
        Mon, 29 Jul 2019 12:14:31 +0000 (GMT)
Received: from localhost (unknown [9.152.212.110])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Jul 2019 12:14:31 +0000 (GMT)
Date:   Mon, 29 Jul 2019 14:14:30 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH] kexec: restore arch_kexec_kernel_image_probe declaration
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
x-cbid: 19072912-0012-0000-0000-0000033748B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072912-0013-0000-0000-00002170E9DA
Message-Id: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_kexec_kernel_image_probe function declaration has been removed by
commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
functions"). Still this function is overridden by couple of architectures
and proper prototype declaration is therefore important, so bring it
back. This fixes the following sparse warning on s390:
arch/s390/kernel/machine_kexec_file.c:333:5: warning: symbol 'arch_kexec_kernel_image_probe' was not declared. Should it be static?

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 include/linux/kexec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1740fe36b5b7..f7529d120920 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -183,6 +183,8 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 
+int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+					 unsigned long buf_len);
 void * __weak arch_kexec_kernel_image_load(struct kimage *image);
 int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 					    Elf_Shdr *section,
-- 
2.21.0

