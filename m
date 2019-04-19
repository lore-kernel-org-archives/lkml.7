Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709BCC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3798B20821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dkLpU809"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfDSTTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:19:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:38343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfDSTTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555701589;
        bh=GmNNCdHbkeV6zf8uwKLg/xSRBB4uJcYIZU7MFYK2afw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dkLpU809Sg0uChEbM/8PkhzYIuVxaMqPMUVKAjaU6+YHyLWBCRE5IBABRrhuKotu1
         QN29z5FeG8WllIl1Xu2v9g9uYO/0G0yv7P7tFozDGRfdMW1Tp09cDuwkZD3o4kAx/K
         tqVb1H5K6bAoIEJxHFYXipuWVTcuRrgTdB4fHA4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M3RVA-1gzpRI1MA4-00r0XG; Fri, 19 Apr 2019 07:46:41 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] quota: fix wrong indentation
Date:   Fri, 19 Apr 2019 13:46:01 +0800
Message-Id: <20190419054601.23752-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mVtvSSF0rN2zTbXxsHfodvbd7Oy16JhECRItuhQI6IlO3Rr5Z++
 IHOnXraRy4uNL3N9hz5dZ0VOd7LTUy4yECRVeb8S1vVnMG6jkvviFWRrerOLEceZfz3IG+1
 2y8AHPZg/0V1UhrzRk6cI/Zny2R/C72XN0BswV1cGXg+UOs0Rg/tKhrd1B1ek2lhs/qkfcW
 ZIZPwGnpbPTXMKPYGelbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q5LOzcGC2xs=:LZmkhYE4OAsvT4CvO4gw3N
 SHqF3gpl1uT81WAQprIXQNePn2owjm0MInxEoKq0fUnyegiog437EJwVPDUIn4qdfEOuRibCB
 wTT9ezCd+T7nSxaBIeXpNoHVt8mrvuu0T5yobQtmosgAN0f3AghbKSCviYMvA78XrcBijRfUi
 rmq0r4K8mmOFk5RuWAdDy8qTIK5Ek50Zr4+Vu/In6Ri5WnlpwpTtyxIvAD+i36769jeISx2Z7
 nSVyU0qcALODS9XsiuSrKvcWNqEz0UBaayi0Sro8fhXnpazX6dRSELduKkSZNaQfTZ37mTLyK
 nd8pnPS2jCJz90ICZyU+R91GL8ifsACNdnppRcZFwoVH/bSfjTXyRJHBcVLPSSU4SnX/CpECy
 s6Z9Bb7Qr6QJIIqDfNi09Nbtelagfz2PElKY2wHV4wUwo8VRGkJTWBJd82sDRNbBZxQv9uU6M
 MuZ1v0Eq+OoeSuPqVyy71L4Nc77q3lxkRd7TxHwmrnh81M/wbxx5iEt+sBgupRwYB39hU4xzS
 qRoWuIpVj8F2/UjT2D3BNyJsbrBjyycsAPOJOkkVgPqDenuMmRkYEzt/bhLoWlOBMRsXaiVE+
 2XdkgS01zG9PPSlUG6q6VQM8TgwvtBoeEicMlxFnVy0z5n5z31L5xavWNVGis5R1hJtZhrp0w
 /mJJ8VkmZlwZto/KJL27jaBeGqhMWbiSQaikhR+doRK2ia7KXXdYh0h2j9EFplWe7OebQpbXA
 M71vh2TOYAfqAS9JJIUybqoT8akjqsWekb3D2/kevtovBhQxU1T3rZVFYqE19QDNb5+q9DGaL
 fDxb7mWJYtXWVQBAB6ek8x8Bn5qILfihQMoB/quPts4XnyAmoGfYSq/VfCf6bhMlHWtUNXIqd
 oMsEn5dD1LDUw35txzncBBgmnFtPlwNq8+aCBZLiwUxMRQk0APO1aas1F+6eJC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to check return code only when calling ->read_dqblk(),
so fix it properly.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/quota/dquot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..934b8f3f9e57 100644
=2D-- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -424,10 +424,11 @@ int dquot_acquire(struct dquot *dquot)
 	struct quota_info *dqopt =3D sb_dqopt(dquot->dq_sb);

 	mutex_lock(&dquot->dq_lock);
-	if (!test_bit(DQ_READ_B, &dquot->dq_flags))
+	if (!test_bit(DQ_READ_B, &dquot->dq_flags)) {
 		ret =3D dqopt->ops[dquot->dq_id.type]->read_dqblk(dquot);
-	if (ret < 0)
-		goto out_iolock;
+		if (ret < 0)
+			goto out_iolock;
+	}
 	/* Make sure flags update is visible after dquot has been filled */
 	smp_mb__before_atomic();
 	set_bit(DQ_READ_B, &dquot->dq_flags);
=2D-
2.20.1

