Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE2AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6C8206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739737;
	bh=lTZt4r7kCi74yRtU/qLbL73nW1wDah+lru5/+Pv60Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJvPqV+dYRt7b552s5zO+PCv4FWz/OrZXT26oxTxyLG+swa7q1+HMz83q5V+r2cBY
	 9e7Dl4BySiNgXgC+0SOWl/2HjL121iHiNGo2aWHnBMJGctD3QrNcIeLY8gIkDuNPKm
	 rcWnvdTI1hWkovwI+iY6ecqmdAPJJx2iN3Qjsrpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbfHBJzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406567AbfHBJzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:55:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40E42064A;
        Fri,  2 Aug 2019 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739733;
        bh=lTZt4r7kCi74yRtU/qLbL73nW1wDah+lru5/+Pv60Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vm6ZeaH2lAtyc0+XGL7+9CnAqwXVEubVuguM/Wt6eOtw1DiWcxfDEW57PBW9ZgoLM
         lf1ppt+hL1Cfxfs1raeIJm3tNBQzn6sv4UplX39tl4GKhGkkl8UEtqLf9yq9VrTKKd
         CKECc1DYkQZuYB+6y4cICUIhYfD5YG4Ry+MQCvBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com,
        Fabio Estevam <festevam@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 12/32] ath10k: Change the warning message string
Date:   Fri,  2 Aug 2019 11:39:46 +0200
Message-Id: <20190802092105.531633213@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092101.913646560@linuxfoundation.org>
References: <20190802092101.913646560@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

commit 265df32eae5845212ad9f55f5ae6b6dcb68b187b upstream.

The "WARNING" string confuses syzbot, which thinks it found
a crash [1].

Change the string to avoid such problem.

[1] https://lkml.org/lkml/2019/5/9/243

Reported-by: syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1025,7 +1025,7 @@ static int ath10k_usb_probe(struct usb_i
 	}
 
 	/* TODO: remove this once USB support is fully implemented */
-	ath10k_warn(ar, "WARNING: ath10k USB support is incomplete, don't expect anything to work!\n");
+	ath10k_warn(ar, "Warning: ath10k USB support is incomplete, don't expect anything to work!\n");
 
 	return 0;
 


