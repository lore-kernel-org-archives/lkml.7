Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333CAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027B620733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519147;
	bh=8a0LVrUeYJrCBt7mRarGDW1PqmFJFC3phvmzeydgbQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhRauGD6Qro7FxC555xePIQzYD9td5TnKupFCFujiCOGpCn4LhcD+CxfXC3/iNWIg
	 WtnMLGJbFpZJ1IcrOnfcimEgbmb5ZxZCihcsUbm/zECV5IaOpd+EnosIHXpMbwsbV2
	 CX5vzZa4XpjIz8u2r3WuP5YeP0KGJXTbZPVYsJ/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfLPR7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfLPR65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:58:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 579EA24687;
        Mon, 16 Dec 2019 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519136;
        bh=8a0LVrUeYJrCBt7mRarGDW1PqmFJFC3phvmzeydgbQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCwaOnQ3ZkUkibZq9eJFmdi6kBM5FKiwPabDPUT7BoP3WhAvRhjg8t9pvgOi1hy63
         18XjPbpzRZnxrlCuqqPN8fkAUcOcPMnK8Y+XEbhBVxZykiSOd95EO+valWJUlIhhQn
         6fzevqr+a02v+9me9BPjRwjDhToG+bd4w7l68CMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jiunn Chang <c0d1n61at3@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 210/267] media: cec.h: CEC_OP_REC_FLAG_ values were swapped
Date:   Mon, 16 Dec 2019 18:48:56 +0100
Message-Id: <20191216174914.050523306@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 806e0cdfee0b99efbb450f9f6e69deb7118602fc upstream.

CEC_OP_REC_FLAG_NOT_USED is 0 and CEC_OP_REC_FLAG_USED is 1, not the
other way around.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Jiunn Chang <c0d1n61at3@gmail.com>
Cc: <stable@vger.kernel.org>      # for v4.10 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/cec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -789,8 +789,8 @@ struct cec_event {
 #define CEC_MSG_SELECT_DIGITAL_SERVICE			0x93
 #define CEC_MSG_TUNER_DEVICE_STATUS			0x07
 /* Recording Flag Operand (rec_flag) */
-#define CEC_OP_REC_FLAG_USED				0
-#define CEC_OP_REC_FLAG_NOT_USED			1
+#define CEC_OP_REC_FLAG_NOT_USED			0
+#define CEC_OP_REC_FLAG_USED				1
 /* Tuner Display Info Operand (tuner_display_info) */
 #define CEC_OP_TUNER_DISPLAY_INFO_DIGITAL		0
 #define CEC_OP_TUNER_DISPLAY_INFO_NONE			1


