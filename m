Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B1D213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414399;
	bh=Fh1G7OCHOvY5Dmfqvg2XTeJWxfQx7mejk2ent0gJmjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R8TEBEkn/mk0kJPB/fGYs+/2JUYaCR3GU3isnzo8/qVYKzHw3bNGW+20gRL4I5Gmy
	 TbBLU0/nuUiO0Wd3uXR2i6ozDf1u4ClJweCp5NDSoS8RsfBsPoLigj6al8DjE4z1gj
	 ebJCdYIf1qEounHagtJQHiDtna2hoieMrrVTuxY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCLRLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfCLRL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005B32173C;
        Tue, 12 Mar 2019 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410688;
        bh=Fh1G7OCHOvY5Dmfqvg2XTeJWxfQx7mejk2ent0gJmjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqQ639CENcSCA1stpreQqIWz+FNC2Zpq7oVHm2OvEnqHMQ5jmHcWf9cC8yEaq3lJD
         L3mHwMZqrHn8ys4x2KpVX4DC0i4H6nUlCBLeMYtXOVCM3NFomOA2b8DvXz0OsVZGF8
         /kquoJ2OSLdl/8g8mcCvBM5ntwjWzk5jR/oO+vvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Batts <vbatts@hashbangbash.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.0 03/25] Input: elan_i2c - add id for touchpad found in Lenovo s21e-20
Date:   Tue, 12 Mar 2019 10:08:41 -0700
Message-Id: <20190312170403.852278073@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


