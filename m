Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A81DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E752080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N8APy1AK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfJ3UWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:22:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfJ3UWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:22:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UKITUX005854
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 13:22:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=3k4vXaaqmt1qA9L1plz/vy6eRwvTfUHVlXVkp9uIoZ0=;
 b=N8APy1AKGgLQenqdm6igq5HmvFHPyayLcVuxbNHkivdc0omfm4OiafzT5owzYAj5yhHX
 Wftqz+t/ovnZB3fF3A4JvQpzNOVmOnCgLIcYRFyiLHOgvcLJBLSBKpDDcxUY9B6WcD34
 Os29V0BiTDZjHhma28AwEx4oWcFw+NFqOYg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vxwn65qny-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 13:22:51 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 30 Oct 2019 13:22:19 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1A0AF62E1DAC; Wed, 30 Oct 2019 13:22:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
Date:   Wed, 30 Oct 2019 13:22:17 -0700
Message-ID: <20191030202217.3498133-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_08:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=881 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910300177
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to find the mm tree in MAINTAINERS by searching "Morton".
Unfortunately, I didn't find one. And I didn't even locate the MEMORY
MANAGEMENT section quickly, because Andrew's name was not listed there.

Thanks to Johannes who helped me find the mm tree.

Let save other's time searching around by adding:

M:	Andrew Morton <akpm@linux-foundation.org>
T:	git git://github.com/hnaz/linux-mm.git

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a62ed61e6613..adafbe811e58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10621,8 +10621,10 @@ F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
 MEMORY MANAGEMENT
+M:	Andrew Morton <akpm@linux-foundation.org>
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
+T:	git git://github.com/hnaz/linux-mm.git
 S:	Maintained
 F:	include/linux/mm.h
 F:	include/linux/gfp.h
-- 
2.17.1

