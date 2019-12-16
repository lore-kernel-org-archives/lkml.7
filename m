Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6BDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B422082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522035;
	bh=TtcWSKnRs5jJmTfRltWPXQ/eCifLbm2JfGqcP6Kw5xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wTXBLrCgirXp47ff1ebyuxgwsKi3VuZpS3zE6f4oOVF4sA++vw1ZkXLgnR/4qvC88
	 r6sOC83C/9Ws5qLMz+35xFH6jxRf5iUtRVM6OsV/sZTrGBE3oJCXnFl2zEBRr+5iZN
	 Pu530QZzi4Hw3Da+AHJMt9uoeVDEYPswTS9XNb6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfLPSrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfLPRzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:55:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2756421582;
        Mon, 16 Dec 2019 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518932;
        bh=TtcWSKnRs5jJmTfRltWPXQ/eCifLbm2JfGqcP6Kw5xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/wD8qOgtJWBOlbjTeFFode4c3EXH5pL0rk2QV27Vs6b2e1EZ/LeP7wBZu9D5HGmD
         ip/XR5UzdXsqeq6WIdvtVS9jrjJZNLAgp3X69DszvL0m0RsseaQY+pBNYcgbMAyuwF
         Bbl2K8i4aUzVDRpkUKUTdPwb1dD3AQIb8sJJ8Trk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 126/267] Input: synaptics - switch another X1 Carbon 6 to RMI/SMbus
Date:   Mon, 16 Dec 2019 18:47:32 +0100
Message-Id: <20191216174903.620762215@linuxfoundation.org>
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
@@ -175,6 +175,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
+	"LEN0091", /* X1 Carbon 6 */
 	"LEN0092", /* X1 Carbon 6 */
 	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */


