Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F35C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6DB214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994078;
	bh=rZzUCzZ6Rqf436hrQX2bkP+WOVS3nnsV9wWsaczGeYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RYxZtTWkGeGQVEzn6DnzJnK+tAElDwmP1Gb7lzIlovcKs4wUsK+GpU8YqOEUqrhwy
	 ySrX1r5jR2kH85WWyjLcVxKTlAZMk3v6Uz6KGaAyYPMqfIjS1PTDOGRuEYNoFwhtL9
	 kjJb5lcfE27Qt0yeAaSE+1Jp/I16+JqIhwcFuXps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfFHLlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbfFHLlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:41:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72E321530;
        Sat,  8 Jun 2019 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994072;
        bh=rZzUCzZ6Rqf436hrQX2bkP+WOVS3nnsV9wWsaczGeYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ifbpd1pgff8gKABwaUd+jlSCsPQIBpkDk3ivTd00+irc08JvEdKCJmkFIBeg7Yf5d
         P/FSmimTBeVi5b8PbiY8cKLwpJSK+GXL4PFL5Lx1Qyi4DJKe9OLsRW6jKunY1LkV/z
         ICo6eiWMGRd/2Y7QdfpfjcwgQzmarN5MxNaiwV5M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 49/70] xen/pvcalls: Remove set but not used variable
Date:   Sat,  8 Jun 2019 07:39:28 -0400
Message-Id: <20190608113950.8033-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 41349672e3cbc2e8349831f21253509c3415aa2b ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/pvcalls-front.c: In function pvcalls_front_sendmsg:
drivers/xen/pvcalls-front.c:543:25: warning: variable bedata set but not used [-Wunused-but-set-variable]
drivers/xen/pvcalls-front.c: In function pvcalls_front_recvmsg:
drivers/xen/pvcalls-front.c:638:25: warning: variable bedata set but not used [-Wunused-but-set-variable]

They are never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 8a249c95c193..d7438fdc5706 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -540,7 +540,6 @@ out:
 int pvcalls_front_sendmsg(struct socket *sock, struct msghdr *msg,
 			  size_t len)
 {
-	struct pvcalls_bedata *bedata;
 	struct sock_mapping *map;
 	int sent, tot_sent = 0;
 	int count = 0, flags;
@@ -552,7 +551,6 @@ int pvcalls_front_sendmsg(struct socket *sock, struct msghdr *msg,
 	map = pvcalls_enter_sock(sock);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
 	mutex_lock(&map->active.out_mutex);
 	if ((flags & MSG_DONTWAIT) && !pvcalls_front_write_todo(map)) {
@@ -635,7 +633,6 @@ out:
 int pvcalls_front_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags)
 {
-	struct pvcalls_bedata *bedata;
 	int ret;
 	struct sock_mapping *map;
 
@@ -645,7 +642,6 @@ int pvcalls_front_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	map = pvcalls_enter_sock(sock);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
 	mutex_lock(&map->active.in_mutex);
 	if (len > XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER))
-- 
2.20.1

