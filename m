Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A1BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29441217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BhQ0pTV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfEUGoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:44:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46416 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbfEUGoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:44:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L6YgHN012668
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:44:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=QeAmk1u2VBg6hpQ2bHtPJujY0+YOpk5Utt64CR2i5bA=;
 b=BhQ0pTV3xo9kk89AoRgO/C/P8KoSLSzPeGaTFoqy7Fnf9baM9E0qGL5sqVZ2/vNMYWll
 /KVkElQ3unD9tS4VRxWhGd/d8iJfjD0rtcAyF3J1H8A+guzazu4a79raDHtWq+S0+dt0
 10ZICEl5SWVydIiCr4BuJ9RW3j95Nit750Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sm7fk0rhb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:44:11 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 23:44:10 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DD11762E2DA2; Mon, 20 May 2019 23:44:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf docs: description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
Date:   Mon, 20 May 2019 23:44:06 -0700
Message-ID: <20190521064406.2498925-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=955 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210043
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addes description of HEADER_BPF_PROG_INFO and HEADER_BPF_BTF to
perf.data-file-format.txt.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../perf/Documentation/perf.data-file-format.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 6967e9b02be5..ab48db21ff16 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,22 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+        HEADER_BPF_PROG_INFO = 25,
+
+struct bpf_prog_info_linear, which contains detailed information about
+a BPF program, including type, id, tag, jited/xlated instructions, etc.
+
+        HEADER_BPF_BTF = 26,
+
+Contains BPF Type Format (BTF). For more information about BTF, please
+refer to Documentation/bpf/btf.rst.
+
+struct {
+	u32	id;
+	u32	data_size;
+	char	data[];
+};
+
         HEADER_COMPRESSED = 27,
 
 struct {
-- 
2.17.1

