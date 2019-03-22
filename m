Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85126C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484732183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260296;
	bh=UWGX2Q5l0E/YCTEfZIY+E8MF7w1257p09VPp0YHkYaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=etXHLQELTwpGmSvhgXUyx1R1q3+gPWgBLx3ln7SthkvJk0whnG1j11r7lh6FgwMgB
	 VZhKkC97HZXk4NMlzcmoQWBOxSuw62AIz5oiirKxprA7MA8zonfp4xObu4sTVAUHTT
	 CQBJrOcyzlRX745tk8n71TYB11gjTrJACCzaVr6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfCVNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfCVLcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6750621925;
        Fri, 22 Mar 2019 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254364;
        bh=UWGX2Q5l0E/YCTEfZIY+E8MF7w1257p09VPp0YHkYaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgSpJ+HdUfWnBdGc7FM8lCpGeE1pMKdtX6ETzTwpzmffe/AxAiA7df9aUnW1kc4Xq
         AoqkAfl10FNHqquJ4yPcHB4fXAVipLcCg7UOlKlBdBgHlUrUEFW6f3Qf+wIeZ35Rqh
         M0dD9+Joma1XPXVuFCtNRga2JmVFslXgNb4EU3WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Batts <vbatts@hashbangbash.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 113/230] Input: elan_i2c - add id for touchpad found in Lenovo s21e-20
Date:   Fri, 22 Mar 2019 12:14:11 +0100
Message-Id: <20190322111244.570415697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Batts <vbatts@hashbangbash.com>

commit e154ab69321ce2c54f19863d75c77b4e2dc9d365 upstream.

Lenovo s21e-20 uses ELAN0601 in its ACPI tables for the Elan touchpad.

Signed-off-by: Vincent Batts <vbatts@hashbangbash.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1241,6 +1241,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0601", 0 },
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },
 	{ "ELAN0608", 0 },


