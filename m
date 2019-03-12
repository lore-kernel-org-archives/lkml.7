Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3856C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE4214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411271;
	bh=Nk7HOX40D5riXI/6e081zfNdyd6T8ePaYrLSQMD+QbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdDFU90FipoXlum2B7+sAmT5idSM58NtZT9WWyB4JWWGKdoLrPhglm1+ooSX4bDDV
	 /9Shr/NGdMoQwGAL0tAFZenJ7gvtvW/YUM+E0WFvBmU9D6L+hppar1l6884/cHNi1O
	 tDZhBMZTSqrWsj8DUOpzxn9XIVz8Ho3FwK6INf8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfCLRVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbfCLRSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:16 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB7D21855;
        Tue, 12 Mar 2019 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411096;
        bh=Nk7HOX40D5riXI/6e081zfNdyd6T8ePaYrLSQMD+QbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rFAnQeA8flYRu4A89QoyHYcaN1EM4cCtz7xZWda0XSFVXQm95HeX+Lhc+DZ6XY3M
         D0fujSoiVOT9DTtk9VAWrxE/X6npPdAoLAcYZkyDEHYN+k/KnKibcyOma1joTI6IC5
         kDK+6qzeWpdVmLbKnTBZU6m4TQZ1PnVzwpcLIv7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Batts <vbatts@hashbangbash.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 85/96] Input: elan_i2c - add id for touchpad found in Lenovo s21e-20
Date:   Tue, 12 Mar 2019 10:10:43 -0700
Message-Id: <20190312171040.931045580@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


