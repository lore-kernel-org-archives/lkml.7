Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFDC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554982081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098975;
	bh=2fcdwPav0b+daDdMQZAj1lg9khaMKU8brF9jrKOJOdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ukQEETBYNoEcPJqqN6J7bW6iVIXbGFcjEDMXxbnvr67sZVy3w+17905ZBvEwfuKn
	 tcSupjvmya5LgEQFDyTFf9LYt80fbabSr7bzSgzeBYgKoJe1GssOjioDGb4jCgEOlV
	 bi5kqUzcTu8i2hnLjQQVkWG2zFCkjI4AtymIMpjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfFIQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbfFIQtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:49:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4CA2081C;
        Sun,  9 Jun 2019 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098971;
        bh=2fcdwPav0b+daDdMQZAj1lg9khaMKU8brF9jrKOJOdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXmco7zxPjvkNIAV3FpFsjM4PTal0SQ48Qe2WPus5pBBgSx1DMBSqWZFjBlj+atcQ
         8rVwpi4eWo6aqUPQb94fMNt4GnKQXgXEwg7hwWWQDqfGRHkoV87OV79tUaEeKJl/yM
         Ue6Z1Zxcyf/PnN1lZzWpwYAb1t1cHBqCHcl988yM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryan Pavlik <ryan.pavlik@collabora.com>,
        Daniel Stone <daniels@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 4.19 41/51] drm: add non-desktop quirks to Sensics and OSVR headsets.
Date:   Sun,  9 Jun 2019 18:42:22 +0200
Message-Id: <20190609164129.993540122@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Pavlik <ryan.pavlik@collabora.com>

commit 29054230f3e11ea818eccfa7bb4e4b3e89544164 upstream.

Add two EDID vendor/product pairs used across a variety of
Sensics products, as well as the OSVR HDK and HDK 2.

Signed-off-by: Ryan Pavlik <ryan.pavlik@collabora.com>
Signed-off-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20181203164644.13974-1-ryan.pavlik@collabora.com
Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -212,6 +212,12 @@ static const struct edid_quirk {
 
 	/* Sony PlayStation VR Headset */
 	{ "SNY", 0x0704, EDID_QUIRK_NON_DESKTOP },
+
+	/* Sensics VR Headsets */
+	{ "SEN", 0x1019, EDID_QUIRK_NON_DESKTOP },
+
+	/* OSVR HDK and HDK2 VR Headsets */
+	{ "SVR", 0x1019, EDID_QUIRK_NON_DESKTOP },
 };
 
 /*


