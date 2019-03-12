Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E306C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9C206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412332;
	bh=kY9xzmjhC9gdi+s7kG2k0dSrufwK2R+XjalQC/Bz4FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ayLFrYC6/oOMvrXeT1wMVCrSIuycj4PDCysToYkS5K1YVD6kXhUbFyUjrdoLKveOr
	 VQNqWJPiD04UdPib/p+l28lszXRafd9sKVdXvEpSGhkXYcEd1+qc32J1d689dm9f2V
	 AXqNTPgjwsWDjgMq7jqcT26+ERhhWp+rDTCSVnWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfCLRQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfCLRPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:25 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A42206DF;
        Tue, 12 Mar 2019 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410925;
        bh=kY9xzmjhC9gdi+s7kG2k0dSrufwK2R+XjalQC/Bz4FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnRoA8Ul5+8Ig7q6lqLdF3n1mQt6VDILatVdsMbDLSGsFcNpxg9/i8+t93kqI7fbC
         Tqd9LRW349caqgnguNKhbPN+5Pxfj2UKCKNrJeBOyR4ZVWbZ8qJGlRwIG3PsAee9+V
         b0+wuhugyIoXXi8T1KFyn/Co9BqLr70BTFx2PkXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Batts <vbatts@hashbangbash.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 124/149] Input: elan_i2c - add id for touchpad found in Lenovo s21e-20
Date:   Tue, 12 Mar 2019 10:09:02 -0700
Message-Id: <20190312170359.817831361@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1337,6 +1337,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0601", 0 },
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },
 	{ "ELAN0608", 0 },


