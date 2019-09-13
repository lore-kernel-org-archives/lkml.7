Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D553C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D676208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380466;
	bh=cAYq0ympfUen8R6ZbBkISddyBUJRqe7aP/kqbJU1yyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TSZ4BrwJ9+EgJscST0sHOuHIJ7Fq/tPTZVG7zi+teQ3Fk8zNZwZ+zVvFBXNaLbOpI
	 cjNtToqqEHp416mhLjYTu46BHmZjuRMmbrq296sP/s8PFIou3ewj54OJWBknMehkqM
	 5N4ImB9dAUGwT1W3tQUaR7dGuSAa6Ct05vh69xm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfIMNOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389499AbfIMNOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:14:22 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E01208C0;
        Fri, 13 Sep 2019 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380462;
        bh=cAYq0ympfUen8R6ZbBkISddyBUJRqe7aP/kqbJU1yyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLzgwH4tt5rsVJfV4Z+k6KTsBu8VvZzQnaY174JckJzBsCbgxGGfc4IC4uQO3Ojl5
         s3goeG+hAvFsS+aAorb/FDoVwxn/W9el6+wLEj1x4ZvWWr57qJnUzPxJwRpBasZ6Gt
         SJvlXWIPiwJaXIOsosur6PP8Mkvs0/WG8+C6FvvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/190] Drivers: hv: kvp: Fix the indentation of some "break" statements
Date:   Fri, 13 Sep 2019 14:05:04 +0100
Message-Id: <20190913130603.689971261@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d544c22d6951be3386ac59bb9a99c9bc566b3f09 ]

No functional change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv_kvp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 57715a0c81202..a7513a8a8e372 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -420,7 +420,7 @@ kvp_send_key(struct work_struct *dummy)
 				UTF16_LITTLE_ENDIAN,
 				message->body.kvp_set.data.value,
 				HV_KVP_EXCHANGE_MAX_VALUE_SIZE - 1) + 1;
-				break;
+			break;
 
 		case REG_U32:
 			/*
@@ -456,7 +456,7 @@ kvp_send_key(struct work_struct *dummy)
 			UTF16_LITTLE_ENDIAN,
 			message->body.kvp_set.data.key,
 			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
-			break;
+		break;
 
 	case KVP_OP_DELETE:
 		message->body.kvp_delete.key_size =
@@ -466,12 +466,12 @@ kvp_send_key(struct work_struct *dummy)
 			UTF16_LITTLE_ENDIAN,
 			message->body.kvp_delete.key,
 			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
-			break;
+		break;
 
 	case KVP_OP_ENUMERATE:
 		message->body.kvp_enum_data.index =
 			in_msg->body.kvp_enum_data.index;
-			break;
+		break;
 	}
 
 	kvp_transaction.state = HVUTIL_USERSPACE_REQ;
-- 
2.20.1



