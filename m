Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85820C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62844206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCLMtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:49:49 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39337 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfCLMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:49:48 -0400
Received: by mail-pg1-f180.google.com with SMTP id h8so1760327pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vzbfvBrn92WMz6cAbsYrHUf5pS6VG6R4c1ksSgO1hG8=;
        b=q3lgs2B4EWtsUNaxHdOdJlyYK51MWZcMUpMQ46q7If8Twjg5jB3kidGBO8qn2Vrpk+
         /C04g7nlwhP12Q/aSJzTzt4P8NJ56rsHJIUG27QZeKTbZ1iO8iL+7j4xlNaW2Uf5Bx4U
         gj4nuu+QNvhoDyoSboEr9f3Z59MRP+Nfx2Ad0nkTecDx7LF3MAXsUqfEor+sZGfCTunL
         kL+uTB4smu687H8NqlNDwj2pcJlvszJtnpIJ1FmNQeGUC+kBywiAkOs9RqRgCKk7OBVg
         10zdr/tFScPcZrL6gBwZuzm1H/ZtsI0dDv61xEqHzcD3c+IaqAMo1ItlX+rVb/H3N7xx
         85kg==
X-Gm-Message-State: APjAAAX76Mwma5vtfg/swxzsG1HuVQYdh2z5YXwU9zLZD/7Ymft2f6T3
        o8IGFkBGBgPJs/ppPjtPqmPPvQ==
X-Google-Smtp-Source: APXvYqziZ0PB/dT+6D/OlGnKk8LkQB8bRhXFlKK8gLRPN2JD3r6CodSYTUJWMoalbAcOfGTKtf0vew==
X-Received: by 2002:aa7:80c8:: with SMTP id a8mr39439706pfn.193.1552394987967;
        Tue, 12 Mar 2019 05:49:47 -0700 (PDT)
Received: from machine1 ([125.16.97.127])
        by smtp.gmail.com with ESMTPSA id e14sm15553254pga.61.2019.03.12.05.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:49:47 -0700 (PDT)
Date:   Tue, 12 Mar 2019 18:19:37 +0530
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
To:     kernel-janitors@vger.kernel.org
Cc:     qla2xxx-upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        dan.carpenter@oracle.com
Subject: [PATCH 0/2] scsi: qla2xxx: Fix for a formatting issue and typo in
 qla_bsg.c
Message-ID: <20190312124937.GA13922@machine1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes below two formatting/typos in qla_bsg.c:
1. Corrected alignment at the start of comment section
2. Fixed 'iiDMA' cmd spelling

Thanks,
Milan.
---
 drivers/scsi/qla2xxx/qla_bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
