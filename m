Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFADC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC72073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080126;
	bh=4NKs7tQw3LXnO0L0L8lRwGZzSBngV+dsz24ny3qk0IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FmfRpKk7r88o19jdAbVWdEDL5mr00e8s4bGas8l4fp+1B1o5ePsqMfTvgqXAmbjBs
	 5n7hD+X8UbnCElx7ksmnjlUvtC0HnSslTp3eDmfel4eTfuGw1gkW0Wm9rNSwfaCY/+
	 R0F1hMM5/XBcoKU1qlmTKmEoZgRaTyyokq+t77xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfLKQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfLKPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4C324654;
        Wed, 11 Dec 2019 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077200;
        bh=4NKs7tQw3LXnO0L0L8lRwGZzSBngV+dsz24ny3qk0IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWpoOmkzC9NmI++1zjU25fEk/4L1PrkzMyrVJKAXfv4xYljCgy3GCo/QKRNeq8kuv
         ntE0C3DJJxLuX6DhyAuAv+7uLA+GY0ptgFC/fKsN6s0i0WNulrPImfybXGZ6Xnqzqk
         xnosCMKUNa8LY/OrouMv8qfr4QZPNJVPGUeL7XHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.3 055/105] Input: synaptics - switch another X1 Carbon 6 to RMI/SMbus
Date:   Wed, 11 Dec 2019 16:05:44 +0100
Message-Id: <20191211150242.914314392@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit fc1156f373e3927e0dcf06678906c367588bfdd6 upstream.

Some Lenovo X1 Carbon Gen 6 laptops report LEN0091. Add this
to the smbus_pnp_ids list.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191119105118.54285-2-hverkuil-cisco@xs4all.nl
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -172,6 +172,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
+	"LEN0091", /* X1 Carbon 6 */
 	"LEN0092", /* X1 Carbon 6 */
 	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */


