Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FC3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249B3206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559691019;
	bh=LYV58kiXJafFJBYdU3Xvv1xgPXRCfDQpqgdYy5HhELA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbRpzh7RcI1kzvnk2vuY0GVI6CmZ/n+8MvM7xF+J9J/0Q0HSN2fFlgNerKKJLmTbC
	 mxAaTqtccenNgNkrOALtNCmVmPRDxmregMMIy28VFd3jalskkKpsTI2CKTfCPZ9Kbk
	 xGNT47Ke5VNImZY7F95c6hpMtFVAXDH5cSKrEQgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfFDXaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfFDXX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:23:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3476D20859;
        Tue,  4 Jun 2019 23:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690638;
        bh=LYV58kiXJafFJBYdU3Xvv1xgPXRCfDQpqgdYy5HhELA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0vcfMDk9iWtoQZ314gs/pUUEsxzK9aVx8fJIRPlSyM/a/+ZCKNOPCISIu3h57WG4
         veBXn7mnq4ZRx07Uo1tREzMhPfuGqoDY++rxDEtWnIElUiCnMTWt6Uf8FmSfQMJboN
         m+qBnBWbwMi0pOsad67WTU1FXA0FHmxfBBCqy6Ig=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/36] scsi: qedi: remove set but not used variables 'cdev' and 'udev'
Date:   Tue,  4 Jun 2019 19:23:08 -0400
Message-Id: <20190604232333.7185-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit d0adee5d12752256ff0c87ad7f002f21fe49d618 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/qedi/qedi_iscsi.c: In function 'qedi_ep_connect':
drivers/scsi/qedi/qedi_iscsi.c:813:23: warning: variable 'udev' set but not used [-Wunused-but-set-variable]
drivers/scsi/qedi/qedi_iscsi.c:812:18: warning: variable 'cdev' set but not used [-Wunused-but-set-variable]

These have never been used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_iscsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 4130b9117055..1b7049dce169 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -810,8 +810,6 @@ qedi_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
 	struct qedi_endpoint *qedi_ep;
 	struct sockaddr_in *addr;
 	struct sockaddr_in6 *addr6;
-	struct qed_dev *cdev  =  NULL;
-	struct qedi_uio_dev *udev = NULL;
 	struct iscsi_path path_req;
 	u32 msg_type = ISCSI_KEVENT_IF_DOWN;
 	u32 iscsi_cid = QEDI_CID_RESERVED;
@@ -831,8 +829,6 @@ qedi_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
 	}
 
 	qedi = iscsi_host_priv(shost);
-	cdev = qedi->cdev;
-	udev = qedi->udev;
 
 	if (test_bit(QEDI_IN_OFFLINE, &qedi->flags) ||
 	    test_bit(QEDI_IN_RECOVERY, &qedi->flags)) {
-- 
2.20.1

