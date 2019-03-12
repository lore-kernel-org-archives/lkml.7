Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15752206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCLMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:53:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36268 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCLMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:53:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id n22so1777404pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:signed-off-by:user-agent;
        bh=lunRezebGiR7uZrsiHZUiHELSYvvQhQ7jo/sNtO0vrw=;
        b=lIseYHd1HWPBLuUUHJGFbtqAdbKY0bodom17bRMe8LIeCKYEVTMmbL5qf8a60aZx1C
         nTIBGFeXkbnxouFRvi+B59lmyv6waOLwlaEFfUKLEvZDKJYsriSESM68CeR18K7yS2q0
         xVYYsP7DqhR9cUBQbgeUeKgwfO4wI0kkOUd3kl7qJQLT1nWiuCSqlai5EareZGXBkskD
         BjqKAA7pkCo7O2/jdFQHq6lJaCeSwqlBUSCayTcAr4hqmMvX449WNxRunXfiCdc/fqre
         frhlrHjzJEXBGl9Jlb7ib1F6rK9LaSY7SIJqD29iENKl5xKDmHY2n9+SOxcL6DzXBa2f
         Sx7g==
X-Gm-Message-State: APjAAAV4bmFeBPe2fmXpDJGtyYUGeS3uzJIYm6JvNKCxF0Nowj/Eg33Y
        8m1ZZmZvNcS/YCuXOLTbJ/gcrQ==
X-Google-Smtp-Source: APXvYqwHdRfm9XaqBSZnoI4e96YpcGzGqO7mTAV7YrIDI4YByBR3WvQDTH3UU489wCLixPIfJ/jwmA==
X-Received: by 2002:a65:4147:: with SMTP id x7mr35066044pgp.54.1552395200795;
        Tue, 12 Mar 2019 05:53:20 -0700 (PDT)
Received: from machine1 ([125.16.97.124])
        by smtp.gmail.com with ESMTPSA id u26sm2270549pfh.42.2019.03.12.05.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:53:20 -0700 (PDT)
Date:   Tue, 12 Mar 2019 18:23:15 +0530
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
To:     kernel-janitors@vger.kernel.org
Cc:     qla2xxx-upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        dan.carpenter@oracle.com
Subject: [PATCH 2/2] scsi: qla2xxx: Fix a small typo in qla_bsg.c
Message-ID: <20190312125315.GA13975@machine1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a typo for 'iiDMA' cmd in qla_bsg.c

Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 17d42658ad9a..f2b95f11a71c 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1354,7 +1354,7 @@ qla24xx_iidma(struct bsg_job *bsg_job)
 
 	if (rval) {
 		ql_log(ql_log_warn, vha, 0x704c,
-		    "iIDMA cmd failed for %8phN -- "
+		    "iiDMA cmd failed for %8phN -- "
 		    "%04x %x %04x %04x.\n", fcport->port_name,
 		    rval, fcport->fp_speed, mb[0], mb[1]);
 		rval = (DID_ERROR << 16);
