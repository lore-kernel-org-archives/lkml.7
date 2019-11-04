Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3DCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8F121D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904437;
	bh=3csVmTOHNGTB+c9xUv/fHEeweHnvr5OV6v+ydEEUMDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RGjpb4P6MuN6t9U1b/4k0KYXLVgEi3kU+veCABEwwhwS7rU1UujG0hHF5WQ3PD5QV
	 R1ym5bUKgf9P1SlAvuvrTL/7ECHDRqw8Q8nBpnnRVrB0LeZuBoUl5r9pWMlkQrZLwt
	 QoeE72J6faw/2v5PMTRO/47gyHqQAtj4daPsExVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfKDVxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbfKDVxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:53 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF08021D7D;
        Mon,  4 Nov 2019 21:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904432;
        bh=3csVmTOHNGTB+c9xUv/fHEeweHnvr5OV6v+ydEEUMDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFFw9X9TRR7WG3WhWpHH4xN134/26T8ejAbJ/z27+TNWjC8lLtSTHm65m8HWUdH58
         qhxbPPABeGIf6Sf0qVOwxwioRRwIxGRlf7XhCvq0w1vsh1PQrYJftkvSVyCzyUcrQh
         Mf4GkpomPVyQHAT/jn1IwWeEgC7MDqBiLvBFgg2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/95] scsi: lpfc: Fix a duplicate 0711 log message number.
Date:   Mon,  4 Nov 2019 22:44:05 +0100
Message-Id: <20191104212041.565874080@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 2c4c91415a05677acc5c8131a5eb472d4aa96ae1 ]

Renumber one of the 0711 log messages so there isn't a duplication.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 4ade13d72deb3..07cb671bb8550 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4152,7 +4152,7 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	/* If pCmd was set to NULL from abort path, do not call scsi_done */
 	if (xchg(&lpfc_cmd->pCmd, NULL) == NULL) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
-				 "0711 FCP cmd already NULL, sid: 0x%06x, "
+				 "5688 FCP cmd already NULL, sid: 0x%06x, "
 				 "did: 0x%06x, oxid: 0x%04x\n",
 				 vport->fc_myDID,
 				 (pnode) ? pnode->nlp_DID : 0,
-- 
2.20.1



