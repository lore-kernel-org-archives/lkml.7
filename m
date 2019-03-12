Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC78C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B620657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCLLxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:53:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43708 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:53:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so1637541pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:signed-off-by:user-agent;
        bh=b76zxPjoS5QtkEv0yNzG+P4rbYVcCluhsfbeAcEKgyA=;
        b=lOhNPEzHdI0qQGu9cUtKYgB3J/WtSjo71v3E8+Qg5VR9iLGQW+s5coLsbXiGxjzlFA
         vz5ekiqaBWwmEha312cVAD+pr6+MTShM6U1Eq7N37YEbZvADZWtzrXN6RhG3EOWMd2O5
         d/heoUX+GOqbWWk3MJ8rx8X8C/JCOoj05h7AcG3Hh+O+30S2vn49b/44y2BNt7/4tsEi
         1PKLwKwuBPHnRDbKNmUSNcjBzyIDcT1VBEhAcFnM2iS/xHzydXhTj6lNmvsvghHcFd+0
         k54cVLZcIzYxqDG1a3ZSdgM1oBRfWW1Tmf8JWin1eG/M2pZTDod9TowhcWVsoO+vnZIz
         GkRg==
X-Gm-Message-State: APjAAAXmMdsEgOOXFLSMTM+XRnck93N09vmdUoTVNMExweKuU5LEWIGJ
        cKj8dCiSztzkICV2Q/kaTW4tefQZAhjphg==
X-Google-Smtp-Source: APXvYqxtKMw3mpqg9MkK+btzkRfXxL2dYCYtp51GJLisHGAEAn91TGgbgVhc7vagrOCz20T/5PWL8Q==
X-Received: by 2002:a63:2a86:: with SMTP id q128mr7932044pgq.424.1552391598229;
        Tue, 12 Mar 2019 04:53:18 -0700 (PDT)
Received: from machine1 ([125.16.97.112])
        by smtp.gmail.com with ESMTPSA id k74sm23384040pfb.172.2019.03.12.04.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:53:17 -0700 (PDT)
Date:   Tue, 12 Mar 2019 17:23:13 +0530
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
To:     kernel-janitors@vger.kernel.org
Cc:     qla2xxx-upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Fix a small typo in qla_bsg.c
Message-ID: <20190312115313.GA12695@machine1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a minor formatting issue with comment section and a
typo for 'iiDMA' cmd in drivers/scsi/qla2xxx/qla_bsg.c

Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
---
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 17d42658ad9a..2353be988907 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1,4 +1,4 @@
-	/*
+/*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
  *
@@ -1354,7 +1354,7 @@ qla24xx_iidma(struct bsg_job *bsg_job)
 
 	if (rval) {
 		ql_log(ql_log_warn, vha, 0x704c,
-		    "iIDMA cmd failed for %8phN -- "
+		    "iiDMA cmd failed for %8phN -- "
 		    "%04x %x %04x %04x.\n", fcport->port_name,
 		    rval, fcport->fp_speed, mb[0], mb[1]);
 		rval = (DID_ERROR << 16);
