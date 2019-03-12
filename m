Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3385D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCLMvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:51:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37970 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCLMvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:51:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id m2so1766711pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:signed-off-by:user-agent;
        bh=M0F1IAOHn8jTKKI33RgcjP5b3l7ktt3K1JE+/OVlhMo=;
        b=UVBkb56m3iMXbxvrRpIUl2mosVvtA0jSPud5ALTERNI58TyqoYNREPpckWIEiTokfA
         vqZz7WNHVVqTuRcLVio0uPDDzI5Z7vCQY2iU4axQr8Q19UH5haCSfj5qmR2WXuGi81M+
         r5222//k88nBXc7q2w2S8oqVcdcXKgnMIfwMI2njcMGQXSQ14lHQfqZWI9bDDNXdnzvx
         /1lPa3fRJG3LV3rnIjUekAfCQEmPhIoA+lmuRAqU84HvtH4c7KyPFMujToOLMTng65b1
         FfsE8+BZXMnudgseCRh12rgFESiRe3KMm8R7UW+r90ebAz9VXLlb//LGTy12OFqo7u43
         Wx/g==
X-Gm-Message-State: APjAAAUIjVkK0kCmmx5h5cecPAK1qEenvnqz3U3AzELZB2Q33aXSrgVB
        lwnP/mjppJw0hwmZCDNUKV3xDhLD8Qw9BA==
X-Google-Smtp-Source: APXvYqwz9XSD6xX7CDGsBLWpZIqNg1wmJmDPkLtWDHoUcuSMk1ymGE4CaIi2FuI8IzsrXvsbDHOHBg==
X-Received: by 2002:a63:160d:: with SMTP id w13mr34464654pgl.85.1552395077333;
        Tue, 12 Mar 2019 05:51:17 -0700 (PDT)
Received: from machine1 ([125.16.97.113])
        by smtp.gmail.com with ESMTPSA id x8sm29096467pfe.1.2019.03.12.05.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:51:16 -0700 (PDT)
Date:   Tue, 12 Mar 2019 18:21:11 +0530
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
To:     kernel-janitors@vger.kernel.org
Cc:     qla2xxx-upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        dan.carpenter@oracle.com
Subject: [PATCH 1/2] scsi: qla2xxx: Fix comment alignment in qla_bsg.c
Message-ID: <20190312125111.GA13943@machine1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a minor formatting issue with comment section in qla_bsg.c

Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 17d42658ad9a..9bd41b5fc279 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1,4 +1,4 @@
-	/*
+/*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
  *
