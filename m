Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC229CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F179206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VZWxh9Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfKEGSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:18:04 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32710 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfKEGSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:18:04 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191105061801epoutp031e0085d5843d3f80fee85bdea80dac7b~UL8JbqFKX0041400414epoutp03L
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 06:18:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191105061801epoutp031e0085d5843d3f80fee85bdea80dac7b~UL8JbqFKX0041400414epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572934681;
        bh=zvDyle6bohL117tTJ/UWB7iQOUwEqSjQ/Ez1zyRaSUo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VZWxh9YaMbPlq6wRBH/gf46rbkfgWTQgAR3Oj4EDTH6OdktNk1TQW+wBej3PU1ubk
         WHa+KdrlOyyR2aQ2PVS/DFNHhGV3lxSCSISuYvaC05CLrbTXXAxDSV7V2Q26WaMZKn
         VIOSBvKOwGgJPZVq7EP9ILcDrV3txt1JwXWWqBYI=
Received: from epcpadp2 (unknown [182.195.40.12]) by epcas1p1.samsung.com
        (KnoxPortal) with ESMTP id
        20191105061801epcas1p13ce51b09e567ec4f7caa80fe4659a18f~UL8I_dX6j3234732347epcas1p1f;
        Tue,  5 Nov 2019 06:18:01 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5~ULXRItVvL0066700667epcas1p2t;
        Tue,  5 Nov 2019 05:35:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191105053547epsmtrp1943b7305a5721d8062454f9f08564899~ULXRHwUwu0859808598epsmtrp1Z;
        Tue,  5 Nov 2019 05:35:47 +0000 (GMT)
X-AuditID: b6c32a29-973ff700000060b4-89-5dc10a33c077
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.D8.24756.33A01CD5; Tue,  5 Nov 2019 14:35:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191105053546epsmtip21649b16049b13f96e965b4a83c0dc9ac~ULXQm3R1k0405604056epsmtip2B;
        Tue,  5 Nov 2019 05:35:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org
Cc:     chanwoo@kernel.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, robh@kernel.org, paulmck@linux.ibm.com,
        cpgs@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] MAINTAINERS: Update myself as maintainer for DEVFREQ
 subsystem support
Date:   Tue,  5 Nov 2019 14:41:19 +0900
Message-Id: <1019298652.01572934681167.JavaMail.epsvc@epcpadp2>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvK4x18FYg/42fouJN66wWLw8pGlx
        /ctzVos551tYLJoXr2ezuLxrDpvF+0+dTBa3G1ewWcy4NZXJ4szpS6wW//fsYHfg9tiy8iaT
        x6ZVnWweExYdYPTYP3cNu8eWq+0sHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJVxbpZfQQ9/
        xZxNK9kaGKfwdjFyckgImEgsm/efuYuRi0NIYDejxLT1R9ghEpIS0y4eBUpwANnCEocPF0PU
        fGKUuNF/mQWkhk1AS2L/ixtsILaIQL7E8q6FLCBFzAKbGSXW3d8IlhAWCJf4tfgAWAOLgKrE
        7cNvwWxeASuJpfM3MEEsk5dYveEA8wRGngWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS
        83M3MYLDT0tzB+PlJfGHGAU4GJV4eD+0H4gVYk0sK67MPcQowcGsJMJ7ccbeWCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYZ6RYSO6ZzMajPa3++b1/
        YQxm3ncM7TfOXPsn0CDIXShoq9u6ZRNcjpdfFH7f81FcoJqzYpJVug3H5Mjpix9yeuebOVRG
        NK84H7yU3zHmfbTjLcEFJxat79YMeqnKEvjkcJn4kmu3e6fP/RRqvOJv4ZsnTqq6X+5dY13N
        2rd+46WSvhUpqv96lFiKMxINtZiLihMBf7fP9jsCAAA=
X-CMS-MailID: 20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-Hop-Count: 3
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CMS-RootMailID: 20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5
References: <CGME20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update myself to the DEVFREQ entry as maintainer from reviewer and
the git repository information to manage the devfreq patches. I've been
reviewing and tesing the devfreq support for the couple of years as reviewer.
From now, I'll help and reiview the devfreq as maintainer.

Suggested-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..ebc1078c1ecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3532,7 +3532,7 @@ BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 S:	Maintained
 F:	drivers/devfreq/exynos-bus.c
 F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -4762,9 +4762,9 @@ F:	include/linux/devcoredump.h
 DEVICE FREQUENCY (DEVFREQ)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
-R:	Chanwoo Choi <cw00.choi@samsung.com>
+M:	Chanwoo Choi <cw00.choi@samsung.com>
 L:	linux-pm@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 S:	Maintained
 F:	drivers/devfreq/
 F:	include/linux/devfreq.h
@@ -4774,7 +4774,7 @@ F:	include/trace/events/devfreq.h
 DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 L:	linux-pm@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 S:	Supported
 F:	drivers/devfreq/event/
 F:	drivers/devfreq/devfreq-event.c
-- 
2.17.1


